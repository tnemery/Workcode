using UnityEngine;
using System.Collections;

public class globalVars : MonoBehaviour {
	public static bool task = false;
	
	public static string[] Task = new string[50];
	public static bool[] TaskActive = new bool[50];
	public static bool[] TasksCompleted = new bool[50];
	public static bool taskComplete = false;
	public static int levelOne = 5;
	public static int levelTwo = 0;
	public static int levelThree = 0;
	
	private int count = 0;
 	//Tile[0, 0] = new float[2] { 1, 2 };

	
	// Use this for initialization
	void Start () {
		
		//initialize tasks
		//level 1
		//Task[0] = "Click The Microscope";
		//Task[1] = "Click The Condenser Knob";
		Task[1] = "Click The Microscope";
		Task[2] = "Click The Mechanical Stage";
		Task[3] = "Click The Power Switch";
		Task[4] = "Click The Intensity Knob";
		Task[5] = "Click The High Power Lens";
		Task[6] = "Click The Head";
		Task[7] = "Click the Slide to place it on the stage";
		/*
		Task[7] = "Change The Intensity";
		Task[8] = "Adjust The Stage";
		Task[9] = "Adjust The Fine Focus";
		Task[10] = "Click the Slide to place it on the stage";
		/*
		Task[10] = "Adjust The Coarse Focus";
		Task[11] = "Clean The Slide";
		Task[12] = "Change Lenses To The Scanning Lens";
		Task[13] = "Change Lenses To The Intermediate Lens";
		Task[14] = "Adjust The Condenser Knob";
		Task[15] = "Make The Slide Image Focused And Clear";
		*/
		
		//initialize accompanying bools
		for(count = 0; count < TaskActive.Length; count++){
			TaskActive[count] = false;
			TasksCompleted[count] = false;
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public static void makeProb(int num){
		//setup a problem based on what's passed to it, task list above	
	}
}
