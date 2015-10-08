<cfsetting enablecfoutputonly="true">

<cfwddx action="cfml2wddx" input="#stReport#" output="wddxReport">

<cffile action="write" file="#attributes.sFullFileName#" output="#wddxReport#" mode="777">

<cfsetting enablecfoutputonly="false">