<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.format" default="#request.stSettings.PrintFormat#">

<cfset sFileName = '#replacelist('#stReport.id#_#stReport.name#','(,),/, ,:,.','_,_,_,_')#.#attributes.format#'>
<cfset sFile = "#request.stSettings.ReportDirectory##stReport.id#.#attributes.format#">

<cfheader name="content-disposition" value="attachment;filename=#sFileName#">
<cfcontent file="#sFile#">

<cfsetting enablecfoutputonly="false">