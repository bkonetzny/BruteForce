<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.sortby" default="file asc">

<cfset sNewSortdirection = "asc">
<cfif ListLast(attributes.sortby,' ') EQ "asc">
	<cfset sNewSortdirection = "desc">
</cfif>

<cfquery dbtype="query" name="stReport.qResults">
	SELECT * FROM stReport.qResults
	<cfif len(attributes.hide)>
		WHERE type NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.hide#" list="true">)
	</cfif>
	ORDER BY #attributes.sortby#, line ASC, [position] ASC
</cfquery>

<cfsetting enablecfoutputonly="false">