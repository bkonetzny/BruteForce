<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.name" default="Report Title (##timestamp##)">
<cfparam name="attributes.directory" default="#request.stSettings.Scanner.DefaultDirectory#">
<cfparam name="attributes.rules" default="">
<cfparam name="attributes.filter_file_include" default="#request.stSettings.FilterFileInclude#">
<cfparam name="attributes.filter_file_exclude" default="#request.stSettings.FilterFileExclude#">
<cfparam name="attributes.filter_directory_include" default="#request.stSettings.FilterDirectoryInclude#">
<cfparam name="attributes.filter_directory_exclude" default="#request.stSettings.FilterDirectoryExclude#">
<cfparam name="attributes.newdirectorypath" default="">
<cfparam name="attributes.profile" default="">

<cfif attributes.form_submitted AND NOT StructKeyExists(attributes,'recurse')>
	<cfparam name="attributes.recurse" default="false">
<cfelse>
	<cfparam name="attributes.recurse" default="true">
</cfif>

<cfif StructKeyExists(attributes,'saveasprofile')>
	<cfset stProfile = StructNew()>
	<cfset stProfile.name = attributes.name>
	<cfset stProfile.directory = attributes.directory>
	<cfset stProfile.recurse = attributes.recurse>
	<cfset stProfile.rules = attributes.rules>
	<cfset stProfile.filter_file_include = attributes.filter_file_include>
	<cfset stProfile.filter_file_exclude = attributes.filter_file_exclude>
	<cfset stProfile.filter_directory_include = attributes.filter_directory_include>
	<cfset stProfile.filter_directory_exclude = attributes.filter_directory_exclude>
	
	<cfwddx action="cfml2wddx" input="#stProfile#" output="wddxProfile">
	
	<cfquery datasource="#request.stSettings.Datasource#" name="qProfiles">
		INSERT INTO bf_profiles (name,parameters,dt_created)
		VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stProfile.name#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#wddxProfile#">,
				#now()#)
	</cfquery>
	
	<cflocation url="#request.myself##myfusebox.thiscircuit#.profiles">
</cfif>

<cfif len(attributes.profile)>
	<cfset oProfiles = CreateObject("component","bruteforce.components.profilemanager")>

	<cfset stProfile = oProfiles.getProfile(attributes.profile)>
	
	<cfloop collection="#stProfile#" item="idx">
		<cfset attributes[idx] = stProfile[idx]>
	</cfloop>
</cfif>

<cfif len(attributes.newdirectorypath)>
	<cfset attributes.directory = attributes.newdirectorypath>
</cfif>

<cfif attributes.form_submitted>
	<cfoutput>
		<div class="progress">
			<span id="status">Please wait while getting files to analyze.</span>
			<br>&nbsp;<br>
			<img src="shared/img/progress.gif">
			<br>&nbsp;<br>
			This may take a few minutes, especially with many files.
			<br>&nbsp;<br>
			There is currently no way to cancel this, so please be patient ;)
		</div>
	</cfoutput>
	<cfinclude template="../plugins/dsp_layout_postprocess.cfm">
	<cfflush>

	<cfset attributes.name = replacenocase(attributes.name,'##timestamp##','#LSDateFormat(now())# #LSTimeFormat(now())#','ALL')>
	
	<cfset oAnalyzer = CreateObject("component","bruteforce.components.analyzer")>
	<cfset oAnalyzer.init(attributes.name,attributes.directory,attributes.filter_file_include,attributes.filter_file_exclude,attributes.filter_directory_include,attributes.filter_directory_exclude,attributes.rules,attributes.recurse)>

	<cfset iFileCount = oAnalyzer.getFileCount()>
	<cfset iFileSizes = oAnalyzer.getFileSizes()>
	
	<cfoutput>
		<script type="text/javascript">
			document.getElementById('status').innerHTML = 'Please wait while analyzing <strong>#iFileCount# files (#byteConvert(iFileSizes)#)</strong>.';
		</script>
	</cfoutput>
	<cfflush>

	<cfset sFileName = oAnalyzer.generateReport()>

	<!--- workaround if the page is not changed by the following cflocation --->
	<cfoutput>
		<script type="text/javascript">
			window.location = '#request.myself##myfusebox.thiscircuit#.report&id=#sFileName#';
		</script>
	</cfoutput>
	<cfflush>

	<cflocation url="#request.myself##myfusebox.thiscircuit#.report&id=#sFileName#">
</cfif>

<cfset oRules = CreateObject("component","bruteforce.components.rulemanager")>
<cfset oRules.init(request.stSettings.RulesDirectory)>
<cfset qRules = oRules.getRules()>

<cfquery dbtype="query" name="qRules">
	SELECT * FROM qRules
	ORDER BY name ASC
</cfquery>

<cfsetting enablecfoutputonly="false">