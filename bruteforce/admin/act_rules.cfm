<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.file" default="">
<cfparam name="attributes.delete" default="">
<cfparam name="attributes.sortby" default="name asc">

<cfset sNewSortdirection = "asc">
<cfif ListLast(attributes.sortby,' ') EQ "asc">
	<cfset sNewSortdirection = "desc">
</cfif>

<cfif attributes.form_submitted AND len(attributes.file)>
	<!--- ListFind('cfc,cfm,cfml',listLast(attributes.file,'.')) --->
	<cffile action="upload" filefield="file" destination="#request.stSettings.RulesDirectory#" nameconflict="makeunique">

	<cfif NOT ListFind(request.stSettings.RuleExtensions,cffile.serverfileext)>
		<cffile action="delete" file="#cffile.serverdirectory#/#cffile.serverfile#">
	</cfif>
	
	<cflocation url="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#">
</cfif>

<cfset oRules = CreateObject("component","bruteforce.components.rulemanager")>
<cfset oRules.init(request.stSettings.RulesDirectory)>

<cfif len(attributes.delete)>
	<cfset oRules.delete(attributes.delete)>
</cfif>

<cfset qRules = oRules.getRules()>

<cfquery dbtype="query" name="qRules">
	SELECT * FROM qRules
	ORDER BY #attributes.sortby#
</cfquery>

<cfquery dbtype="query" name="qRulesTypes">
	SELECT COUNT(type) AS cnt, type FROM qRules
	GROUP BY type
	ORDER BY type
</cfquery>

<cfsetting enablecfoutputonly="false">