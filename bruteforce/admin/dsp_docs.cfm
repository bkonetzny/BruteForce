<cfsetting enablecfoutputonly="true">

<cffile action="read" file="#request.stSettings.RulesDirectory#__base/_rule_template.cfc" variable="sRuleTemplate">

<cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<b>Documentation</b>
	</td>
</tr>
<tr>
	<td>
		<ol>
			<li><a href="##1">How to create a new rule</a></li>
			<li><a href="##2">setInfo() function</a></li>
			<li><a href="##3">performRule() function</a></li>
			<li><a href="##4">variables.stRuntime struct</a></li>
			<li><a href="##5">calling addResult()</a></li>
		</ol>
	</td>
</tr>
<tr>
	<td>As always, the best way to get into all this stuff is to look into an existing rule.</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<a name="1"></a><b>How to create a new rule</b>
	</td>
</tr>
<tr>
	<td>This is the basic rulefile structure. Use this as a start to create your own rule.</td>
</tr>
<tr>
	<td>
		<pre>#rereplacenocase(HTMLEditFormat(sRuleTemplate),"%([a-zA-Z0-9]*)%",'<span style="color: red;">%\1%</span>','ALL')#</pre>
	</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<a name="2"></a><b>setInfo() function</b>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="200">
					<strong>Variable</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="100%">
					<strong>Description</strong>
				</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.name</td>
				<td nowrap class="cellRightAndBottomBlueSide">Holds the name of your rule.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.description</td>
				<td nowrap class="cellRightAndBottomBlueSide">Describes the use of your rule.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.category</td>
				<td nowrap class="cellRightAndBottomBlueSide">The category of your rule.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.version</td>
				<td nowrap class="cellRightAndBottomBlueSide">Internal version of your rule.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.author</td>
				<td nowrap class="cellRightAndBottomBlueSide">Name of the rule author.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.type</td>
				<td nowrap class="cellRightAndBottomBlueSide">Type of rule, default is 'simple' - use type 'collection' to group more than one rule in one rulefile.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stInfo.rulecollection</td>
				<td nowrap class="cellRightAndBottomBlueSide">Struct of rules if type is 'collection'.<br>
					The rulekey will be given to your performRule() function in variables.stRuntime.rule,<br>
					so you can perform different actions in one rulefile.</td>
			</tr>
		</table>
	</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<a name="3"></a><b>performRule() function</b>
	</td>
</tr>
<tr>
	<td>All of your rules logic goes in here. When the rule is finished, call ruleDone() to let the engine know your rule has finished properly.</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<a name="4"></a><b>variables.stRuntime struct</b>
	</td>
</tr>
<tr>
	<td>Your logic can access the following runtime values:</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="200">
					<strong>Variable</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="100%">
					<strong>Description</strong>
				</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stRuntime.file</td>
				<td nowrap class="cellRightAndBottomBlueSide">The current file which is analyzed.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stRuntime.content</td>
				<td nowrap class="cellRightAndBottomBlueSide">The filecontent of the current file.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stRuntime.rulefile</td>
				<td nowrap class="cellRightAndBottomBlueSide">The file of the current rule.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">variables.stRuntime.rule</td>
				<td nowrap class="cellRightAndBottomBlueSide">The called rule of the current rulefile.</td>
			</tr>
		</table>
	</td>
</tr>
</table>

<br><br>

<table border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
	<td bgcolor="##E2E6E7" class="cellBlueTopAndBottom">
		<a name="5"></a><b>calling addResult()</b>
	</td>
</tr>
<tr>
	<td>Whenenver your logic has an result to log, call addResult() with the following parameters:<br>
		addResult('Level','Your Message','Position in Code')</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="200">
					<strong>Variable</strong>
				</td>
				<td nowrap bgcolor="##F3F7F7" class="cellBlueTopAndBottom" width="100%">
					<strong>Description</strong>
				</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">Level</td>
				<td nowrap class="cellRightAndBottomBlueSide"><em>Optional</em><br>
					Default: information<br>
					Valid values: error, warning, information, debug</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">Your Message</td>
				<td nowrap class="cellRightAndBottomBlueSide"><em>Required</em><br>
					The message to display in the result.</td>
			</tr>
			<tr>
				<td nowrap class="cellRightAndBottomBlueSide">Position in Code</td>
				<td nowrap class="cellRightAndBottomBlueSide">Optional</td>
			</tr>
		</table>
	</td>
</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="false">