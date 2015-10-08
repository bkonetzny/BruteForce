<cfcomponent name="base rule component" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = 'Get Todo Comments';
			variables.stInfo.description = 'Searches for <!--- todo ---> Comments';
			variables.stInfo.category = 'Maintenance';
			variables.stInfo.version = '0.1 beta';
			variables.stInfo.author = 'bkonetzny@gmail.com';
		</cfscript>
	</cffunction>

	<cffunction name="performRule" returntype="void" output="false" access="private" hint="I perform the rule">

		<cfset var bDone = 0>
		<cfset var iStart = 0>
		<cfset var stSearchResult = ''>
		<cfset var sRegEx = '<!--(-)? (\$)?todo(:)? ([a-zA-Z0-9\(\)\$ ])* (-)?-->'>
		<cfset var sResult = ''>

		<cfloop condition="bDone NEQ 1">
			<cfif refindnocase(sRegEx,variables.stRuntime.content,iStart)>
				<cfset sResult = ''>
				<cfset stSearchResult = refindnocase(sRegEx,variables.stRuntime.content,iStart,true)>
				<cfset sResult = mid(variables.stRuntime.content,stSearchResult.pos[1],stSearchResult.len[1])>
				<cfset stSearchResult.message = "Found Todo Comment: #sResult#">
				<cfset iStart = stSearchResult.pos[1] + stSearchResult.len[1]>
				<cfset addResult('information',stSearchResult.message,stSearchResult.pos[1])>
			<cfelse>
				<cfset bDone = 1>
			</cfif>
		</cfloop>

		<cfset ruleDone()>
	</cffunction>

</cfcomponent>