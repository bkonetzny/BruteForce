<cfsetting enablecfoutputonly="true">

<cfoutput>
<script type="text/javascript">
function checkAll(field){
	for (i = 0; i < field.length; i++) field[i].checked = true ;
}

function uncheckAll(field){
	for (i = 0; i < field.length; i++) field[i].checked = false ;
}
</script>

<p>
Choose the directory and rules you want to check for.
</p>

<form action="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#" method="post" name="analyzerform">
<input type="hidden" name="form_submitted" value="true">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<strong>Report Data</strong>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Report Title:</th>
			<td><input type="text" size="70" name="name" size="15" style="15em" value="#attributes.name#" class="label"></td>
		</tr>
		<tr>
			<th>Directory to Analyze:</th>
			<td><input type="text" maxlength="550" class="label" size="35" style="width:35em;" name="directory" id="directory" value="#attributes.directory#">
				<input type="button" class="buttn" value="Browse Server" onClick="document.location.href = '#request.myself##myfusebox.thiscircuit#.browseserver';">
			</td>
		</tr>
		<tr>
			<th><label for="recurse">Analyze subdirectories:</th>
			<td><input type="checkbox" name="recurse" id="recurse" value="true" <cfif attributes.recurse> checked</cfif>></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<strong>File-Filter</strong>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Include-Mask:</th>
			<td><input type="text" size="70" name="filter_file_include" size="15" style="15em" value="#attributes.filter_file_include#" class="label"></td>
		</tr>
		<tr>
			<th>Exclude-Mask:</th>
			<td><input type="text" size="70" name="filter_file_exclude" size="15" style="15em" value="#attributes.filter_file_exclude#" class="label"></td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td><font class="label">(example: "<em>*.cfm;*.cfc</em>" or even wildcards: "<em>fbx_*;act_*.cfm</em>")</font></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<strong>Directory-Filter</strong>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Include-Mask:</th>
			<td><input type="text" size="70" name="filter_directory_include" size="15" style="15em" value="#attributes.filter_directory_include#" class="label"></td>
		</tr>
		<tr>
			<th>Exclude-Mask:</th>
			<td><input type="text" size="70" name="filter_directory_exclude" size="15" style="15em" value="#attributes.filter_directory_exclude#" class="label"></td>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<td><font class="label">(example: "<em>*.cfm;*.cfc</em>" or even wildcards: "<em>fbx_*;act_*.cfm</em>")</font></td>
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
					<strong>Use</strong>
				</td>
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
			<tr>
				<td nowrap class="cell3BlueSides" colspan="5">
					<a href="javascript:checkAll(document.analyzerform.rules);">Check All</a> | 
					<a href="javascript:uncheckAll(document.analyzerform.rules);">Uncheck All</a>
				</td>
			</tr>
			<cfloop query="qRules">
				<cfif len(rulename)>
					<cfset sRuleKey = file & ':' & rulename>
				<cfelse>
					<cfset sRuleKey = file>
				</cfif>
				<tr>
					<td nowrap class="cell3BlueSides" align="center"><input type="checkbox" name="rules" id="rule_#sRuleKey#" value="#sRuleKey#"<cfif listfind(attributes.rules,sRuleKey)> checked</cfif>></td>
					<td nowrap class="cellRightAndBottomBlueSide" align="center">
						<cfswitch expression="#type#">
							<cfcase value="cfc (simple)"><img src="shared/img/icon_cfc.gif" alt="#type#" title="#type#"></cfcase>
							<cfcase value="cfc (collection)"><img src="shared/img/icon_cfc_collection.gif" alt="#type#" title="#type#"></cfcase>
							<cfcase value="cfm"><img src="shared/img/icon_cfm.gif" alt="#type#" title="#type#"></cfcase>
							<cfcase value="xml"><img src="shared/img/icon_xml.gif" alt="#type#" title="#type#"></cfcase>
						</cfswitch>
					</td>
					<td nowrap class="cellRightAndBottomBlueSide"><label for="rule_#sRuleKey#">#HTMLEditFormat(name)#</label></td>
					<td nowrap class="cellRightAndBottomBlueSide">#HTMLEditFormat(description)#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#category#</td>
				</tr>
			</cfloop>
			<tr>
				<td nowrap class="cell3BlueSides" colspan="5">
					<a href="javascript:checkAll(document.analyzerform.rules);">Check All</a> | 
					<a href="javascript:uncheckAll(document.analyzerform.rules);">Uncheck All</a>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<input type="submit" name="run" value="Run Analyzer" class="buttn">
		<input type="submit" name="saveasprofile" value="Save as profile" class="buttn"<!---  onclick="alert('Sorry, not implemeted yet...'); return false;" --->>
	</td>
</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="false">