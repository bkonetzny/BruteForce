<cfsetting enablecfoutputonly="true">

<cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Analyzed Files</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=#attributes.view#&sortby=file #sNewSortdirection#">File</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=#attributes.view#&sortby=results #sNewSortdirection#">Results</a></strong>
				</td>          
			</tr>
			<cfloop query="stReport.qFiles">
				<tr>
					<td nowrap class="cell3BlueSides">#file#</td>
					<td nowrap class="cellRightAndBottomBlueSide" align="center">#results#</td>
				</tr>
			</cfloop>
		</table>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">