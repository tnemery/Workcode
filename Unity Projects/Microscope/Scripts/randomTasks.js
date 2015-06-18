#pragma strict

var tasks: int[];


function Start () {
	tasks = new int[5];
	genTask();
}

function Update () {
	
}

function genTask(){
	var getNum:int = randomNumber(0,14);
	var maxTasks:int = 5;
	var count:int = 0;
	while(count < maxTasks){
		for(var i:int=0;i<count+1;i++){
			if(tasks[i] == getNum){
				getNum = randomNumber(0,14);
				i = -1;
			}
		}
		tasks[count] = getNum;
		count++;
	}
	
}


function randomNumber( start:int,  end:int):int{
	return Random.Range(start, end);
}
	