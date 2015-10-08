<cfcomponent name="ruleinvoker">

	<cffunction name="init" returntype="any" output="false" access="public" hint="I initialise the RuleInvoker">
		<cfreturn this>
	</cffunction>

	<cffunction name="invokeRule" returntype="query" output="false" access="public" hint="I invoke the rule">
		<cfargument name="file" type="string" required="true">
		<cfargument name="content" type="string" required="true">
		<cfargument name="rulefile" type="string" required="true">
		<cfargument name="rule" type="string" required="false" default="">
		
		<cfswitch expression="#listLast(arguments.rulefile,'.')#">
			<cfcase value="cfc">
				<cfreturn invokeCFC(arguments.file,arguments.content,arguments.rulefile,arguments.rule)>
			</cfcase>
			<cfcase value="cfm,cfml">
				<cfreturn invokeCFM(arguments.file,arguments.content,arguments.rule)>
			</cfcase>
			<cfdefaultcase>
				<cfreturn StructNew()>
			</cfdefaultcase>
		</cfswitch>

	</cffunction>

	<cffunction name="invokeCFC" returntype="query" output="false" access="private" hint="I invoke a CFC rule">
		<cfargument name="file" type="string" required="true">
		<cfargument name="content" type="string" required="true">
		<cfargument name="rulefile" type="string" required="true">
		<cfargument name="rule" type="string" required="false" default="">
		
		<cfset var oRule = ''>
		<cfset var qResult = QueryNew('uuid')>
		
		<cftry>
			<cfset oRule = CreateObject("component","bruteforce.rules.#left(arguments.rulefile,len(arguments.rulefile)-4)#")>
			<cfset qResult = oRule.invokeRule(arguments.file,arguments.content,arguments.rulefile,arguments.rule)>
			<cfcatch><cfrethrow><!--- todo: handle invocation error ---></cfcatch>
		</cftry>
		
		<cfreturn qResult>
	</cffunction>

	<cffunction name="invokeCFM" returntype="query" output="false" access="private" hint="I invoke a CFM rule">
		<cfargument name="file" type="string" required="true">
		<cfargument name="content" type="string" required="true">
		<cfargument name="rule" type="string" required="true">
		
		<cfinclude template="#arguments.rule#">

		<cfreturn QueryNew('uuid')>
	</cffunction>

</cfcomponent>