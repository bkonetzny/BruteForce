<cfscript>
request.stSettings = StructNew();
request.stSettings.AppRoot = GetDirectoryFromPath(GetCurrentTemplatePath());
request.stSettings.AppVersion = '1.0 (beta 1)';
request.stSettings.AppChange = '2006-08-29';
stRegexAdmindir = refindNoCase("(CFIDE(\\)?(/)?administrator)",request.stSettings.AppRoot,1,true);
request.stSettings.AppRootFromCfadmin = right(request.stSettings.AppRoot,len(request.stSettings.AppRoot)-(stRegexAdmindir.pos[1]+stRegexAdmindir.len[1]));
request.stSettings.Scanner.DefaultDirectory = request.stSettings.AppRoot;
request.stSettings.FilterFileInclude = '*.cfm;*.cfc';
request.stSettings.FilterFileExclude = '*.ini.cfm;*.xml.cfm;*.wddx.cfm';
request.stSettings.FilterDirectoryInclude = '';
request.stSettings.FilterDirectoryExclude = '*plugins*;*parsed*;*fusebox*';
request.stSettings.RuleTypes = 'CFC,CFM,XML';
request.stSettings.RuleExtensions = 'cfc,cfm,cfml,xml';
request.stSettings.RulesDirectory = GetDirectoryFromPath(GetCurrentTemplatePath()) & 'rules/';
request.stSettings.ReportDirectory = GetDirectoryFromPath(GetCurrentTemplatePath()) & 'reports/';
request.stSettings.bDeleteRules = false;
request.stSettings.bDeleteReports = false;
request.stSettings.bDeleteProfiles = false;
request.stSettings.bUseThreading = false;
request.stSettings.bUseDatasource = true;
request.stSettings.Datasource = '';
request.stSettings.PrintFormat = 'swf';
request.stSettings.lAnalyzerLevels = 'error,warning,information,debug';
</cfscript>