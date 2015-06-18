using UnityEngine;
using System.Collections;

public class objectSender : MonoBehaviour {
	public GameObject master;
	public GameObject objToSend;
	public GameObject taskItem;
	public GameObject taskChild;
	public GameObject taskParent;
	// Use this for initialization
	void Start () {
		//slide tasks
		taskItem = GameObject.FindGameObjectWithTag("Slide");
		taskChild = GameObject.FindGameObjectWithTag("SlideSurface");
		taskItem.renderer.enabled = false;
		taskChild.renderer.enabled = false;
		taskParent = GameObject.FindGameObjectWithTag("MechStage");
		//end slide tasks
	}
	
	// Update is called once per frame
	void Update () {
		if(globalVars.TaskActive[7] == true){
			taskItem.renderer.enabled = true;
			taskChild.renderer.enabled = true;
		}
	}
	
	void OnMouseDown(){
		if(globalVars.TaskActive[7] == true){
			taskItem.transform.parent = taskParent.transform;
			taskItem.transform.localPosition = new Vector3((-0.01110574f), 0.1372084f, 0.00016637343f);
			taskItem.transform.localRotation = Quaternion.Euler(0,90,0);
		}
		master.SendMessage("TaskMaster",objToSend.tag);
	}
}
