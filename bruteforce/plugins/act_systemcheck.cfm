<cfsetting enablecfoutputonly="true">

<cfparam name="aErrors" default="#ArrayNew(1)#">

<cfif NOT len(request.stSettings.Datasource)>
	<cfset ArrayAppend(aErrors,'You need to specify a datasource.')>
</cfif>

<cftry>
	<cfset oDummyComponent = CreateObject('component','bruteforce.components.analyzer')>
	<cfcatch><cfset ArrayAppend(aErrors,'A bruteforce mapping is required.')></cfcatch>
</cftry>

<cfif ArrayLen(aErrors) AND myfusebox.thisfuseaction NEQ 'settings'>
	<cflocation url="#request.myself##myfusebox.thiscircuit#.settings" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="false">