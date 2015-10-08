<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.createmapping" default="false">
<cfparam name="attributes.createconcurrency" default="false">
<cfparam name="attributes.createconfig" default="false">
<cfparam name="attributes.resetconfig" default="">

<cfif len(attributes.resetconfig)>
	<cffile action="delete" file="#request.stSettings.AppRoot#settings.custom.cfm">
	
	<cflocation url="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#">
</cfif>

<cfif attributes.createconfig>
	<cfparam name="attributes.adminapipassword" default="">
	<cfparam name="attributes.usethreading" default="false">
	<cfparam name="attributes.datasource" default="">
	<cfparam name="attributes.bdeleterules" default="">
	<cfparam name="attributes.bdeletereports" default="">
	<cfparam name="attributes.fileinclude" default="">
	<cfparam name="attributes.fileexclude" default="">
	<cfparam name="attributes.directoryinclude" default="">
	<cfparam name="attributes.directoryexclude" default="">
	<cfparam name="attributes.printformat" default="">

	<cfset sCFScript = 'cfscript'>

	<cfsavecontent variable="sConfigFile">
		<cfoutput>
<#sCFScript#>
request.stSettings.FilterFileInclude = '#attributes.fileinclude#';
request.stSettings.FilterFileExclude = '#attributes.fileexclude#';
request.stSettings.FilterDirectoryInclude = '#attributes.directoryinclude#';
request.stSettings.FilterDirectoryExclude = '#attributes.directoryexclude#';
request.stSettings.bDeleteReports = #attributes.bdeletereports#;
request.stSettings.bDeleteRules = #attributes.bdeleterules#;
request.stSettings.bUseThreading = #attributes.usethreading#;
request.stSettings.Datasource = '#attributes.datasource#';
request.stSettings.PrintFormat = '#attributes.printformat#';
</#sCFScript#>
		</cfoutput>
	</cfsavecontent>
	
	<cffile action="write" file="#request.stSettings.AppRoot#settings.custom.cfm" output="#trim(sConfigFile)#" addnewline="false" mode="777">
	
	<cflocation url="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#">
</cfif>

<cfset bConcurrencyFound = false>
<cfset bMappingFound = false>
<cfset bConfigFound = fileExists('#request.stSettings.AppRoot#settings.custom.cfm')>

<cfset oMappings = CreateObject("component","CFIDE.adminapi.extensions")>
<cfset oEventGateways = CreateObject("component","CFIDE.adminapi.eventgateway")>
<cfset oDatasources = CreateObject("component","CFIDE.adminapi.datasource")>

<cfif attributes.createmapping>
	<cfset oMappings.setMapping('/bruteforce',request.stSettings.AppRoot)>
	<cflocation url="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#">
</cfif>

<cfif attributes.createconcurrency>
	<cfset oMappings.setMapping('/Concurrency',request.stSettings.AppRoot & 'components/Concurrency/')>
	<cfset aCfcPaths = ArrayNew(1)>
	<cfset ArrayAppend(aCfcPaths,request.stSettings.AppRoot & 'components/Concurrency/FutureEvent.cfc')>
	<cfset oEventGateways.setGatewayInstance('CFML-Future','CFML',aCfcPaths,'','auto')>
	<cfset oEventGateways.startGatewayInstance('CFML-Future')>
</cfif>

<cfset stMappings = oMappings.getMappings()>
<cfset stEventGateways = oEventGateways.getGatewayInstances()>
<cfset stDatasources = oDatasources.getDatasources()>

<cfif StructKeyExists(stMappings,'/bruteforce')>
	<cfset bMappingFound = true>
</cfif>

<cfif StructKeyExists(stMappings,'/Concurrency')>
	<cfloop from="1" to="#ArrayLen(stEventGateways)#" index="idx">
		<cfif stEventGateways[idx].gatewayid EQ 'CFML-Future'>
			<cfset bConcurrencyFound = true>
		</cfif>
	</cfloop>
</cfif>

<cfsetting enablecfoutputonly="false">