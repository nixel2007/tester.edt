
Function CallServer ( Debug, Scenario, Params = undefined, Application = undefined ) export
	
	return Runtime.Perform ( Scenario, Params, Application, false, Debug );
	
EndFunction

Function ВызватьСервер ( Debug, Scenario, Params = undefined, Application = undefined ) export
	
	return CallServer ( Debug, Scenario, Params, Application );
	
EndFunction

Function RunServer ( Debug, Scenario, Params = undefined, Application = undefined ) export
	
	return Runtime.Perform ( Scenario, Params, Application, true, Debug );
	
EndFunction

Function ПозватьСервер ( Debug, Scenario, Params = undefined, Application = undefined ) export
	
	return RunServer ( Debug, Scenario, Params, Application );
	
EndFunction
