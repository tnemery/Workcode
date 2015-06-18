using UnityEngine;
using System.Collections;

public class condenserTasks : MonoBehaviour {
	public bool notify = false;
	private GameObject taskItem;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("Condenser");
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnMouseDown(){
		if(globalVars.TaskActive[1] == true){
			notify = true;
		}
	}
	
	void OnGUI() {
		if(notify == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[1] = false;
			globalVars.TasksCompleted[1] = true;
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			globalVars.task = false;
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){
				notify = false;
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
			}
		}
	}
}
