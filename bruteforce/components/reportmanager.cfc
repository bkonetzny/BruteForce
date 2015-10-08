<cfcomponent name="reportmanager">

	<cffunction name="getReport" returntype="struct" output="false" access="public" hint="I return the Report">
		<cfargument name="id" type="string" required="true">

		<cfset var stReport = StructNew()>
		<cfset var stParameters = StructNew()>
		<cfset var qReport = ''>
		
		<cfquery datasource="#request.stSettings.Datasource#" name="qReport">
			SELECT * FROM bf_reports
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		<cfquery datasource="#request.stSettings.Datasource#" name="stReport.qResults">
			SELECT * FROM bf_report_results
			WHERE report_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfif isWDDX(qReport.parameters)>
			<cfwddx action="wddx2cfml" input="#qReport.parameters#" output="stParameters">
		</cfif>
		
		<cfset stReport.name = qReport.name>
		<cfset stReport.id = qReport.id>
		<cfset stReport.dtcreated = qReport.dt_created>
		<cfset stReport.stParameters = stParameters>
		<cfset stReport.executiontime = qReport.executiontime>
		<cfset stReport.filecount = qReport.filecount>
		
		<cfreturn stReport>
	</cffunction>

	<cffunction name="getReports" returntype="query" output="false" access="public" hint="I return the Reports">
		<cfset var qReports = ''>

		<cfquery datasource="#request.stSettings.Datasource#" name="qReports">
			SELECT r.*, (SELECT COUNT(rr.type) FROM bf_report_results rr WHERE rr.report_id = r.id) AS results
			FROM bf_reports r
			WHERE active = 1
			ORDER BY r.dt_created DESC
		</cfquery>
		
		<cfreturn qReports>
	</cffunction>
	
	<cffunction name="delete" returntype="boolean" output="false" access="public" hint="I delete a Report">
		<cfargument name="id" type="string" required="true">
		
		<cfset var qReportFiles = ''>
		
		<cfdirectory action="list" name="qReportFiles" directory="#request.stSettings.ReportDirectory#">

		<cfif request.stSettings.bDeleteReports>
			<cfloop query="qReportFiles">
				<cfif ListFirst(name,'.') EQ arguments.id>
					<cffile action="delete" file="#request.stSettings.ReportDirectory##name#">
				</cfif>
			</cfloop>

			<cfquery datasource="#request.stSettings.Datasource#">
				DELETE FROM bf_report_results
				WHERE report_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			<cfquery datasource="#request.stSettings.Datasource#">
				DELETE FROM bf_reports
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		<cfelse>
			<cfloop query="qReportFiles">
				<cfif ListFirst(name,'.') EQ arguments.id>
					<cffile action="move" source="#request.stSettings.ReportDirectory##name#" destination="#request.stSettings.ReportDirectory#__deleted/#name#">
				</cfif>
			</cfloop>

			<cfquery datasource="#request.stSettings.Datasource#">
				UPDATE bf_reports
				SET active = 0
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		</cfif>
		
		<cfreturn true>
	</cffunction>

</cfcomponent>