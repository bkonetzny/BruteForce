<cfsetting enablecfoutputonly="true">

<cfoutput>
<p>
Change Settings for the BruteForce Code Analyzer here.
</p>

<form action="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#" method="post">
<input type="hidden" name="createconfig" value="true">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Settings</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Datasource:</th>
			<td><select name="datasource">
					<option value=""></option>
					<cfloop collection="#stDatasources#" item="idx">
						<option value="#idx#"<cfif idx EQ request.stSettings.Datasource> selected</cfif>>#idx#</option>
					</cfloop>
				</select></td>
		</tr>
		<tr>
			<th>Use <a href="http://code.google.com/p/cfconcurrency/" target="_blank">Concurrency</a>:</th>
			<td><input type="checkbox" name="usethreading" value="true"<cfif request.stSettings.bUseThreading> checked</cfif>></td>
		</tr>
		<tr>
			<th>Delete Rules:</th>
			<td><input type="radio" name="bdeleterules" id="bdeleterules_true" value="true"<cfif request.stSettings.bDeleteRules> checked</cfif>> <label for="bdeleterules_true">Delete</label>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="bdeleterules" id="bdeleterules_false" value="false"<cfif NOT request.stSettings.bDeleteRules> checked</cfif>> <label for="bdeleterules_false">Keep backup</label></td>
		</tr>
		<tr>
			<th>Delete Reports:</th>
			<td><input type="radio" name="bdeletereports" id="bdeletereports_true" value="true"<cfif request.stSettings.bDeleteReports> checked</cfif>> <label for="bdeletereports_true">Delete</label>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="bdeletereports" id="bdeletereports_false" value="false"<cfif NOT request.stSettings.bDeleteReports> checked</cfif>> <label for="bdeletereports_false">Keep backup</label></td>
		</tr>
		<tr>
			<th>Delete Profiles:</th>
			<td><input type="radio" name="bdeleteprofiles" id="bdeleteprofiles_true" value="true"<cfif request.stSettings.bDeleteProfiles> checked</cfif>> <label for="bdeleteprofiles_true">Delete</label>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="bdeleteprofiles" id="bdeleteprofiles_false" value="false"<cfif NOT request.stSettings.bDeleteProfiles> checked</cfif>> <label for="bdeleteprofiles_false">Keep backup</label></td>
		</tr>
		<tr>
			<th>Default File-Include Filter:</th>
			<td><input type="text" name="fileinclude" size="70" value="#request.stSettings.FilterFileInclude#"></td>
		</tr>
		<tr>
			<th>Default File-Exclude Filter:</th>
			<td><input type="text" name="fileexclude" size="70" value="#request.stSettings.FilterFileExclude#"></td>
		</tr>
		<tr>
			<th>Default Directory-Include Filter:</th>
			<td><input type="text" name="directoryinclude" size="70" value="#request.stSettings.FilterDirectoryInclude#"></td>
		</tr>
		<tr>
			<th>Default Directory-Exclude Filter:</th>
			<td><input type="text" name="directoryexclude" size="70" value="#request.stSettings.FilterDirectoryExclude#"></td>
		</tr>
		<tr>
			<th>Print-Format:</th>
			<td><select name="printformat">
					<option value="pdf"<cfif request.stSettings.PrintFormat EQ 'pdf'> selected</cfif>>PDF</option>
					<option value="swf"<cfif request.stSettings.PrintFormat EQ 'swf'> selected</cfif>>FlashPaper</option>
				</select></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
		<input type="submit" name="saveconfig" value="Submit Changes" class="buttn">
		<cfif bConfigFound><input type="submit" name="resetconfig" value="Reset Config" class="buttn"></cfif>
	</td>
</tr>
</table>
</form>

<br><br>

<form action="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#" method="post">
<input type="hidden" name="createmapping" value="true">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Mapping</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Mapping found:</th>
			<td><cfif bMappingFound><strong class="successText">Yes</strong><br>/bruteforce = #stMappings['/bruteforce']#<cfelse><strong class="errorText">No</strong></cfif></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
		<input type="submit" value="<cfif bMappingFound>Refresh<cfelse>Create</cfif> Mapping" class="buttn">
	</td>
</tr>
</table>
</form>

<cfif request.stSettings.bUseThreading>
<br><br>

<form action="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#" method="post">
<input type="hidden" name="createconcurrency" value="true">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Concurreny</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Concurreny found:</th>
			<td><cfif bConcurrencyFound><strong class="successText">Yes</strong><br>/Concurrency = #stMappings['/Concurrency']#<cfelse><strong class="errorText">No</strong></cfif></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
		<input type="submit" value="<cfif bConcurrencyFound>Refresh<cfelse>Create</cfif> Mapping & EventGateway" class="buttn">
	</td>
</tr>
</table>
</form>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="false">