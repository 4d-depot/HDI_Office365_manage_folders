Case of 
	: (FORM Event:C1606.code=On Selection Change:K2:29)
		// Emails downloading
		StartReceiving
		
		
	: (FORM Event:C1606.code=On Clicked:K2:4)
		var $office365 : cs:C1710.NetKit.Office365
		
		If (Right click:C712)
			var $status : Object
			var $name : Text
			var $vlUserChoice : Integer
			
			// Menu displaying
			$vlUserChoice:=MenuManagement
			
			If (($vlUserChoice>0) && (Form:C1466.trace))
				TRACE:C157
			End if 
			
			$office365:=cs:C1710.NetKit.Office365.new(Form:C1466.OAuth2Provider)
			
			Case of 
					// Create a new mail box as child of the selected folder
				: ($vlUserChoice=1)
					
					$name:=Request:C163("New folder name :"; ""; "Create"; "Cancel")
					If ((Bool:C1537(OK)) && ($name#""))
						If ((Form:C1466.currentFolder#Null:C1517) && (Form:C1466.currentFolder.id#Null:C1517))
							// Add a new children folder to the selected folder
							$status:=$office365.mail.createFolder($name; False:C215; Form:C1466.currentFolder.id)
						Else 
							// Add a new folder to the root
							$status:=$office365.mail.createFolder($name)
						End if 
					End if 
					
					// ******************** Remove a folder *******************
				: ($vlUserChoice=2)
					CONFIRM:C162("Would you delete the folder : "+Form:C1466.currentFolder.displayName)
					If (Bool:C1537(OK))
						// Deletion of the selected folder
						$status:=$office365.mail.deleteFolder(Form:C1466.currentFolder.id)
					End if 
					
					// ******************* Rename a folder *******************
				: ($vlUserChoice=3)
					$name:=Request:C163("Rename '"+Form:C1466.currentFolder.displayName+"' by :"; ""; "Rename"; "Cancel")
					If ((Bool:C1537(OK)) && ($name#""))
						// Rename the folder selected
						$status:=$office365.mail.renameFolder(Form:C1466.currentFolder.id; $name)
					End if 
					
					
			End case 
			
			If ($status#Null:C1517)
				// If no error, reloads the email list
				If (Bool:C1537($status.success))
					OBJECT SET VISIBLE:C603(*; "Spinner1"; True:C214)
					// Start the creation of the folder list
					CALL WORKER:C1389("myWorker"; Formula:C1597(GetFolders); Form:C1466.OAuth2Provider; Current form window:C827)
				Else 
					ALERT:C41("Error : "+$status.statusText)
				End if 
			End if 
			
		End if 
End case 