using UnityEngine;
using System.Collections;

public class intensityTasks : MonoBehaviour {
	public bool task1 = false;
	public bool task2 = false;
	public float rangeStart;
	public float rangeEnd;
	private GameObject taskItem;
	public Light showLight;
	private float showMe;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("OnOff");
		rangeStart = randomNumber(2,3);
		rangeEnd = randomNumber(3,4);
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnMouseOver(){
		if(globalVars.TaskActive[4] == true && (Input.GetMouseButtonDown(1) || Input.GetMouseButtonDown(0))){
			task1 = true;
		}
		if(globalVars.TaskActive[8] == true && (Input.GetMouseButtonDown(1) || Input.GetMouseButtonDown(0))){
			task2 = true;
		}
	}
	
	float randomNumber(int start, int end){
		float myRand = Random.Range (start,end)+ Random.Range (0.0f,0.9f);
		return myRand;
	}
	
	void OnGUI() {
		if(task1 == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[4] = false;
			globalVars.TasksCompleted[4] = true;
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			globalVars.task = false;
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){
				task1 = false;
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
			}
		}
		
		if(task2 == true){
			showMe = showLight.intensity;
			GUI.Box (new Rect(Screen.width/2,Screen.height/2,100,100), showMe.ToString ("F2"));
			if(showMe >= rangeStart && showMe <= rangeEnd){
				if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,50,50),"ok")){
					globalVars.TaskActive[8] = false;
					globalVars.TasksCompleted[8] = true;
					task2 = false;
					globalVars.taskComplete = true;
				}
				
			}
			
		}
			
	}
}
