using UnityEngine;
using System.Collections;

public class HPLensTasks : MonoBehaviour {
	public bool notify = false;
	private GameObject taskItem;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("HPLens");
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnMouseDown(){
		if(globalVars.TaskActive[5] == true){
			notify = true;
		}
	}
	
	void OnGUI() {
		if(notify == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[5] = false;
			globalVars.TasksCompleted[5] = true;
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			globalVars.task = false;
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){ //turn in task from ok
				notify = false;
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
			}
		}
	}
}
