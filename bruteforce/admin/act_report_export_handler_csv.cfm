<cfsetting enablecfoutputonly="true">

<cfsavecontent variable="cvsReport">
<cfoutput>
TYPE;RULENAME;FILE;LINE;POSITION;MESSAGE;
<cfloop query="stReport.qResults">#type#;#rulename#;#file#;#line#;#position#;#message#;#chr(13)#</cfloop>
</cfoutput>
</cfsavecontent>

<cffile action="write" file="#attributes.sFullFileName#" output="#trim(cvsReport)#" mode="777">

<cfsetting enablecfoutputonly="false">