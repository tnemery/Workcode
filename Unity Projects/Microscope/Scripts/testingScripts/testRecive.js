#pragma strict
import System.Collections.Generic;
function reciever(myList : List.<ObjectArray>){

	Debug.Log("Checking a sent List: "+ myList.Capacity+ " "+myList[0].testint+" "+myList[0].testfloat+" "+myList[0].testArr[1]);

	myList[0].changeInt(9);
	
	Debug.Log("Checking the change: "+myList[0].testint);

}