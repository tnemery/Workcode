using UnityEngine;
using System.Collections;

public class joyPad : MonoBehaviour {
	public GUISkin solidBox;
	private GameObject micro;
	public static int rotLeftRight = 0;
	public static float upDown = 0f;
	public static float leftRight = 0f;
	public static float inOut = 0f;
	
	
	// Use this for initialization
	void Start () {
		micro = GameObject.FindGameObjectWithTag("MicroScope");
	}
	
	// Update is called once per frame
	void Update () {
		
	
	}
	
	void OnGUI(){
		GUI.BeginGroup (new Rect(Screen.width/2,0,90,90));
			GUI.skin = solidBox;
			GUI.Box (new Rect(0,0,90,90), ""); //create a border
			//GUI.skin = customGuiStyle;
			if(GUI.Button (new Rect(0,0,30,30), "RL")){
				rotLeftRight+=5;
				micro.transform.rotation = Quaternion.Euler(inOut,rotLeftRight,0);
			}
			if(GUI.Button (new Rect(30,0,30,30), "U")){
				upDown+=.1f;
				micro.transform.position = new Vector3(inOut,upDown,leftRight);
			}
			if(GUI.Button (new Rect(60,0,30,30), "RR")){
				rotLeftRight-=5;
				micro.transform.rotation = Quaternion.Euler(inOut,rotLeftRight,0);
			}
			if(GUI.Button (new Rect(0,30,30,30), "L")){
				leftRight-=.1f;
				micro.transform.position = new Vector3(inOut,upDown,leftRight);
			}
			if(GUI.Button (new Rect(60,30,30,30), "R")){
				leftRight+=.1f;
				micro.transform.position = new Vector3(inOut,upDown,leftRight);
			}
			if(GUI.Button (new Rect(0,60,30,30), "IN")){
				inOut +=.1f;
				micro.transform.position = new Vector3(inOut,upDown,leftRight);
			}
			if(GUI.Button (new Rect(30,60,30,30), "D")){
				upDown-=.1f;
				micro.transform.position = new Vector3(inOut,upDown,leftRight);
			}
			if(GUI.Button (new Rect(60,60,30,30), "OT")){
				inOut -=.1f;
				micro.transform.position = new Vector3(inOut,upDown,leftRight);
			}
			//globalVars.task = true;
			//GUI.Box (new Rect(64,0,250,80), "<color=green>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.");	
			//GUI.skin = null;
		GUI.EndGroup();	
	}
	
	
}
