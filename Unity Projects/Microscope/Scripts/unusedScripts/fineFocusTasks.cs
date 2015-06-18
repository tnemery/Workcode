using UnityEngine;
using System.Collections;

public class fineFocusTasks : MonoBehaviour {
	public bool task1 = false;
	public bool task2 = false;
	private GameObject taskItem;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("FineFocus");
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnMouseOver(){
		if(globalVars.TaskActive[9] == true && (Input.GetMouseButtonDown(1) || Input.GetMouseButtonDown(0))){
			task1 = true;
		}
	}
	
	void OnGUI() {
		if(task1 == true){
			GUI.Box (new Rect(Screen.width/2,Screen.height/2,100,100), turnFocus.count.ToString());
			if(turnFocus.count >= 100 && turnFocus.count <= 110){
				if(GUI.Button (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"ok")){
					globalVars.TaskActive[9] = false;
					globalVars.TasksCompleted[9] = true;
					task1 = false;
					globalVars.taskComplete = true;
				}
				
			}
		}
			
	}
}
