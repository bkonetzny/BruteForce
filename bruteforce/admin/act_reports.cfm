<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.sortby" default="dt_created desc">
<cfparam name="attributes.delete" default="">

<cfset oReports = CreateObject("component","bruteforce.components.reportmanager")>

<cfif len(attributes.delete)>
	<cfset oReports.delete(attributes.delete)>
</cfif>

<cfset qReports = oReports.getReports()>

<cfset sNewSortdirection = "asc">
<cfif ListLast(attributes.sortby,' ') EQ "asc">
	<cfset sNewSortdirection = "desc">
</cfif>

<cfquery dbtype="query" name="qReports">
	SELECT * FROM qReports
	ORDER BY #attributes.sortby#
</cfquery>

<cfsetting enablecfoutputonly="false">