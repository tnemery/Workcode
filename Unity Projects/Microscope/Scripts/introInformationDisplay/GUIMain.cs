using UnityEngine;
using System.Collections;

public class GUIMain : MonoBehaviour {
	
	// Use this for initialization
	void Start () {
	
	}
	
	
	void OnGUI (){
		if(GUI.Button (new Rect(Screen.width/2-125,Screen.height/2-160,250,80), "Start Game")){
			Application.LoadLevel ("gameScene");	
		}
		
		if(GUI.Button (new Rect(Screen.width/2-125,Screen.height/2-80,250,80), "Microscope Part Walkthrough")){
			Application.LoadLevel ("test");	
		}
		
	}
	
	// Update is called once per frame
	void Update () {
		
		
	}
}
