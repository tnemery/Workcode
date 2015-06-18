using UnityEngine;
using System.Collections;

public class stageTasks : MonoBehaviour {
	public bool task1 = false;
	public bool task2 = false;
	private GameObject taskItem;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("MechStage");
	}
	
	// Update is called once per frame
	void Update () {
		if(globalVars.TaskActive[2] == true){
			taskItem.collider.enabled = true;
		}
		if(globalVars.TaskActive[8] == true){
			//taskItem.collider.enabled = true;
		}
	}
	
	
	void OnMouseOver(){
		if(globalVars.TaskActive[2] == true && (Input.GetMouseButtonDown(1) || Input.GetMouseButtonDown(0))){
			task1 = true;
		}
		if(globalVars.TaskActive[8] == true && (Input.GetMouseButtonDown(1) || Input.GetMouseButtonDown(0))){
			task2 = true;
		}
	}
	
	
	void OnGUI() {
		if(task1 == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[2] = false;
			globalVars.TasksCompleted[2] = true;
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			globalVars.task = false;
			taskItem.collider.enabled = false;
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){
				task1 = false;
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
			}
		}
		if(task2 == true){
			if(turnMechStageKnob.storeY.ToString("F2") == "-0.20"){
				globalVars.TaskActive[8] = false;
				globalVars.TasksCompleted[8] = true;
				GUI.Box (new Rect(Screen.width/2,Screen.height/2,100,100),"That's enough!");	
				globalVars.task = false;
				if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,50,50),"ok")){
					task2 = false;
					globalVars.taskComplete = true;
				}
			}
		}
	}
}
