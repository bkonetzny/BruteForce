# BruteForce
BruteForce Code Analyzer for ColdFusion

This is an easy to extend Code Analyzer for ColdFusion.
Look into the rules folder to get an idea about making your own rules.

Main Features:
- Extensible rules, deploy a cfc with a single rule or a rulecollection
- Save analyzer setttings as profile
- Backup option for rules, reports and profiles
- 4 result types (warn, error, info, debug)

Save this tool under '___extensions/bruteforce/' in your 'CFIDE/Administrator/' folder
or adjust 'request.stSettings.AppRootFromCfadmin' in settings.default.cfm

For the datasource there is an install.sql file with the db structure.
This tool is tested with mysql 5 but should work with any other db system.

If not configured properly BruteForce will take you automatically to the settings screen
where you should set up the datasource an the bruteforce mapping, which is required.

Currently only cfc based rules are allowed, but cfm and xml rules are in the pipe.
