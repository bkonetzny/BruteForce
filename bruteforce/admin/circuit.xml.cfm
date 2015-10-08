<circuit access="public">

	<fuseaction name="main">
		<do action="analyzer"/>
	</fuseaction>

	<fuseaction name="analyzer">
		<include template="act_analyzer.cfm"/>
		<include template="dsp_analyzer.cfm"/>
	</fuseaction>

	<fuseaction name="reports">
		<include template="act_reports.cfm"/>
		<include template="dsp_reports.cfm"/>
	</fuseaction>

	<fuseaction name="report">
		<include template="act_report.cfm"/>
		<include template="dsp_report.cfm"/>
	</fuseaction>

	<fuseaction name="profiles">
		<include template="act_profiles.cfm"/>
		<include template="dsp_profiles.cfm"/>
	</fuseaction>

	<fuseaction name="rules">
		<include template="act_rules.cfm"/>
		<include template="dsp_rules.cfm"/>
	</fuseaction>

	<fuseaction name="rule">
		<include template="act_rule.cfm"/>
		<include template="dsp_rule.cfm"/>
	</fuseaction>

	<fuseaction name="settings">
		<include template="act_settings.cfm"/>
		<include template="dsp_settings.cfm"/>
	</fuseaction>

	<fuseaction name="docs">
		<include template="dsp_docs.cfm"/>
	</fuseaction>

	<fuseaction name="browseserver">
		<include template="dsp_browseserver.cfm"/>
	</fuseaction>

	<fuseaction name="about">
		<include template="dsp_about.cfm"/>
	</fuseaction>

</circuit>