<cfscript>
request.self = cgi.script_name;
request.myself = request.self & "?" & application[FUSEBOX_APPLICATION_KEY].fuseactionVariable & "=";
</cfscript>

<cfinclude template="settings.default.cfm">

<cfif FileExists(request.stSettings.AppRoot & 'settings.custom.cfm')>
	<cfinclude template="settings.custom.cfm">
</cfif>

<cfinclude template="lib/byteconvert.cfm">
<cfset request.lib.byteconvert = byteconvert>
<cfinclude template="lib/refindall.cfm">
<cfset request.lib.refindall = refindall>
<cfinclude template="lib/hmsformat.cfm">
<cfset request.lib.hmsformat = hmsformat>