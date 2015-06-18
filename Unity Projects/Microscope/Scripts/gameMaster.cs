using UnityEngine;
using System.Collections;

public class gameMaster : MonoBehaviour {
	private bool GUIEnabled = false;
	// Use this for initialization
	void Start () {
	
	}
	
	//pack an array and send to this object, any script here can be accessed by reference and an array can be unpacked with any information needed.
	
	void TaskMaster(string name){
		if(globalVars.TaskActive[1] == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[1] = false;
			globalVars.TasksCompleted[1] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}else if(globalVars.TaskActive[2] == true && name == "MechStage"){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[2] = false;
			globalVars.TasksCompleted[2] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}else if(globalVars.TaskActive[3] == true && name == "OnOff"){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[3] = false;
			globalVars.TasksCompleted[3] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}else if(globalVars.TaskActive[4] == true && name == "OnOff"){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[4] = false;
			globalVars.TasksCompleted[4] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}else if(globalVars.TaskActive[5] == true && name == "HPLens"){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[5] = false;
			globalVars.TasksCompleted[5] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}else if(globalVars.TaskActive[6] == true && name == "Head"){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[6] = false;
			globalVars.TasksCompleted[6] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}else if(globalVars.TaskActive[7] == true && name == "Slide"){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[7] = false;
			globalVars.TasksCompleted[7] = true;
			globalVars.task = false;
			GUIEnabled = true;
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnGUI(){
		if(GUIEnabled == true){
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
				GUIEnabled = false;
			}
		}
	}
}
