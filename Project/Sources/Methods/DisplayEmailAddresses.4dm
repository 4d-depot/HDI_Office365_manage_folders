//%attributes = {}
#DECLARE($mail : Object; $attribut : Text)->$result : Text
// Transform a collection of email address to a string to display it in the UI
// all the emails are converted as "name <emailAddress>" separated by ","
// $1 -> collection of email address object
// $0 -> string containing all the addresses as string

var $addresses : Variant
var $address : Object

If ($mail=Null:C1517)
	return ""
End if 


If (Value type:C1509($mail[$attribut])=Is object:K8:27)
	$addresses:=New collection:C1472($mail[$attribut])
Else 
	$addresses:=$mail[$attribut]
End if 

// string construction
For each ($address; $addresses)
	
	If ($result#"")
		$result:=$result+", "
	End if 
	
	$result:=$result+String:C10($address.emailAddress.name)+" <"+String:C10($address.emailAddress.address)+">"
	
End for each 

