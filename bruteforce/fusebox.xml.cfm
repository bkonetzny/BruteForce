<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox>
<fusebox>
	<circuits>
		<circuit alias="admin" path="admin/" parent="" />
	</circuits>

	<classes>
	</classes>

	<parameters>
		<parameter name="fuseactionVariable" value="fuseaction" />
		<parameter name="defaultFuseaction" value="admin.main" />
		<parameter name="mode" value="production"/><!-- set to "production" on live server, to "development" on dev server -->
		<parameter name="password" value=""/>
		<parameter name="characterEncoding" value="utf-8"/>
	</parameters>

	<globalfuseactions>
		<appinit/>
		<preprocess/>
		<postprocess/>
	</globalfuseactions>

	<plugins>
		<phase name="preProcess">
			<plugin name="SystemCheck" template="act_systemcheck.cfm"/>
			<plugin name="LayoutFooter" template="dsp_layout_preprocess.cfm"/>
		</phase>
		<phase name="preFuseaction">
		</phase>
		<phase name="postFuseaction">
		</phase>
		<phase name="fuseactionException">
		</phase>
		<phase name="postProcess">
			<plugin name="LayoutFooter" template="dsp_layout_postprocess.cfm"/>
		</phase>
		<phase name="processError">
		</phase>
	</plugins>

</fusebox>