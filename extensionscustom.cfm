<cfparam name="variables.toggle_areas" default="serversettings,customextensions">
<cfparam name="variables.directory2extensions" default="___extensions/">
<cfparam name="variables.directory" default="#GetDirectoryFromPath(GetCurrentTemplatePath())#">
<cfparam name="variables.stExtensions" default="#StructNew()#">

<cfdirectory action="list" directory="#variables.directory#" name="qExtensions">

<cfloop query="qExtensions">
	<cfif type EQ 'dir'>
		<cfset variables.sFile = directory & '/' & name & '/extension.xml'>
		<cfif fileExists(variables.sFile)>
			<cffile action="read" file="#variables.sFile#" variable="variables.sExtensionXml">
			<cfif isXml(variables.sExtensionXml)>
				<cfset variables.sExtensionData = xmlParse(variables.sExtensionXml)>
				<cfset variables.stExtensions[name] = variables.sExtensionData.extension.name.xmltext>
			</cfif>
		</cfif>
	</cfif>
</cfloop>

<cfset variables.lExtensions = listSort(StructKeyList(variables.stExtensions),'textnocase')>

<cfloop list="#variables.lExtensions#" index="idx">
	<cfoutput><a class="leftMenuLinkText" href="#variables.directory2extensions##idx#/index.cfm" target="content">#variables.stExtensions[idx]#</a><br></cfoutput>
	<cfif idx NEQ ListLast(variables.lExtensions)>
		</td></tr>
		<tr><td class="menuTD" width="13"><img src="/CFIDE/administrator/images/spacer_5_x_5.gif" width="1" height="1"></td>
		<td class="menuTD">
	</cfif>
</cfloop>

<cfif len(variables.toggle_areas)>
<script>
<cfloop list="#variables.toggle_areas#" index="idx">
	<cfoutput>Toggle('#idx#');</cfoutput>
</cfloop>
</script>
</cfif>