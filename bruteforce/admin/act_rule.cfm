<cfsetting enablecfoutputonly="true">

<cfparam name="attributes.id" default="">

<cfset oRule = CreateObject("component","bruteforce.components.rulemanager")>
<cfset oRule.init(request.stSettings.RulesDirectory)>
<cfset stRule = oRule.getRule(attributes.id)>

<cfsetting enablecfoutputonly="false">