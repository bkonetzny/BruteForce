<cfcomponent name="base rule component" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = 'IsDefined Checker';
			variables.stInfo.description = 'Looks for isDefined()';
			variables.stInfo.category = 'Coding Standards';
			variables.stInfo.version = '0.1 beta';
			variables.stInfo.author = 'bkonetzny@gmail.com';
		</cfscript>
	</cffunction>

	<cffunction name="performRule" returntype="void" output="false" access="private" hint="I perform the rule">

		<cfset var bDone = 0>
		<cfset var iStart = 0>
		<cfset var stSearchResult = ''>
		<cfset var sRegEx = 'isDefined\([''"]([a-zA-Z.\[\]_])*[''"]\)'>
		<cfset var sResult = ''>
		<cfset var sStruct = ''>
		<cfset var sKey = ''>

		<cfloop condition="bDone NEQ 1">
			<cfif refindnocase(sRegEx,variables.stRuntime.content,iStart)>
				<cfset sResult = ''>
				<cfset sStruct = ''>
				<cfset sKey = ''>
				<cfset stSearchResult = refindnocase(sRegEx,variables.stRuntime.content,iStart,true)>
				<cfset sResult = mid(variables.stRuntime.content,stSearchResult.pos[1],stSearchResult.len[1])>
				<cfset sStruct = mid(sResult,12,len(sResult)-13)>
				<cfif right(sStruct,1) EQ ']'>
					<cfset sKey = ListLast(sStruct,'[')>
					<cfset sKey = left(sKey,len(sKey)-1)>
					<cfset sStruct = left(sStruct,len(sStruct)-len(sKey)-2)>
				<cfelseif listlen(sStruct,'.') GT 1>
					<cfset sKey = ListLast(sStruct,'.')>
					<cfset sStruct = left(sStruct,len(sStruct)-len(sKey)-1)>
					<cfset sKey = "'#sKey#'">
				<cfelse>
					<cfset sKey = sStruct>
					<cfset sStruct = 'variables'>
				</cfif>
				<cfset stSearchResult.message = "You should use StructKeyExists(#sStruct#,#sKey#) instead of #sResult#">
				<cfset iStart = stSearchResult.pos[1] + stSearchResult.len[1]>
				<cfset addResult('information',stSearchResult.message,stSearchResult.pos[1])>
			<cfelse>
				<cfset bDone = 1>
			</cfif>
		</cfloop>

		<cfset ruleDone()>
	</cffunction>

</cfcomponent>