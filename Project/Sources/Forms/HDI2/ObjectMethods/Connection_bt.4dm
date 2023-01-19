var $OAuthParameters : Object

$OAuthParameters:=New object:C1471()
$OAuthParameters.name:="Microsoft"
$OAuthParameters.permission:="signedIn"
// Parameters create in Microsoft identity platform
$OAuthParameters.clientId:="2e5657d9-54de-411b-a305-bad53b0231d1"
$OAuthParameters.redirectURI:="http://127.0.0.1:50993/authorize/"
$OAuthParameters.scope:="offline_access https://graph.microsoft.com/.default"
$OAuthParameters.timeout:=60


// Oauth2 provider creation
Form:C1466.OAuth2Provider:=New OAuth2 provider($OAuthParameters)

OBJECT SET VISIBLE:C603(*; "Spinner1"; True:C214)

// Start the creation of the folder list
CALL WORKER:C1389("myWorker"; Formula:C1597(GetFolders); Form:C1466.OAuth2Provider; Current form window:C827)