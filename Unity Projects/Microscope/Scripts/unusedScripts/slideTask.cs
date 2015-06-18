using UnityEngine;
using System.Collections;

public class slideTask : MonoBehaviour {
	public GameObject taskItem;
	public GameObject taskChild;
	public GameObject taskParent;
	private bool task1;
	// Use this for initialization
	void Start () {
		taskItem = GameObject.FindGameObjectWithTag("Slide");
		taskChild = GameObject.FindGameObjectWithTag("SlideSurface");
		taskItem.renderer.enabled = false;
		taskChild.renderer.enabled = false;
		taskParent = GameObject.FindGameObjectWithTag("MechStage");
	}
	
	// Update is called once per frame
	void Update () {
		if(globalVars.TaskActive[7] == true){
			taskItem.renderer.enabled = true;
			taskChild.renderer.enabled = true;
		}
	}
	
	void OnMouseOver(){
		if(globalVars.TaskActive[7] == true &&  Input.GetMouseButtonDown(0)){
			task1 = true;
			taskItem.transform.parent = taskParent.transform; //makes the slide a child of the mechstage group
			taskItem.transform.localPosition = new Vector3((-0.01110574f), 0.1372084f, 0.00016637343f); //.01110574
			taskItem.transform.localRotation = Quaternion.Euler(0,90,0);
		}
	}
	
	void OnGUI(){
		if(task1 == true){
			guiGame.noMoreTasks = true;
			globalVars.TaskActive[7] = false;
			globalVars.TasksCompleted[7] = true;
			taskItem.transform.localPosition = new Vector3((-0.01110574f), 0.1372084f, 0.00016637343f);
			taskItem.transform.localRotation = Quaternion.Euler(0,90,0);
			GUI.Box (new Rect(Screen.width/2,Screen.height/2-50,Screen.width/2,100),"You got it!");	
			globalVars.task = false;
			if(GUI.Button (new Rect(Screen.width/2+50,Screen.height/2+50,100,50),"Turn in Task")){
				task1 = false;
				globalVars.taskComplete = true;
				guiGame.levelOneComp++;
			}	
		}
	}
}
