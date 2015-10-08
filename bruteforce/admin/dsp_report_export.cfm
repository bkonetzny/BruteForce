<cfsetting enablecfoutputonly="true">

<cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Export</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>FlashPaper:</th>
			<td><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=download&format=swf">Download as FlashPaper</a></td>
		</tr>
		<tr>
			<th>PDF:</th>
			<td><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=download&format=pdf">Download as PDF</a></td>
		</tr>
		<tr>
			<th>CSV:</th>
			<td><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=download&format=csv">Download as CSV</a></td>
		</tr>
		<tr>
			<th>WDDX:</th>
			<td><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=download&format=wddx">Download as WDDX</a></td>
		</tr>
		</table>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">