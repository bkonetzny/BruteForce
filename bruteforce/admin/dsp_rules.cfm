<cfsetting enablecfoutputonly="true">

<cfoutput>
<p>
This page gives an overview of the currently installed rules.
</p>

<form action="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#" method="post" enctype="multipart/form-data">
<input type="hidden" name="form_submitted" value="true">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Add Rule</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Upload Rule:</th>
			<td><input type="file" name="file"></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
		<input type="submit" value="Add Rule" class="buttn">
	</td>
</tr>
</table>
</form>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Current Rules</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Rules-Directory:</th>
			<td>#request.stSettings.RulesDirectory#</td>
		</tr>
		<tr>
			<th>Number of rules:</th>
			<td>#qRules.recordcount# rules found.</td>
		</tr>
		<tr>
			<th>Rules by type:</th>
			<td><table cellpadding="5">
				<cfloop query="qRulesTypes">
					<tr>
						<td>
							<cfswitch expression="#type#">
								<cfcase value="cfc (simple)"><img src="shared/img/icon_cfc.gif" alt="#type#" title="#type#"></cfcase>
								<cfcase value="cfc (collection)"><img src="shared/img/icon_cfc_collection.gif" alt="#type#" title="#type#"></cfcase>
								<cfcase value="cfm"><img src="shared/img/icon_cfm.gif" alt="#type#" title="#type#"></cfcase>
								<cfcase value="xml"><img src="shared/img/icon_xml.gif" alt="#type#" title="#type#"></cfcase>
							</cfswitch>
						</td>
						<td>#type#:</td>
						<td align="right">#cnt#</td>
					</tr>
				</cfloop>
				</table></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="50">
					<strong>Actions</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=type #sNewSortdirection#">Type</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=name #sNewSortdirection#">Name</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=description #sNewSortdirection#">Description</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=category #sNewSortdirection#">Category</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=version #sNewSortdirection#">Version</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=author #sNewSortdirection#">Author</a></strong>
				</td>
			</tr>
			<cfloop query="qRules">
				<tr>
					<td nowrap class="cell3BlueSides"><a href="#request.myself##myfusebox.thiscircuit#.rule&id=#file#"><img src="../../images/iverify.gif" height="16" width="16" alt="View" border="0"></a> <a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&delete=#file#" onclick="return confirm('Are you sure you want to delete this Rule?');"><img src="../../images/idelete.gif" height="16" width="16" alt="Delete" border="0"></a></td>
					<td nowrap class="cellRightAndBottomBlueSide" align="center">
						<cfswitch expression="#type#">
							<cfcase value="cfc (simple)"><img src="shared/img/icon_cfc.gif" alt="#type#" title="#type#"></cfcase>
							<cfcase value="cfc (collection)"><img src="shared/img/icon_cfc_collection.gif" alt="#type#" title="#type#"></cfcase>
							<cfcase value="cfm"><img src="shared/img/icon_cfm.gif" alt="#type#" title="#type#"></cfcase>
							<cfcase value="xml"><img src="shared/img/icon_xml.gif" alt="#type#" title="#type#"></cfcase>
						</cfswitch>
					</td>
					<td nowrap class="cellRightAndBottomBlueSide"><a href="#request.myself##myfusebox.thiscircuit#.rule&id=#file#">#HTMLEditFormat(name)#</a></td>
					<td nowrap class="cellRightAndBottomBlueSide">#HTMLEditFormat(description)#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#category#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#version#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#author#</td>
				</tr>
			</cfloop>
		</table>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">