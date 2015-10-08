<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.sortby" default="rulename asc">

<cfset sNewSortdirection = "asc">
<cfif ListLast(attributes.sortby,' ') EQ "asc">
	<cfset sNewSortdirection = "desc">
</cfif>

<cfquery dbtype="query" name="stReport.qFiles">
	SELECT COUNT (type) AS results FROM stReport.qResults
	GROUP BY file
	ORDER BY #attributes.sortby#, file ASC, line ASC, [position] ASC
</cfquery>

<cfsetting enablecfoutputonly="false">