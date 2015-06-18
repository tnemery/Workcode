#pragma strict

class ObjectArray {

	var testint : int;
	var testfloat : float;
	var testArr : float[];
	
	function ObjectArray(testint : int, testfloat : float , testArr : float[]){
	
		this.testint = testint;
		this.testfloat = testfloat;
		this.testArr = testArr;
	}
	
	function changeInt(rawr : int){
		this.testint = rawr;
	}

}