<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.sortby" default="name asc">
<cfparam name="attributes.delete" default="">

<cfset oProfiles = CreateObject("component","bruteforce.components.profilemanager")>

<cfif len(attributes.delete)>
	<cfset oProfiles.delete(attributes.delete)>
</cfif>

<cfset qProfiles = oProfiles.getProfiles()>

<cfset sNewSortdirection = "asc">
<cfif ListLast(attributes.sortby,' ') EQ "asc">
	<cfset sNewSortdirection = "desc">
</cfif>

<cfquery dbtype="query" name="qProfiles">
	SELECT * FROM qProfiles
	ORDER BY #attributes.sortby#
</cfquery>

<cfsetting enablecfoutputonly="false">