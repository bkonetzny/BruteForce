<cfcomponent name="%rulename%" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = '%rulename%';
			variables.stInfo.description = '%ruledescription%';
			variables.stInfo.category = '%rulecategory%';
			variables.stInfo.version = '%ruleversion%';
			variables.stInfo.author = '%ruleauthor%';
			variables.stInfo.type = '%ruletype%';
			
			// only if ruletype = 'collection'
			variables.stInfo.rulecollection['%rulekey1%'] = StructNew();
			variables.stInfo.rulecollection['%rulekey1%'].name = '%rulename1%';
			variables.stInfo.rulecollection['%rulekey1%'].description = '%ruledescription1%';
			variables.stInfo.rulecollection['%rulekey2%'] = StructNew();
			variables.stInfo.rulecollection['%rulekey2%'].name = '%rulename2%';
			variables.stInfo.rulecollection['%rulekey2%'].description = '%ruledescription2%';
		</cfscript>
	</cffunction>

	<cffunction name="performRule" returntype="void" output="false" access="private" hint="I perform the rule">

		%rulelogic%

		<cfset ruleDone()>
	</cffunction>

</cfcomponent>