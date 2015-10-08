<cfsetting enablecfoutputonly="true">

<cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Report Info</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<tr>
			<th>Reportname:</th>
			<td>#stReport.name#</td>
		</tr>
		<tr>
			<th>Created:</th>
			<td>#LSDateFormat(stReport.dtCreated)# #LSTimeFormat(stReport.dtCreated)#</td>
		</tr>
		<tr>
			<th>Execution Time:</th>
			<td>#request.lib.hmsformat(stReport.executiontime/1000,'s')#</td>
		</tr>
		<tr>
			<th>Files Analyzed:</th>
			<td>#stReport.filecount# files</td>
		</tr>
		<tr>
			<th>Results by type:</th>
			<td><table cellpadding="5">
				<cfloop query="qStats">
					<tr>
						<td><img src="shared/img/icon_#type#.png" alt="#type#" title="#type#"></td>
						<td>#type#:</td>
						<td align="right">#cnt#</td>
						<cfif attributes.view EQ 'summary'>
							<td align="center">
								<cfif ListFind(attributes.hide,type)>
									<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=summary&hide=#ListDeleteAt(attributes.hide,ListFind(attributes.hide,type))#">[show]</a>
								<cfelse>
									<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=summary&hide=#type#,#attributes.hide#">[hide]</a>
								</cfif>
							</td>
						</cfif>
					</tr>
				</cfloop>
				</table></td>
		</tr>
		</table>
	</td>
</tr>
</table>

<cfif stReport.executiontime EQ 0>
	<br><br>
	
	<div align="center">
		<strong class="errorText">This report is currently running or has aborted abnormally.</strong>
	</div>
</cfif>

<br><br>

<table width="100%">
	<tr>
		<td>
			<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=summary">Summary</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
			<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=files">Files</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
			<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=parameters">Parameters</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
			<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=print">Print</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
			<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=export">Export</a>
		</td>
		<cfif attributes.view EQ 'print'>
			<td align="right">
				<a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=download&format=#request.stSettings.PrintFormat#">Download</a>
			</td>
		</cfif>
	</tr>
</table>

<br><br>
</cfoutput>

<cfswitch expression="#attributes.view#">
	<cfcase value="summary">
		<cfinclude template="act_report_summary.cfm">
		<cfinclude template="dsp_report_summary.cfm">
	</cfcase>
	<cfcase value="files">
		<cfinclude template="act_report_files.cfm">
		<cfinclude template="dsp_report_files.cfm">
	</cfcase>
	<cfcase value="parameters">
		<cfinclude template="dsp_report_parameters.cfm">
	</cfcase>
	<cfcase value="print">
		<cfinclude template="act_report_export_handler.cfm">
		<cfinclude template="dsp_report_print.cfm">
	</cfcase>
	<cfcase value="download">
		<cfinclude template="act_report_export_handler.cfm">
		<cfinclude template="act_report_download.cfm">
	</cfcase>
	<cfcase value="export">
		<cfinclude template="dsp_report_export.cfm">
	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="false">