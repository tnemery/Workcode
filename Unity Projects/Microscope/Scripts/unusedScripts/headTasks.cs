using UnityEngine;
using System.Collections;

public class headTasks : MonoBehaviour {
	public bool notify = false;
	private GameObject taskItem;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("Head");
	}
	
	// Update is called once per frame
	void Update () {
		if(globalVars.TaskActive[6] == true){
			taskItem.collider.enabled = true;
		}
	}
	
	void OnMouseDown(){
		if(globalVars.TaskActive[6] == true){
			notify = true;
		}
	}
	
	void OnGUI() {
		if(notify == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[6] = false;
			globalVars.TasksCompleted[6] = true;
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			globalVars.task = false;
			taskItem.collider.enabled = false;
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){
				notify = false;
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
			}
		}
	}
}
