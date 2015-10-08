<cfcomponent name="base rule component" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = 'ParameterExists (CFC)';
			variables.stInfo.description = 'Check for usage of ParameterExists()';
			variables.stInfo.category = 'Function Check';
			variables.stInfo.version = '0.1 beta';
			variables.stInfo.author = 'bkonetzny@gmail.com';
		</cfscript>
	</cffunction>

	<cffunction name="performRule" returntype="void" output="false" access="private" hint="I perform the rule">

		<cfset var bDone = 0>
		<cfset var iStart = 0>
		<cfset var stSearchResult = ''>

		<cfloop condition="bDone NEQ 1">
			<cfif refindnocase("ParameterExists\(",variables.stRuntime.content,iStart)>
				<cfset stSearchResult = refindnocase("ParameterExists\(",variables.stRuntime.content,iStart,true)>
				<cfset stSearchResult.message = "The ParameterExists function is deprecated. You should replace ParameterExists function calls with IsDefined function calls.">
				<cfset iStart = stSearchResult.pos[1] + stSearchResult.len[1]>
				<cfset addResult('warning',stSearchResult.message,stSearchResult.pos[1])>
				<cfset addResult('debug','testvalue')>
			<cfelse>
				<cfset bDone = 1>
			</cfif>
		</cfloop>

		<cfset ruleDone()>
	</cffunction>

</cfcomponent>