<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.id" default="">
<cfparam name="attributes.view" default="summary">
<cfparam name="attributes.hide" default="">

<cfset oReports = CreateObject("component","bruteforce.components.reportmanager")>

<cfset stReport = oReports.getReport(attributes.id)>

<cfset oRules = CreateObject("component","bruteforce.components.rulemanager")>
<cfset oRules.init(request.stSettings.RulesDirectory)>
<cfset qRules = oRules.getRules()>

<cfquery name="qStats" dbtype="query">
	SELECT COUNT(type) AS cnt, type
	FROM stReport.qResults
	GROUP BY type
</cfquery>

<cfsetting enablecfoutputonly="false">