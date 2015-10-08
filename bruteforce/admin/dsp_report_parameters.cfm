<cfsetting enablecfoutputonly="true">

<cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Parameters</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Directory:</th>
			<td>#stReport.stParameters.directory#</td>
		</tr>
		<tr>
			<th>Recurse:</th>
			<td>#stReport.stParameters.recurse#</td>
		</tr>
		<tr>
			<th>File-Filter Include-Mask:</th>
			<td>#stReport.stParameters.filter_file_include#</td>
		</tr>
		<tr>
			<th>File-Filter Exclude-Mask:</th>
			<td>#stReport.stParameters.filter_file_exclude#</td>
		</tr>
		<tr>
			<th>Directory-Filter Include-Mask:</th>
			<td>#stReport.stParameters.filter_directory_include#</td>
		</tr>
		<tr>
			<th>Directory-Filter Exclude-Mask:</th>
			<td>#stReport.stParameters.filter_directory_exclude#</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<strong>Rules</strong>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong>Type</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong>Name</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong>Description</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong>Category</strong>
				</td>
			</tr>
			<cfloop query="qRules">
				<cfif len(rulename)>
					<cfset sRuleKey = file & ':' & rulename>
				<cfelse>
					<cfset sRuleKey = file>
				</cfif>
				<cfif ListFind(stReport.stParameters.rules,sRuleKey)>
					<tr>
						<td nowrap class="cellRightAndBottomBlueSide" align="center">
							<cfswitch expression="#type#">
								<cfcase value="cfc (simple)"><img src="shared/img/icon_cfc.gif" alt="#type#" title="#type#"></cfcase>
								<cfcase value="cfc (collection)"><img src="shared/img/icon_cfc_collection.gif" alt="#type#" title="#type#"></cfcase>
								<cfcase value="cfm"><img src="shared/img/icon_cfm.gif" alt="#type#" title="#type#"></cfcase>
								<cfcase value="xml"><img src="shared/img/icon_xml.gif" alt="#type#" title="#type#"></cfcase>
							</cfswitch>
						</td>
						<td nowrap class="cellRightAndBottomBlueSide">#HTMLEditFormat(name)#</td>
						<td nowrap class="cellRightAndBottomBlueSide">#HTMLEditFormat(description)#</td>
						<td nowrap class="cellRightAndBottomBlueSide">#category#</td>
					</tr>
				</cfif>
			</cfloop>
		</table>
	</td>
</tr>
<tr>
	<form action="#request.myself##myfusebox.thiscircuit#.analyzer" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="name" value="#stReport.name#">
	<input type="hidden" name="directory" value="#stReport.stParameters.directory#">
	<input type="hidden" name="recurse" value="#stReport.stParameters.recurse#">
	<input type="hidden" name="rules" value="#stReport.stParameters.rules#">
	<input type="hidden" name="filter_file_include" value="#stReport.stParameters.filter_file_include#">
	<input type="hidden" name="filter_file_exclude" value="#stReport.stParameters.filter_file_exclude#">
	<input type="hidden" name="filter_directory_include" value="#stReport.stParameters.filter_directory_include#">
	<input type="hidden" name="filter_directory_exclude" value="#stReport.stParameters.filter_directory_exclude#">
	<td bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
		<input type="submit" name="run" value="Run Again" class="buttn">
		<input type="submit" name="saveasprofile" value="Save as profile" class="buttn">
	</td>
	</form>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">