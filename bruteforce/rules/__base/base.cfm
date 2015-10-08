<cfscript>
	variables.stInfo = StructNew();
	variables.stInfo.name = '';
	variables.stInfo.description = '';
	variables.stInfo.category = '';
	variables.stInfo.version = '';
	variables.stInfo.author = '';
	variables.stInfo.type = 'simple';
	variables.stInfo.rulecollection = StructNew();

	variables.qResults = QueryNew('uuid,file,rulename,rule,rulefile,type,message,line,position,code','varchar,varchar,varchar,varchar,varchar,varchar,varchar,integer,integer,varchar');

	variables.stRuntime = StructNew();
	variables.stRuntime.file = '';
	variables.stRuntime.rulefile = '';
	variables.stRuntime.rule = '';
	variables.stRuntime.bRuleDone = false;
	variables.stRuntime.bHasResults = false;
	variables.stRuntime.RuleInvocationError = '';
</cfscript>