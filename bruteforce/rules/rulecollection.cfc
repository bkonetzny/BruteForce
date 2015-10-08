<cfcomponent name="base rule component" extends="bruteforce.rules.__base.base">

	<cffunction name="setInfo" returntype="void" output="false" access="private" hint="I set the rule info">
		<cfscript>
			variables.stInfo.name = 'Sample RuleCollection';
			variables.stInfo.description = 'Several Sample Rules';
			variables.stInfo.category = 'Maintenance';
			variables.stInfo.version = '0.1 beta';
			variables.stInfo.author = 'bkonetzny@gmail.com';
			variables.stInfo.type = 'collection';
			variables.stInfo.rulecollection['rule_one'] = StructNew();
			variables.stInfo.rulecollection['rule_one'].name = 'Rule One';
			variables.stInfo.rulecollection['rule_one'].description = 'Rule One Check';
			variables.stInfo.rulecollection['rule_two'] = StructNew();
			variables.stInfo.rulecollection['rule_two'].name = 'Rule Two';
			variables.stInfo.rulecollection['rule_two'].description = 'Rule Two Check';
		</cfscript>
	</cffunction>
	
	<cffunction name="performRule" returntype="void" output="false" access="private" hint="I perform the rule">
		<cfswitch expression="#variables.stRuntime.rule#">
			<cfcase value="rule_one">
				<cfset ruleOne()>
			</cfcase>
			<cfcase value="rule_two">
				<cfset ruleTwo()>
			</cfcase>
		</cfswitch>

		<cfset ruleDone()>
	</cffunction>
	
	<cffunction name="ruleOne" returntype="void" output="false" access="private" hint="">

		<cfset addResult('debug','I am RuleOne of #variables.stInfo.name#')>

	</cffunction>
	
	<cffunction name="ruleTwo" returntype="void" output="false" access="private" hint="">

		<cfset addResult('debug','I am RuleTwo of #variables.stInfo.name#')>

	</cffunction>

</cfcomponent>