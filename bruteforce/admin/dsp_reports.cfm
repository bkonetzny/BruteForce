<cfsetting enablecfoutputonly="true">

<cfoutput>
<p>
This page gives an overview of the currently avaible Reports.
</p>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Current Reports</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<cfif NOT request.stSettings.bUseDatasource>
			<tr>
				<th>Reports-Directory:</th>
				<td>#request.stSettings.ReportDirectory#</td>
			</tr>
		</cfif>
		<tr>
			<th>Number of Reports:</th>
			<td>#qReports.recordcount# Reports found.</td>
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
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=name #sNewSortdirection#">Name</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=results #sNewSortdirection#">Results</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=dt_created #sNewSortdirection#">Created</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&sortby=executiontime #sNewSortdirection#">Execution Time</a></strong>
				</td>
			</tr>
			<cfloop query="qReports">
				<tr>
					<td nowrap class="cell3BlueSides"><a href="#request.myself##myfusebox.thiscircuit#.report&id=#id#"><img src="../../images/iverify.gif" height="16" width="16" alt="View" border="0"></a> <a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&delete=#id#" onclick="return confirm('Are you sure you want to delete this Report?');"><img src="../../images/idelete.gif" height="16" width="16" alt="Delete" border="0"></a></td>
					<td nowrap class="cellRightAndBottomBlueSide"><a href="#request.myself##myfusebox.thiscircuit#.report&id=#id#">#name#</a></td>
					<td nowrap class="cellRightAndBottomBlueSide" align="center">#results#</td>
					<td nowrap class="cellRightAndBottomBlueSide" align="center">#LSDateFormat(dt_created)# #LSTimeFormat(dt_created)#</td>
					<td nowrap class="cellRightAndBottomBlueSide" align="center"><cfif executiontime>#request.lib.hmsformat(executiontime/1000,'s')#<cfelse><strong class="errorText">Running</strong></cfif></td>
				</tr>
			</cfloop>
		</table>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">