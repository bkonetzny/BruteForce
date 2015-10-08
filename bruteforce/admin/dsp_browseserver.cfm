<cfsetting enablecfoutputonly="true">

<cfoutput>
<script language="JavaScript">
<!--

	function GetSelectedPath() 
	{
	   document.FileDialogForm.newDirectoryPath.value = document.TreeControl.currentPath("\\");
	   document.FileDialogForm.submit();
	}
	function JSGetSelectedPath() 
	{
		window.opener.document.forms[0].elements.placeholder.value = document.TreeControl.currentPath("\\");
		window.close();
	}

//-->
</script>

<table border="0" cellpadding="5" cellspacing="0">
<tr>
	<td colspan="2" bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Select Directory on the Server</b>
	</td>
</tr>
<tr>
	<td nowrap class="cell3BlueSides" bgcolor="##F3F7F7">

		<applet archive="../../classes/cfadmin.jar" code="allaire.cfide.CFNavigationApplet" width=325 height=275 name="TreeControl">
			<param name="ApplicationClass" value="allaire.cfide.CFNavigation">
			<param name="ShowFiles" value="No">
			<param name="Extensions" value="">
			<param name="DefaultPath" value="">
			
			<param name="ServerCaption" value="Select Directory on the Server">
			<param name="Border" value="Yes">
			<param name="VScroll" value="Yes">
			<param name="passkey" value="F78B64C9E0F2EA24FDDCE2B0D809CB2855FED1A6">
			<param name="OS" value="Windows XP">
			
			This applet displays a file-tree of the server to enable the user to browse its contents.
			Your browser is not configured correctly to use java applets.  Please install the Java Runtime Environment (JRE) and be sure to install the browser plugins.
		</applet>
		
	</td>
	<td nowrap class="cellRightAndBottomBlueSide" bgcolor="##F3F7F7" valign="top">
		<form name="FileDialogForm" action="#request.myself##myfusebox.thiscircuit#.main" method="POST" onsubmit="return _CF_checkFileDialogForm(this)">
			<input type="hidden" name="newDirectoryPath" value="">
			<input type="Hidden" name="TreeSubmitApply" value="true">
			<input type="hidden" name="OLDNAME" value="">
			<input type="hidden" name="DIRECTORYPATH" value="">
			<input type="hidden" name="NAME" value="">
			<table border="0" cellpadding="5" cellspacing="0">
				<tr>
					<td><input type="button" name="TreeSubmitApply" value="Apply" onclick="GetSelectedPath();"></td>
				</tr>
				<tr>
					<td><input type="submit" name="cancelbrowse" value="Cancel"></td>
				</tr>
			</table>
		</form>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">