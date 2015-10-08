<cfsetting enablecfoutputonly="true">

<cfoutput>
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
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=#attributes.view#&sortby=type #sNewSortdirection#">Type</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=#attributes.view#&sortby=rulename #sNewSortdirection#">Rule</a></strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom">
					<strong><a href="#request.myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#attributes.id#&view=#attributes.view#&sortby=file #sNewSortdirection#">File</a></strong>
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
					<td nowrap class="cell3BlueSides" align="center"<cfif cgi.http_user_agent CONTAINS 'MSIE'> rowspan="2" valign="top"</cfif>><img src="shared/img/icon_#type#.png" alt="#type#" title="#type#"></td>
					<td nowrap class="cellRightAndBottomBlueSide"><cfif cgi.http_user_agent CONTAINS 'MSIE'><a href="javascript:Toggle('#id#');">#rulename#</a><cfelse>#rulename#</cfif></td>
					<td nowrap class="cellRightAndBottomBlueSide">#file#</td>
					<td nowrap class="cellRightAndBottomBlueSide">#line# : #position#</td>
				</tr>
				<tr id="#id#"<cfif cgi.http_user_agent CONTAINS 'MSIE'> style="display: none;"</cfif>>
					<cfif NOT cgi.http_user_agent CONTAINS 'MSIE'><td nowrap class="cell3BlueSides">&nbsp;</td></cfif>
					<td class="cellRightAndBottomBlueSide" colspan="3">
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
											<cfset sCode = HTMLEditFormat(aCode[idx].data)>
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
</cfoutput>

<cfsetting enablecfoutputonly="false">