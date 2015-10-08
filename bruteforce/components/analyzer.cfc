<cfcomponent name="analyzer">

	<cfset variables.executiontime = ''>
	<cfset variables.filecount = ''>
	<cfset variables.filesize = ''>
	<cfset variables.name = ''>
	<cfset variables.stParameters = StructNew()>
	<cfset variables.stParameters.directory = ''>
	<cfset variables.stParameters.filter_file_include = ''>
	<cfset variables.stParameters.filter_file_exclude = ''>
	<cfset variables.stParameters.filter_directory_include = ''>
	<cfset variables.stParameters.filter_directory_exclude = ''>
	<cfset variables.stParameters.rules = ''>
	<cfset variables.stParameters.recurse = ''>
	<cfset variables.qFiles = ''>
	<cfset variables.stFileContent = StructNew()>
	<cfset variables.stParsedFiles = StructNew()>
	<cfset variables.qResults = QueryNew('uuid,file,rulename,rule,rulefile,type,message,line,position,code','varchar,varchar,varchar,varchar,varchar,varchar,varchar,integer,integer,varchar')>
	<cfset variables.stReport = StructNew()>
	<cfset variables.identifier = CreateUUID()>

	<cffunction name="init" returntype="any" output="false" access="public" hint="I initialise the Analyzer">
		<cfargument name="name" type="string" required="true">
		<cfargument name="directory" type="string" required="true">
		<cfargument name="filter_file_include" type="string" required="false" default="">
		<cfargument name="filter_file_exclude" type="string" required="false" default="">
		<cfargument name="filter_directory_include" type="string" required="false" default="">
		<cfargument name="filter_directory_exclude" type="string" required="false" default="">
		<cfargument name="rules" type="string" required="true">
		<cfargument name="recurse" type="string" required="false" default="true">
		
		<cfset var wddxData = ''>
		
		<cfset variables.stParameters.directory = arguments.directory>
		<cfset variables.stParameters.filter_file_include = arguments.filter_file_include>
		<cfset variables.stParameters.filter_file_exclude = arguments.filter_file_exclude>
		<cfset variables.stParameters.filter_directory_include = arguments.filter_directory_include>
		<cfset variables.stParameters.filter_directory_exclude = arguments.filter_directory_exclude>
		<cfset variables.stParameters.rules = arguments.rules>
		<cfset variables.stParameters.recurse = arguments.recurse>
		<cfset variables.name = arguments.name>
		<cfset variables.qFiles = getFilesToAnalyze()>
		
		<cfwddx action="cfml2wddx" input="#variables.stParameters#" output="wddxData">
		
		<cfquery datasource="#request.stSettings.Datasource#">
			INSERT INTO bf_reports (name,filecount,parameters,dt_created)
			VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.identifier#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.filecount#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#wddxData#">,
					#now()#)
		</cfquery>
		<cfquery datasource="#request.stSettings.Datasource#" name="qGetReportID">
			SELECT id FROM bf_reports
			WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.identifier#">
		</cfquery>
		<cfset variables.identifier = qGetReportID.id>
		<cfquery datasource="#request.stSettings.Datasource#" name="qGetReportID">
			UPDATE bf_reports
			SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.name#">
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.identifier#">
		</cfquery>
		
		<cfreturn this>
	</cffunction>

	<cffunction name="run" returntype="void" output="false" access="private" hint="I run the Analyzer">
		
		<cfset var sFileContent = ''>
		<cfset var idx = ''>
		<cfset var sRulefile = ''>
		<cfset var sRule = ''>
		<cfset var oThreadPool = ''>
		<cfset var aThreads = ''>
		<cfset var qThreadResult = ''>
		<cfset var sCurrentFile = ''>
		
		<cfset variables.executiontime = GetTickCount()>
		
		<cfloop query="variables.qFiles">
		
			<cfif request.stSettings.bUseThreading>
				<cfset oThreadPool = createObject("component","Concurrency.TaskPool").init()>
				<cfset aThreads = ArrayNew(1)>
			</cfif>
			
			<cfset sCurrentFile = '#directory#/#name#'>
		
			<cffile action="read" file="#sCurrentFile#" variable="sFileContent">
			<cfset variables.stFileContent[sCurrentFile] = sFileContent>
			<cfset variables.stFileContent[sCurrentFile] = replacenocase(variables.stFileContent[sCurrentFile],'#chr(10)##chr(10)#','#chr(10)# #chr(10)#','ALL')>
			<cfset variables.stFileContent[sCurrentFile] = replacenocase(variables.stFileContent[sCurrentFile],'#chr(10)##chr(10)#','#chr(10)# #chr(10)#','ALL')>
			<cfset parseFile(sCurrentFile)>
			
			<cfloop list="#variables.stParameters.rules#" index="idx">

				<cfif ListLen(idx,':') EQ 2>
					<cfset sRulefile = ListFirst(idx,':')>
					<cfset sRule = ListLast(idx,':')>
				<cfelse>
					<cfset sRulefile = idx>
					<cfset sRule = ''>
				</cfif>
				
				<cfif request.stSettings.bUseThreading>
					<cfset stArguments = StructNew()>
					<cfset stArguments.file = sCurrentFile>
					<cfset stArguments.content = variables.stFileContent[sCurrentFile]>
					<cfset stArguments.rulefile = sRulefile>
					<cfset stArguments.rule = sRule>
					<cfset ArrayAppend(aThreads,oThreadPool.addTask(task="bruteforce.components.ruleinvoker",method="invokeRule",argumentCollection=stArguments))>
				<cfelse>
					<cfset oRuleInvoker = CreateObject("component","bruteforce.components.ruleinvoker")>
					<cfset qRuleResult = oRuleInvoker.invokeRule(sCurrentFile,variables.stFileContent[sCurrentFile],sRulefile,sRule)>
					<cfset qRuleResult = parseLineNumbers(qRuleResult)>
					<cfset qRuleResult = getCodeArea(qRuleResult)>
					<cfset addToResultset(qRuleResult)>
				</cfif>

			</cfloop>
			
			<cfif request.stSettings.bUseThreading>
				<cfset oThreadPool.run()>
				<cfset oThreadPool.join()>
				<cfloop from="1" to="#ArrayLen(aThreads)#" index="idx">
					<cfset qThreadResult = oThreadPool.get(aThreads[idx])>
					<cfif qThreadResult.recordcount>
						<cfset qThreadResult = parseLineNumbers(qThreadResult)>
						<cfset qThreadResult = getCodeArea(qThreadResult)>
						<cfset addToResultset(qThreadResult)>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset StructDelete(variables.stFileContent,sCurrentFile)>
			<cfset StructDelete(variables.stParsedFiles,sCurrentFile)>

		</cfloop>
		
		<cfset variables.executiontime = GetTickCount() - variables.executiontime>
	</cffunction>

	<cffunction name="getFilesToAnalyze" returntype="query" output="false" access="private" hint="I get the files to analyze">
		
		<cfset var stFilters = StructNew()>
		<cfset var idx = ''>
		<cfset var qGetFiles = ''>
		<cfset var qGetFilesFiltered = ''>
		<cfset var qGetFileSizes = ''>

		<cfset stFilters.file_include = StructNew()>
		<cfloop list="#variables.stParameters.filter_file_include#" index="idx" delimiters=";">
			<cfset stFilters.file_include[idx] = replace(idx,'*','%','ALL')>
		</cfloop>

		<cfset stFilters.file_exclude = StructNew()>
		<cfloop list="#variables.stParameters.filter_file_exclude#" index="idx" delimiters=";">
			<cfset stFilters.file_exclude[idx] = replace(idx,'*','%','ALL')>
		</cfloop>

		<cfset stFilters.directory_include = StructNew()>
		<cfloop list="#variables.stParameters.filter_directory_include#" index="idx" delimiters=";">
			<cfset stFilters.directory_include[idx] = replace(idx,'*','%','ALL')>
		</cfloop>

		<cfset stFilters.directory_exclude = StructNew()>
		<cfloop list="#variables.stParameters.filter_directory_exclude#" index="idx" delimiters=";">
			<cfset stFilters.directory_exclude[idx] = replace(idx,'*','%','ALL')>
		</cfloop>
		
		<cfdirectory name="qGetFiles" action="list" directory="#variables.stParameters.directory#" recurse="#variables.stParameters.recurse#">
		
		<cfquery dbtype="query" name="qGetFilesFiltered">
			SELECT * FROM qGetFiles
			WHERE type = 'File'
			<cfif NOT StructIsEmpty(stFilters.file_include)>
				AND (
				<cfset bDoOr = false>
				<cfloop collection="#stFilters.file_include#" item="idx">
					<cfif bDoOr>OR </cfif>
					<cfset bDoOr = true>
					name LIKE '#stFilters.file_include[idx]#'
				</cfloop>
				)
			</cfif>
			<cfif NOT StructIsEmpty(stFilters.file_exclude)>
				AND NOT (
				<cfset bDoOr = false>
				<cfloop collection="#stFilters.file_exclude#" item="idx">
					<cfif bDoOr>OR </cfif>
					<cfset bDoOr = true>
					name LIKE '#stFilters.file_exclude[idx]#'
				</cfloop>
				)
			</cfif>
			<cfif NOT StructIsEmpty(stFilters.directory_include)>
				AND (
				<cfset bDoOr = false>
				<cfloop collection="#stFilters.directory_include#" item="idx">
					<cfif bDoOr>OR </cfif>
					<cfset bDoOr = true>
					directory LIKE '#stFilters.directory_include[idx]#'
				</cfloop>
				)
			</cfif>
			<cfif NOT StructIsEmpty(stFilters.directory_exclude)>
				AND NOT (
				<cfset bDoOr = false>
				<cfloop collection="#stFilters.directory_exclude#" item="idx">
					<cfif bDoOr>OR </cfif>
					<cfset bDoOr = true>
					directory LIKE '#stFilters.directory_exclude[idx]#'
				</cfloop>
				)
			</cfif>
		</cfquery>
		
		<cfquery dbtype="query" name="qGetFileSizes">
			SELECT SUM(size) AS sizesummary
			FROM qGetFilesFiltered
		</cfquery>
		
		<cfset variables.filecount = qGetFilesFiltered.recordcount>
		<cfset variables.filesize = qGetFileSizes.sizesummary>
	
		<cfreturn qGetFilesFiltered>
	</cffunction>

	<cffunction name="getAll" returntype="struct" output="false" access="public" hint="I return the variables scope">
		<cfreturn variables>
	</cffunction>

	<cffunction name="getFiles" returntype="query" output="false" access="private" hint="I return the files to analyze">
		<cfreturn variables.qFiles>
	</cffunction>

	<cffunction name="getFileSizes" returntype="numeric" output="false" access="public" hint="I return the size of the files to analyze">
		<cfreturn variables.filesize>
	</cffunction>

	<cffunction name="getFileCount" returntype="numeric" output="false" access="public" hint="I return the number of files to analyze">
		<cfreturn variables.filecount>
	</cffunction>

	<cffunction name="getExecutionTime" returntype="numeric" output="false" access="private" hint="I return the executiontime">
		<cfreturn variables.executiontime>
	</cffunction>

	<cffunction name="getParameters" returntype="struct" output="false" access="private" hint="I return the parameters of this run">
		<cfreturn variables.stParameters>
	</cffunction>

	<cffunction name="getVariables" returntype="struct" output="false" access="private" hint="I return the parameters of this run">
		<cfreturn variables>
	</cffunction>

	<cffunction name="generateReport" returntype="string" output="false" access="public" hint="I save the reportdata">
		<cfset run()>
	
		<cfquery datasource="#request.stSettings.Datasource#">
			UPDATE bf_reports
			SET executiontime = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.executiontime#">
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.identifier#">
		</cfquery>
		
		<cfreturn variables.identifier>
	</cffunction>

	<cffunction name="parseFile" returntype="void" output="false" access="private" hint="I remove the unused filecontents">
		<cfargument name="file" type="string" required="true">
		
		<cfset var idx = ''>
		<cfset var stRowData = ''>
		<cfset var iCurrentPos = 1>
		<cfset var iCurrentLine = 1>
		<cfset var wddxCode = ''>

		<cfset variables.stParsedFiles[arguments.file] = ArrayNew(1)>

		<cfloop list="#variables.stFileContent[arguments.file]#" index="idx" delimiters="#chr(10)#">
			<cfset stRowData = StructNew()>
			<cfset stRowData.data = idx>
			<cfset stRowData.len = len(idx)>
			<cfset stRowData.start = iCurrentPos>
			<cfset stRowData.end = stRowData.start + stRowData.len>
			<cfset stRowData.line = iCurrentLine>
			<cfset ArrayAppend(variables.stParsedFiles[arguments.file],stRowData)>
			<cfset iCurrentPos = iCurrentPos + stRowData.len + 1>
			<cfset iCurrentLine = iCurrentLine + 1>
		</cfloop>
	</cffunction>
	
	<cffunction name="getCodeArea" returntype="query" output="false" access="private" hint="I get the code area">
		<cfargument name="results" type="query" required="true">
		<cfargument name="rows" type="numeric" required="false" default="2">
		
		<cfset var aCode = ArrayNew(1)>
		<cfset var idx = ''>
		<cfset var wddxData = ''>
		
		<cfloop query="arguments.results">
			<cfif line GT 0>
				<cfset aCode = ArrayNew(1)>
				<cfloop from="1" to="#arguments.rows*2+1#" index="idx">
					<cfset iCurrentLine = line-arguments.rows-1+idx>
					<cfif iCurrentLine GT 0 AND iCurrentLine LTE ArrayLen(variables.stParsedFiles[file])>
						<cfset ArrayAppend(aCode,variables.stParsedFiles[file][iCurrentLine])>
					</cfif>
				</cfloop>
				<cfwddx action="cfml2wddx" input="#aCode#" output="wddxData">
				<cfset QuerySetCell(arguments.results,'code',wddxData,currentrow)>
			</cfif>
		</cfloop>
		
		<cfreturn arguments.results>
	</cffunction>
	
	<cffunction name="parseLineNumbers" returntype="query" output="false" access="private" hint="I remove the unused filecontents">
		<cfargument name="results" type="query" required="true">
		
		<cfset var idx = ''>
		<cfset var iNewLine = ''>
		<cfset var iNewPos = ''>

		<cfloop query="arguments.results">
			<cfloop from="1" to="#ArrayLen(variables.stParsedFiles[file])#" index="idx">
				<cfif position GTE variables.stParsedFiles[file][idx].start AND position LTE variables.stParsedFiles[file][idx].end>
					<cfset QuerySetCell(arguments.results,'line',idx,currentrow)>
					<cfset QuerySetCell(arguments.results,'position',position+1-variables.stParsedFiles[file][idx].start,currentrow)>
				</cfif>
			</cfloop>
		</cfloop>
		
		<cfreturn arguments.results>
	</cffunction>
	
	<cffunction name="addToResultset" returntype="void" output="false" access="private" hint="I add a result to the resultset">
		<cfargument name="results" type="query" required="true">
		
		<cfloop query="arguments.results">
			<cfquery datasource="#request.stSettings.Datasource#">
				INSERT INTO bf_report_results (report_id,type,rule,rulefile,rulename,file,line,position,message,code)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.identifier#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#rule#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#rulefile#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#rulename#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#file#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#line#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#position#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#message#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#code#">)
			</cfquery>
		</cfloop>
	</cffunction>

</cfcomponent>