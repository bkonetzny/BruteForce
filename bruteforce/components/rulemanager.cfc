<cfcomponent name="rulemanager">
	
	<cfset variables.directory = ''>

	<cffunction name="init" returntype="any" output="false" access="public" hint="I initialise the RuleManager">
		<cfargument name="directory" type="string" required="true">
		
		<cfset variables.directory = arguments.directory>
		
		<cfreturn this>
	</cffunction>

	<cffunction name="getRuleFiles" returntype="query" output="false" access="public" hint="I return the rules">
		<cfargument name="id" type="string" required="false" default="">
		
		<cfset var qRules = ''>
		<cfset var qRulesCFC = ''>
		<cfset var qRulesCFM = ''>
		<cfset var qRulesCFML = ''>
		<cfset var qRulesXML = ''>
		
		<cfdirectory name="qRules" action="list" directory="#variables.directory#">
		
		<cfif qRules.recordcount>
			<cfquery name="qRules" dbtype="query">
				SELECT * FROM qRules
				<cfif len(arguments.id)>
					WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.id#">
				<cfelse>
					WHERE name LIKE '%.cfc'
					OR name LIKE '%.cfm'
					OR name LIKE '%.cfml'
					OR name LIKE '%.xml'
				</cfif>
			</cfquery>
		</cfif>
		
		<cfreturn qRules>
	</cffunction>

	<cffunction name="getRule" returntype="struct" output="false" access="public" hint="I return the rule">
		<cfargument name="id" type="string" required="true">
		
		<cfset var stRule = StructNew()>
		<cfset stRule.id = arguments.id>
		<cfset stRule.qRule = getRules(arguments.id)>
		
		<cffile action="read" file="#variables.directory##arguments.id#" variable="stRule.filecontent">
		
		<cfreturn stRule>
	</cffunction>

	<cffunction name="getRules" returntype="query" output="false" access="public" hint="I return the rules">
		<cfargument name="id" type="string" required="false" default="">
		
		<cfset var qRules = getRuleFiles(arguments.id)>
		<cfset var stInfo = ''>
		<cfset var idx = ''>
		<cfset var qRuleDefinitions = QueryNew('name,rulename,description,category,version,author,type,file','varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar')>
		
		<cfloop query="qRules">
			<cfswitch expression="#listLast(name,'.')#">
				<cfcase value="cfc">
					<cfset stInfo = getRuleInfoCFC(name)>
					<cfif stInfo.type EQ 'simple'>
						<cfset QueryAddRow(qRuleDefinitions)>
						<cfset QuerySetCell(qRuleDefinitions,'name',stInfo.name)>
						<cfset QuerySetCell(qRuleDefinitions,'rulename','')>
						<cfset QuerySetCell(qRuleDefinitions,'description',stInfo.description)>
						<cfset QuerySetCell(qRuleDefinitions,'category',stInfo.category)>
						<cfset QuerySetCell(qRuleDefinitions,'version',stInfo.version)>
						<cfset QuerySetCell(qRuleDefinitions,'author',stInfo.author)>
						<cfset QuerySetCell(qRuleDefinitions,'type','cfc (simple)')>
						<cfset QuerySetCell(qRuleDefinitions,'file',name)>
					<cfelseif stInfo.type EQ 'collection'>
						<cfloop collection="#stInfo.rulecollection#" item="idx">
							<cfset QueryAddRow(qRuleDefinitions)>
							<cfset QuerySetCell(qRuleDefinitions,'name',stInfo.name & ': ' & stInfo.rulecollection[idx].name)>
							<cfset QuerySetCell(qRuleDefinitions,'rulename',idx)>
							<cfset QuerySetCell(qRuleDefinitions,'description',stInfo.rulecollection[idx].description)>
							<cfset QuerySetCell(qRuleDefinitions,'category',stInfo.category)>
							<cfset QuerySetCell(qRuleDefinitions,'version',stInfo.version)>
							<cfset QuerySetCell(qRuleDefinitions,'author',stInfo.author)>
							<cfset QuerySetCell(qRuleDefinitions,'type','cfc (collection)')>
							<cfset QuerySetCell(qRuleDefinitions,'file',name)>
						</cfloop>
					</cfif>
				</cfcase>
				<!---<cfcase value="cfm,cfml">
					<cfset stInfo = getRuleInfoCFM(name)>
					<cfset QueryAddRow(qRuleDefinitions)>
					<cfset QuerySetCell(qRuleDefinitions,'name',stInfo.name)>
					<cfset QuerySetCell(qRuleDefinitions,'rulename','')>
					<cfset QuerySetCell(qRuleDefinitions,'description',stInfo.description)>
					<cfset QuerySetCell(qRuleDefinitions,'category',stInfo.category)>
					<cfset QuerySetCell(qRuleDefinitions,'version',stInfo.version)>
					<cfset QuerySetCell(qRuleDefinitions,'author',stInfo.author)>
					<cfset QuerySetCell(qRuleDefinitions,'type','cfm')>
					<cfset QuerySetCell(qRuleDefinitions,'file',name)>
				</cfcase>
				<cfcase value="xml">
					<cfset QueryAddRow(qRuleDefinitions)>
					<cfset QuerySetCell(qRuleDefinitions,'name',name)>
					<cfset QuerySetCell(qRuleDefinitions,'rulename',name)>
					<cfset QuerySetCell(qRuleDefinitions,'description','-')>
					<cfset QuerySetCell(qRuleDefinitions,'category','-')>
					<cfset QuerySetCell(qRuleDefinitions,'version','-')>
					<cfset QuerySetCell(qRuleDefinitions,'author','-')>
					<cfset QuerySetCell(qRuleDefinitions,'type','xml')>
					<cfset QuerySetCell(qRuleDefinitions,'file',name)>
				</cfcase> --->
			</cfswitch>
		</cfloop>
		
		<cfreturn qRuleDefinitions>
	</cffunction>
	
	<cffunction name="getRuleInfoCFC" returntype="struct" output="false" access="public" hint="I return the rule information">
		<cfargument name="rulefile" type="string" required="true">
		
		<cfset var oRule = ''>
		
		<cfset oRule = CreateObject("component","bruteforce.rules.#left(arguments.rulefile,len(arguments.rulefile)-4)#")>

		<cfreturn oRule.getInfo()>
	</cffunction>
	
	<cffunction name="getRuleInfoCFM" returntype="struct" output="false" access="public" hint="I return the rule information">
		<cfargument name="rulefile" type="string" required="true">
		
		<cfinclude template="../rules/__base/base.cfm">
		<cfinclude template="../rules/#arguments.rulefile#">
		
		<cfreturn variables.stInfo>
	</cffunction>

	<cffunction name="delete" returntype="boolean" output="false" access="public" hint="I delete a rule">
		<cfargument name="file" type="string" required="true">

		<cfif request.stSettings.bDeleteRules>
			<cffile action="delete" file="#variables.directory##arguments.file#">
		<cfelse>
			<cffile action="move" source="#variables.directory##arguments.file#" destination="#variables.directory#__deleted/#arguments.file#">
		</cfif>
		
		<cfreturn true>
	</cffunction>

</cfcomponent>