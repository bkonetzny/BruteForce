<cfset FUSEBOX_APPLICATION_KEY = 'cfide___extension_bruteforce'>

<cfif right(cgi.script_name, Len("index.cfm")) NEQ "index.cfm" AND right(cgi.script_name, 3) NEQ "cfc">
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<cfinclude template="fusebox5/fusebox5.cfm">