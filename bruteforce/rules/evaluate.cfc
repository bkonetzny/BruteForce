<cfcomponent name="base rule component" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = 'Evaluate';
			variables.stInfo.description = 'Check for usage of Evaluate()';
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
			<cfif refindnocase("Evaluate\(",variables.stRuntime.content,iStart)>
				<cfset stSearchResult = refindnocase("Evaluate\(",variables.stRuntime.content,iStart,true)>
				<cfset stSearchResult.message = "The Evaluate() function should be avoided.">
				<cfset iStart = stSearchResult.pos[1] + stSearchResult.len[1]>
				<cfset addResult('warning',stSearchResult.message,stSearchResult.pos[1])>
			<cfelse>
				<cfset bDone = 1>
			</cfif>
		</cfloop>

		<cfset ruleDone()>
	</cffunction>

</cfcomponent>