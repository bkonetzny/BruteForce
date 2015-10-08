<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.generate" default="false">
<cfparam name="attributes.format" default="#request.stSettings.PrintFormat#">

<cfset attributes.sFileName = '#stReport.id#.#attributes.format#'>
<cfset attributes.sFullFileName = '#request.stSettings.ReportDirectory##attributes.sFileName#'>

<cfif attributes.generate OR NOT FileExists(attributes.sFullFileName)>
	<cfinclude template="act_report_export_handler_#attributes.format#.cfm">
</cfif>

<cfsetting enablecfoutputonly="false">