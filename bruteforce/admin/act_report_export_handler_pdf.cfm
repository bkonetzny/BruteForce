<cfsetting enablecfoutputonly="true">

<cfdocument format="PDF" filename="#attributes.sFullFileName#" overwrite="true">
<cfoutput>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="shared/styles.css"/>
</head>
<body>
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
			<td class="print">Reportname:</th>
			<td>#stReport.name#</td>
		</tr>
		<tr>
			<td class="print">Created:</th>
			<td>#LSDateFormat(stReport.dtCreated)# #LSTimeFormat(stReport.dtCreated)#</td>
		</tr>
		<tr>
			<td class="print">Execution Time:</th>
			<td>#request.lib.hmsformat(stReport.executiontime/1000,'s')#</td>
		</tr>
		<tr>
			<td class="print">Files Analyzed:</th>
			<td>#stReport.filecount# files</td>
		</tr>
		<tr>
			<td class="print">Results by type:</th>
			<td><table cellpadding="5">
				<cfloop query="qStats">
					<tr>
						<td><img src="shared/img/icon_#type#.png" alt="#type#" title="#type#"></td>
						<td>#type#:</td>
						<td align="right">#cnt#</td>
					</tr>
				</cfloop>
				</table></td>
		</tr>
		</table>
	</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Results Summary</b>
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
					<strong>Rule</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong>File</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong>Line : Position</strong>
				</td>
			</tr>
			<cfloop query="stReport.qResults">
				<cfif isWDDX(code)>
					<cfwddx action="wddx2cfml" input="#code#" output="aCode">
				</cfif>
				<tr>
					<td nowrap class="cell3BlueSides" align="center" rowspan="2" valign="top"><img src="shared/img/icon_#type#.png" alt="#type#" title="#type#"></td>
					<td nowrap class="cellRightAndBottomBlueSide">#rulename#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#file#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#line# : #position#</td>
				</tr>
				<tr>
					<td class="cellRightAndBottomBlueSide" colspan="4">
						&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;#HTMLEditFormat(message)#<br>&nbsp;
						<cfif line NEQ 0>
							<br><em>Code:</em><br>
							<div style="padding: 10px;">
								<table>
									<cfloop from="1" to="#ArrayLen(aCode)#" index="idx">
										<cfif aCode[idx].line EQ line>
											<cfscript>
												iStartPos = position - 1;
												sOriginalCode = aCode[idx].data;
												
												if(iStartPos LTE 0) sPreString = '';
												else sPreString = left(sOriginalCode,iStartPos);
												
												if(len(sPreString)) sPostString = right(sOriginalCode,len(sOriginalCode)-len(sPreString));
												else sPostString = sOriginalCode;
												
												sPreString = replacelist(sPreString,'<,>','&lt;,&gt;');
												sPostString = replacelist(sPostString,'<,>','&lt;,&gt;');
												
												sCode = '<span class="errorText">' & sPreString & '<span style="text-decoration: underline; color: green;">' & sPostString & '</span></span>';
											</cfscript>
										<cfelse>
											<cfset sCode = trim(aCode[idx].data)>
											<cfset sCode = HTMLEditFormat(sCode)>
										</cfif>
										<tr>
											<td valign="top" style="border-right: 1px solid gray; padding-right: 5px;"><code style="color: gray;">#aCode[idx].line#</code></td>
											<td valign="top" style="padding-left: 5px;"><code>#sCode#</code></td>
										</tr>
									</cfloop>
								</table>
							</div>
						</cfif>
					</td>
				</tr>
			</cfloop>
		</table>
	</td>
</tr>
</table>
</body>
</html>
</cfoutput>
</cfdocument>

<cfsetting enablecfoutputonly="false">