
Procedure Prepare ( Callback = undefined ) export
	
	BeginAttachingFileSystemExtension ( new NotifyDescription ( "AttachingFileSystemExtension", ThisObject, Callback ) );
	
EndProcedure 

Procedure AttachingFileSystemExtension ( Connected, Callback ) export
	
	if ( Connected ) then
		if ( Callback <> undefined ) then
			ExecuteNotifyProcessing ( Callback );
		endif; 
	else
		BeginInstallFileSystemExtension ( new NotifyDescription ( "InstallingFileSystemExtension", ThisObject, Callback ) );
	endif; 
	
EndProcedure 

Procedure InstallingFileSystemExtension ( Callback ) export
	
	Prepare ( Callback );
	
EndProcedure 

Procedure SetDocumentsFolder ( Callback = undefined ) export
	
	p = new NotifyDescription ( "StartSetDocumentsFolder", ThisObject, Callback );
	LocalFiles.Prepare ( p );

EndProcedure

Procedure StartSetDocumentsFolder ( Result, Callback ) export
	
	BeginGettingDocumentsDir ( new NotifyDescription ( "GettingDocumentsFilesDir", ThisObject, Callback ) );
	
EndProcedure 

Procedure GettingDocumentsFilesDir ( Result, Callback ) export
	
	UserDocumentsFolder = Result;
	if ( Callback <> undefined ) then
		ExecuteNotifyProcessing ( Callback );
	endif; 
	
EndProcedure 

Procedure CheckExistence ( Path, Callback ) export
	
	p = new Structure ( "Path, Callback", Path, Callback );
	bridge = new NotifyDescription ( "StartCheckExistence", ThisObject, p );
	LocalFiles.Prepare ( bridge );
	
EndProcedure 

Procedure StartCheckExistence ( Result, Params ) export
	
	file = new File ( Params.Path );
	file.BeginCheckingExistence ( Params.Callback );
	
EndProcedure 

Procedure CreateFolder ( Folder, Callback = undefined ) export
	
	p = new Structure ( "Folder, Callback", Folder, Callback );
	bridge = new NotifyDescription ( "FolderExists", ThisObject, p );
	LocalFiles.CheckExistence ( Folder, bridge );
	
EndProcedure 

Procedure FolderExists ( Exists, Params ) export
	
	if ( Exists ) then
		if ( Params.Callback <> undefined ) then
			ExecuteNotifyProcessing ( Params.Callback, true );
		endif;
	else
		bridge = new NotifyDescription ( "BeginCreatingFolder", ThisObject, Params.Callback );
		BeginCreatingDirectory ( bridge, Params.Folder );
	endif; 
	
EndProcedure 

Procedure BeginCreatingFolder ( Result, Callback ) export
	
	if ( Callback <> undefined ) then
		ExecuteNotifyProcessing ( Callback, Result <> undefined );
	endif;
	
EndProcedure 

Procedure Modification ( Path, Callback ) export
	
	p = new Structure ( "Path, Callback", Path, Callback );
	bridge = new NotifyDescription ( "StartModification", ThisObject, p );
	LocalFiles.CheckExistence ( Path, bridge );
	
EndProcedure 

Procedure StartModification ( Exists, Params ) export
	
	if ( Exists ) then
		file = new File ( Params.Path );
		file.BeginGettingModificationTime ( Params.Callback );
	else
		ExecuteNotifyProcessing ( Params.Callback, undefined );
	endif; 
	
EndProcedure 

Procedure Rename ( Path, NewPath, Callback ) export
	
	p = new Structure ( "Path, NewPath, Callback", Path, NewPath, Callback );
	bridge = new NotifyDescription ( "StartRenaming", ThisObject, p );
	LocalFiles.Prepare ( bridge );
	
EndProcedure 

Procedure StartRenaming ( Result, Params ) export
	
	BeginMovingFile ( Params.Callback, Params.Path, Params.NewPath );
	
EndProcedure 
