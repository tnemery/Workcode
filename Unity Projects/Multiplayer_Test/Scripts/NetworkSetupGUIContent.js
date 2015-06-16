#pragma strict

import System;

var dialogName : String = "Network Settings";
var networkLevelToLoad : String = "MainScene";

var destroyOnLoad : Transform[];

var activateOnLoad : Transform[];

var parentToMainCameraOnLoad : Transform[];

var failedConnectionCount : int = 0;
var failedConnectionCountMax : int = 2;
var masterServerIP : String = "people.oregonstate.edu/~emeryt";
var isHosting : boolean = false;

var masterServerAutoRefreshSeconds : float = 30.0;
var masterServerTimeoutSeconds : float = 10.0;
var nextMasterServerRefreshTime : DateTime;
var nextMasterServerRefreshTimeout : DateTime;


function Start () {

}

function Update () {

}

function LoadTheMainScene(){
//	NetworkChat.displayChat = true;
//	NetworkChat.guiSkin = (transform.parent.GetComponent(GUISlideDialogWrapper) as GUISliderDialogWrapper)._skin;
//	var l_networkChatInstance : NetworkChat= NetworkChat.sharedInstance;

}