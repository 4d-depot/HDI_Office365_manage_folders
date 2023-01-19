//%attributes = {}
#DECLARE->$vlUserChoice : Integer

var $vtItems : Text

$vlUserChoice:=0

// open pop up menu
If (Form:C1466.currentFolder#Null:C1517)
	$vtItems:="New folder;Delete folder;Rename folder"
	// open the menu
	$vlUserChoice:=Pop up menu:C542($vtItems)
Else 
	// if no folder selected, you can just create a folder 
	$vtItems:="New folder"
	$vlUserChoice:=Pop up menu:C542($vtItems)
End if 