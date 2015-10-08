<cfsetting enablecfoutputonly="true">

<cfoutput>
<p>
This the detail page of the selected rule.
</p>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Rule Details</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Rule:</th>
			<td>#HTMLEditFormat(stRule.qRule.name)#</td>
		</tr>
		<tr>
			<th>Type:</th>
			<td><cfswitch expression="#stRule.qRule.type#">
					<cfcase value="cfc (simple)"><img src="shared/img/icon_cfc.gif" alt="#stRule.qRule.type#" title="#stRule.qRule.type#"></cfcase>
					<cfcase value="cfc (collection)"><img src="shared/img/icon_cfc_collection.gif" alt="#stRule.qRule.type#" title="#stRule.qRule.type#"></cfcase>
					<cfcase value="cfm"><img src="shared/img/icon_cfm.gif" alt="#stRule.qRule.type#" title="#stRule.qRule.type#"></cfcase>
					<cfcase value="xml"><img src="shared/img/icon_xml.gif" alt="#stRule.qRule.type#" title="#stRule.qRule.type#"></cfcase>
				</cfswitch> #stRule.qRule.type#</td>
		</tr>
		<tr>
			<th>Category:</th>
			<td>#stRule.qRule.category#</td>
		</tr>
		<tr>
			<th>Version:</th>
			<td>#stRule.qRule.version#</td>
		</tr>
		<tr>
			<th>Author:</th>
			<td>#stRule.qRule.author#</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<cfif stRule.qRule.type EQ "cfc (collection)">
	<br><br>

	<div align="center"><strong class="errorText">Rule Details for type 'cfc (collection)' still need some work.</strong></div>
</cfif>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Description</b>
	</td>
</tr>
<tr>
	<td>#HTMLEditFormat(stRule.qRule.description)#</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Code View</b>
	</td>
</tr>
<tr>
	<td><pre>#HTMLEditFormat(stRule.filecontent)#</pre></td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">