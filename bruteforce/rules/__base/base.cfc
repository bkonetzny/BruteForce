<cfcomponent name="base rule component">

	<cfinclude template="base.cfm">

	<cffunction name="init" returntype="any" output="false" access="public" hint="I initialise the rule">
		<cfset setInfo()>
		<cfreturn this>
	</cffunction>

	<cffunction name="getInfo" returntype="struct" output="false" access="public" hint="I return the rule info">
		<cfset init()>
		<cfreturn variables.stInfo>
	</cffunction>

	<cffunction name="invokeRule" returntype="query" output="false" access="public" hint="I return the rule results">
		<cfargument name="file" type="string" required="true">
		<cfargument name="content" type="string" required="true">
		<cfargument name="rulefile" type="string" required="false" default="">
		<cfargument name="rule" type="string" required="false" default="">

		<cfset init()>

		<cfset variables.stRuntime.file = arguments.file>
		<cfset variables.stRuntime.content = arguments.content>
		<cfset variables.stRuntime.rulefile = arguments.rulefile>
		<cfset variables.stRuntime.rule = arguments.rule>

		<cftry>
			<cfset performRule()>
			<cfcatch><cfset addResult('error','invokeRule ERROR: ' & cfcatch.message)></cfcatch>
		</cftry>

		<cfreturn variables.qResults>
	</cffunction>

	<cffunction name="addResult" returntype="boolean" output="false" access="private" hint="I add an Result">
		<cfargument name="type" type="string" required="false" default="information">
		<cfargument name="message" type="string" required="true">
		<cfargument name="position" type="numeric" required="false" default="0">
		<cfargument name="line" type="numeric" required="false" default="0">

		<cfset QueryAddRow(variables.qResults)>
		<cfset QuerySetCell(variables.qResults,'uuid',CreateUUID())>
		<cfset QuerySetCell(variables.qResults,'type',arguments.type)>
		<cfset QuerySetCell(variables.qResults,'file',variables.stRuntime.file)>
		<cfif variables.stInfo.type EQ 'simple'>
			<cfset QuerySetCell(variables.qResults,'rulename',variables.stInfo.name)>
		<cfelse>
			<cfset QuerySetCell(variables.qResults,'rulename',variables.stInfo.name & ': ' & variables.stInfo.rulecollection[variables.stRuntime.rule].name)>
		</cfif>
		<cfset QuerySetCell(variables.qResults,'rule',variables.stRuntime.rule)>
		<cfset QuerySetCell(variables.qResults,'rulefile',variables.stRuntime.rulefile)>
		<cfset QuerySetCell(variables.qResults,'message',arguments.message)>
		<cfset QuerySetCell(variables.qResults,'line',arguments.line)>
		<cfset QuerySetCell(variables.qResults,'position',arguments.position)>

		<cfset variables.stRuntime.bHasResults = true>
		
		<cfreturn true>
	</cffunction>

	<cffunction name="ruleDone" returntype="boolean" output="false" access="private" hint="I mark the rule execution as done">
		
		<cfset variables.stRuntime.bRuleDone = true>
		
		<cfreturn true>
	</cffunction>

</cfcomponent>