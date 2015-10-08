<cfcomponent name="base rule component" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = 'CleanUp';
			variables.stInfo.description = 'Searches for unnecessary files';
			variables.stInfo.category = 'Maintenance';
			variables.stInfo.version = '0.1 beta';
			variables.stInfo.author = 'bkonetzny@gmail.com';
		</cfscript>
	</cffunction>

	<cffunction name="performRule" returntype="void" output="false" access="private" hint="I perform the rule">

		<cfset var stLookup = StructNew()>
		<cfset var iKey = ''>
		<cfset var iItem = ''>
		
		<cfset iKey = 'thumbs.db'>
		<cfset stLookup[iKey] = StructNew()>
		<cfset stLookup[iKey].name = 'Thumbs.db'>
		<cfset stLookup[iKey].type = 'Windows Thumbnail Cache'>
		<cfset iKey = '.tmp'>
		<cfset stLookup[iKey] = StructNew()>
		<cfset stLookup[iKey].name = '.tmp'>
		<cfset stLookup[iKey].type = 'Temporary File'>

		<cfloop collection="#stLookup#" item="iItem">
			<cfif right(variables.stRuntime.file,len(iItem)) EQ iItem>
				<cfset addResult('information','Found ' & stLookup[iItem].name & ' (' & stLookup[iItem].type & ').')>
			</cfif>
		</cfloop>

		<cfset ruleDone()>
	</cffunction>

</cfcomponent>