<cfsetting enablecfoutputonly="true">

<cfoutput>
<p>
This page gives an overview of the currently avaible Profiles.
</p>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Current Profiles</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Number of Profiles:</th>
			<td>#qProfiles.recordcount# Profiles found.</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="70">
					<strong>Actions</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=name #sNewSortdirection#">Name</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=dt_created #sNewSortdirection#">Created</a></strong>
				</td>
			</tr>
			<cfloop query="qProfiles">
				<tr>
					<td nowrap class="cell3BlueSides"><a href="#request.myself##myfusebox.thiscircuit#.analyzer&profile=#id#"><img src="../../images/iedit.gif" height="16" width="16" alt="Edit" border="0"></a> <a href="#request.myself##myfusebox.thiscircuit#.analyzer&profile=#id#&form_submitted=true"><img src="../../images/istart.gif" height="16" width="16" alt="Run" border="0"></a> <a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&delete=#id#" onclick="return confirm('Are you sure you want to delete this Profile?');"><img src="../../images/idelete.gif" height="16" width="16" alt="Delete" border="0"></a></td>
					<td nowrap class="cellRightAndBottomBlueSide"><a href="#request.myself##myfusebox.thiscircuit#.analyzer&profile=#id#">#name#</a></td>
					<td nowrap class="cellRightAndBottomBlueSide">#LSDateFormat(dt_created)# #LSTimeFormat(dt_created)#</td>
				</tr>
			</cfloop>
		</table>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">