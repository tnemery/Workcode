using UnityEngine;
using System.Collections;

public class gameWelcome : MonoBehaviour {
	public GUISkin welcomeSkin;
	public static bool letsGo = false;
	//public splitScreen split;
	//public joyPad joy;
	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnGUI () {
		//make a box that fills the screen
		if(letsGo == false){
			GUI.depth = 0;
			GUI.BeginGroup (new Rect(0,25,Screen.width,Screen.height-50));
				GUI.skin = welcomeSkin;
				GUI.Box (new Rect(0,25,Screen.width,Screen.height-50), ""); //create a border
				GUI.Label (new Rect(Screen.width/2-100,30,200,50), "<size=40><color=green>Welcome</color></size>");	
				GUI.Label (new Rect(100,100,Screen.width-200,Screen.height), "Currently all you may do in this game is complete easy tasks. " +
									"The goal is to complete all tasks with in the time limit given. The faster you go with more correct tasks " +
									"the higher your score and rank will be. Rank S is what you should be striving for. Click and hold down the mouse " +
									"button on the sphere and then drag the mouse to rotate the microscope.");	
			GUI.EndGroup();
			if(GUI.Button (new Rect(Screen.width/2-100,Screen.height/2,200,50), "OK")){
				letsGo = true;	
			}
		}
	}
}
