<cfsetting enablecfoutputonly="true">

<cftry>
	<cfset cookie.cfadmin_lastpage = '/CFIDE/administrator/#request.stSettings.AppRootFromCfadmin#index.cfm'>
	<cfcatch><!--- try to set the cookie ---></cfcatch>
</cftry>

<cfset sTitle = ''>
<cfswitch expression="#myfusebox.thisfuseaction#">
	<cfcase value="main,analyzer">
		<cfif isDefined("attributes.form_submitted") AND attributes.form_submitted>
			<cfset sTitle = 'Analyzing Files'>
		<cfelse>
			<cfset sTitle = 'Code Analyzer'>
		</cfif>
	</cfcase>
	<cfcase value="reports"><cfset sTitle = 'Reports'></cfcase>
	<cfcase value="report"><cfset sTitle = 'Report Details'></cfcase>
	<cfcase value="profiles"><cfset sTitle = 'Profiles'></cfcase>
	<cfcase value="rules"><cfset sTitle = 'Rules'></cfcase>
	<cfcase value="rule"><cfset sTitle = 'Rule Details'></cfcase>
	<cfcase value="settings"><cfset sTitle = 'Settings'></cfcase>
	<cfcase value="browseserver"><cfset sTitle = 'Browse Server'></cfcase>
	<cfcase value="about"><cfset sTitle = 'About'></cfcase>
	<cfcase value="docs"><cfset sTitle = 'Documentation'></cfcase>
</cfswitch>

<cfoutput>
<html>
<head>
	<title>BruteForce - Extensible CodeAnalyzer</title>
	<link rel="stylesheet" type="text/css" href="shared/styles.css"/>
	<link rel="SHORTCUT ICON" href="http://localhost:80/CFIDE/administrator/favicon.ico">
	<script type="text/javascript">
		function Toggle(item) {
			var object;

			if (document.getElementById) object = document.getElementById(item);
			else object = document.all[item];
		
			if (object != undefined) {
				if (object.style.display != 'none') object.style.display = "none";
				else object.style.display = "block";
			}
			
		}
	</script>
</head>
<body bgcolor="##6C7A83">
<table width="92%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="3"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" height="1" width="540"></td>
	</tr>
	<tr>
	    <td width="10"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" width="10" height="10"></td>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="12"><img src="/CFIDE/administrator/images/cap_content_white_main_top_left.gif" width="12" height="11"></td>
			    	<td bgcolor="##FFFFFF"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" width="10" height="10"></td>
					<td width="12"><img src="/CFIDE/administrator/images/cap_content_white_main_top_right.gif" width="12" height="11"></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
			    	<td width="10" bgcolor="##FFFFFF"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" width="10" height="10"></td>
					<td bgcolor="##FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr>
								<td>
									<table width="100%">
										<tr>
											<td>&nbsp;</td>
											<td><br>
<!-- margin top -->
<span class="pageHeader">BruteForce<cfif len(sTitle)> &gt; #sTitle#</cfif></span>
<br><br>

<a href="#request.myself##myfusebox.thiscircuit#.analyzer">Code Analyzer</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<a href="#request.myself##myfusebox.thiscircuit#.reports">Reports</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<a href="#request.myself##myfusebox.thiscircuit#.rules">Rules</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<a href="#request.myself##myfusebox.thiscircuit#.profiles">Profiles</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<a href="#request.myself##myfusebox.thiscircuit#.settings">Settings</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<a href="#request.myself##myfusebox.thiscircuit#.docs">Documentation</a>

<cfif ArrayLen(aErrors)>
	<br><br><br>
	<div align="center">
		<strong class="errorText">
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="idx">
			#aErrors[idx]#<br>
		</cfloop>
		</strong>
	</div>
</cfif>

<br><br>
</cfoutput>

<cfsetting enablecfoutputonly="false">