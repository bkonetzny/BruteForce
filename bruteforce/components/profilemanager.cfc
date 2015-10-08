<cfcomponent name="profilemanager">

	<cffunction name="getProfile" returntype="struct" output="false" access="public" hint="I return the Profile">
		<cfargument name="id" type="numeric" required="true">

		<cfset var qProfile = ''>
		<cfset var stProfile = ''>
		
		<cfquery datasource="#request.stSettings.Datasource#" name="qProfile">
			SELECT * FROM bf_profiles
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
	
		<cfwddx action="wddx2cfml" input="#qProfile.parameters#" output="stProfile">
		
		<cfreturn stProfile>
	</cffunction>

	<cffunction name="getProfiles" returntype="query" output="false" access="public" hint="I return the Profiles">
		<cfset var qProfiles = ''>

		<cfquery datasource="#request.stSettings.Datasource#" name="qProfiles">
			SELECT * FROM bf_profiles
			WHERE active = 1
			ORDER BY name DESC
		</cfquery>
		
		<cfreturn qProfiles>
	</cffunction>
	
	<cffunction name="delete" returntype="boolean" output="false" access="public" hint="I delete a profile">
		<cfargument name="id" type="string" required="true">

		<cfif request.stSettings.bDeleteProfiles>
			<cfquery datasource="#request.stSettings.Datasource#">
				DELETE FROM bf_profiles
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		<cfelse>
			<cfquery datasource="#request.stSettings.Datasource#">
				UPDATE bf_profiles
				SET active = 0
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		</cfif>
		
		<cfreturn true>
	</cffunction>

</cfcomponent>