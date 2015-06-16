#pragma strict


var texOSU : Texture2D;
var mySkin: GUISkin; //GUIskinSTART?
var myStyle: GUIStyle; //GUIskinSTART?
//var secondarySkin : GUISkin; 

internal var showMenu : boolean = true;
internal var showEscMenu : boolean = false;
internal var w : int;
internal var h : int;
internal var w2 : int = 64;
internal var h2 : int = 64;
internal var yVal : int =-2;
internal var yValMenu : int = Screen.height;
internal var xValTitle : int = -183;

internal var xValOSU : int = Screen.width;
var mainCam: Camera;


function Start () {
buildTitleBar ();
}

function Update () {

}

function moveNum(myStart:int, myEnd:int, timeToTake : float) {
    var i = 0.0;
    var rate = 1.0/timeToTake ;
    while (i < 1.0) {
 		i += Time.deltaTime * rate;
		yVal = Mathf.Lerp(myStart, myEnd, i);
    	yield;
    }
}
function moveNum2(myStart:int, myEnd:int, timeToTake : float) {
    var i = 0.0;     var rate = 1.0/timeToTake ;     while (i < 1.0) {
 		i += Time.deltaTime * rate; 		yValMenu = Mathf.Lerp(myStart, myEnd, i);     	yield;
    }}
function moveNum4(myStart:int, myEnd:int, timeToTake : float) {
    var i = 0.0;     var rate = 1.0/timeToTake ;     while (i < 1.0) {
 		i += Time.deltaTime * rate; 		xValOSU = Mathf.Lerp(myStart, myEnd, i);     	yield;
    }}
function moveNum5(myStart:int, myEnd:int, timeToTake : float) {
    var i = 0.0;     var rate = 1.0/timeToTake ;     while (i < 1.0) {
 		i += Time.deltaTime * rate; 		xValTitle = Mathf.Lerp(myStart, myEnd, i);     	yield;
    }}

function buildTitleBar () {
	moveNum(yVal - 20, yVal, 1); //black bar
	moveNum4(xValOSU, 0, 1);//OSU logo
	yield WaitForSeconds (1);
	moveNum5(xValTitle, 58, 1);//Title Text
	yield WaitForSeconds (1);
	moveNum2(Screen.height *2, ( Screen.height / 2 - 140 ), 1); //Menu
}

function OnGUI () {
	GUI.Box(Rect(-2,yVal, Screen.width + 4, 22), "");	
	GUI.Label(Rect(xValTitle,2,183,20), "FW 340: Diversity Cube", myStyle);	
	GUI.Label(Rect( xValOSU, -2,w2,h2),texOSU);
}