#pragma strict

import System.Collections.Generic;

var checkList : List.<ObjectArray> = new List.<ObjectArray>();
var master : GameObject;
var myArr : float[];

function Start () {
	myArr = new float[5]; 
	myArr[0] = 2.3;
	myArr[1] = 4.3;
	myArr[2] = 5.6;
	checkList.Add(ObjectArray(6, 2.4, myArr));
	master.SendMessage("reciever", checkList);
}

function Update () {

}