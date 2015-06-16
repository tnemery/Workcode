using UnityEngine;
using System.Collections;

public class GUIControl : MonoBehaviour
{
	public float GenderSlider = 0.0F;
	public float RaceSlider = 0.0F;
	public float ClassSlider = 0.0F;
	public GUISkin slider1skin;
	public GUISkin slider2skin;
	public GUISkin slider3skin;
	public GUISkin popup;
	private bool PopUp = false;
	private int[] set2Dview;
	private int numSelectedOptions = 0;
	private string selectedButtons = "";
	//static private bool login = true;
	static public GameObject ns; //holds the network settings
	//static public GameObject loginCall; //holds the login settings
	bool show3d = false;
	
	void Awake ()
	{
		ns = GameObject.Find("__Network"); 
		//loginCall = GameObject.Find("__Login");
		ns.GetComponent<networkAssist>().getOnid();
		set2Dview = new int[3];
		for (int x = 0; x<3; x++)
			set2Dview [x] = 0;
	}
	
	void OnGUI ()
	{
		//loginCall.SendMessage("check");
		#region main Menu GUI		
		//main Menu GUI
		if (GameMaster.defaultScene == true) {			
			GUI.color = Color.black;
			GUI.Label (new Rect (0, Screen.height-20, Screen.width, 25), "Note: Please allow popups for this program so that you may login and use the features, thank you.");
			if (GUI.Button (new Rect (Screen.width / 2, Screen.height / 2 - 80, 100, 40), "Your Data")) {
				Application.LoadLevel ("CreateSphere");
				GameMaster.setSceneGUI ("create");
				//loginCall.SendMessage("check");
			}
			if (GUI.Button (new Rect (Screen.width / 2, Screen.height / 2 - 30, 100, 40), "Class Data")) {
				Application.LoadLevel ("showClass");
				GameMaster.setSceneGUI ("class");
				ClassView.SetVals ("inClass");
				//loginCall.SendMessage("check");
			}
		}
		#endregion
		
		#region create data GUI
		if (GameMaster.createScene == true) {
			if (GUI.Button (new Rect (Screen.width / 1.85f, Screen.height / 1.2f, 100, 40), "Go Back")) {
				Application.LoadLevel ("mainMenu");
				GameMaster.setSceneGUI ("default");
			}
			if (GUI.Button (new Rect (Screen.width / 1.3f, Screen.height / 1.2f, 100, 40), "Submit")) {
				Application.LoadLevel ("showClass");
				GameMaster.setSceneGUI ("class");
				SoloView.setPlayerStats (PopulateCube.newX, PopulateCube.newY, PopulateCube.newZ);
				ClassView.SetVals ("inClass");
				//GameObject ns = GameObject.Find("__Network");
				
				ns.GetComponent<networkAssist>().SendDataToPHP(); //calls a function without the use of static protection
			}
			GUI.skin = slider1skin;
			GenderSlider = GUI.HorizontalSlider (new Rect (Screen.width / 1.9f, Screen.height / 3.9f, Screen.width / 3, 30), GenderSlider, -0.005F, 0.005F);
			GUI.Label (new Rect (Screen.width / 1.9f, Screen.height / 3.1f, Screen.width / 3, 20), helperText (GenderSlider, "Gender"));
			
			GUI.skin = slider2skin;
			ClassSlider = GUI.HorizontalSlider (new Rect (Screen.width / 1.9f, Screen.height / 2.1f, Screen.width / 3, 30), ClassSlider, -0.005F, 0.005F);
			GUI.Label (new Rect (Screen.width / 1.9f, Screen.height / 1.85f, Screen.width / 3, 20), helperText (ClassSlider, "Money"));
			
			GUI.skin = slider3skin;
			RaceSlider = GUI.HorizontalSlider (new Rect (Screen.width / 1.9f, Screen.height / 1.45f, Screen.width / 3, 30), RaceSlider, -0.005F, 0.005F);
			GUI.Label (new Rect (Screen.width / 1.9f, Screen.height / 1.33f, Screen.width / 3, 20), helperText (RaceSlider, "Race"));
			
			GameMaster.SaveAxis (GenderSlider, RaceSlider, ClassSlider, false);
			
		}
		#endregion
		
		#region show Class GUI
		if (GameMaster.classScene == true) {
			GUI.color = Color.black;
			GUI.Label (new Rect (0, Screen.height-20, Screen.width, 25), "2D Perspective: ");
			//2D views
			GUI.color = Color.white;
			if (GUI.Button (new Rect (120, Screen.height-41, 100, 40), "Gender / Class")) {
				//button for gender/class option
				ClassView.UnsetVals ();
				ClassView.SetVals ("gc");
				show3d = true;
			}
			if (GUI.Button (new Rect (260, Screen.height-41, 100, 40), "Race / Gender")) {
				//button for race/gender option
				ClassView.UnsetVals ();
				ClassView.SetVals ("rg");
				show3d = true;
			}
			if (GUI.Button (new Rect (400, Screen.height-41, 100, 40), "Class / Race")) {
				//button for class/race option
				ClassView.UnsetVals ();
				ClassView.SetVals ("cr");
				show3d = true;
			}
			if(show3d){
				GUI.Label (new Rect (Screen.width / 1.85f, Screen.height-20, Screen.width, 25), "3D Perspective: ");
				if (GUI.Button (new Rect (Screen.width / 1.85f+120, Screen.height-41, 100, 40), "3D view")) {
					//button for class/race option
					ClassView.UnsetVals ();
					ClassView.SetVals ("default");
					show3d = false;
				}
			}
			//end 2D views
			//if (PopUp == false) {
				if (GUI.Button (new Rect (Screen.width / 1.85f, Screen.height / 1.2f, 100, 40), "Go Back")) {
					Application.LoadLevel ("CreateSphere");
					GameMaster.setSceneGUI ("create");
				}
		/*		if (GUI.Button (new Rect (Screen.width / 1.3f, Screen.height / 1.2f, 100, 40), "2D View")) {
					PopUp = true;
				}
			} else if (PopUp == true) {
				popUpWindow ();
			} */
		}
		#endregion
		
		#region 2D Class view
		//class 2D view
		if (GameMaster.class2DScene == true) {
			GUI.color = Color.black;
			GUI.color = Color.white;
			if (PopUp == false) {
				if (GUI.Button (new Rect (Screen.width / 1.9f, Screen.height / 1.2f, 100, 40), "New Sides")) {
					PopUp = true;
				}
				
				if (GUI.Button (new Rect (Screen.width / 1.3f, Screen.height / 1.2f, 100, 40), "3D View")) {
					GameMaster.setSceneGUI ("class");
					Application.LoadLevel ("showClass");
				}
			} else if (PopUp == true) {
				popUpWindow ();
			}
		}
		#endregion
	}
	
	//THis function returns a string to the GUI that is then displayed to the user so they can see where they are on the sliders
	string helperText (float howMuch, string whatAmI)
	{
		if (whatAmI == "Gender") {
			if (howMuch <= -.0025f) {
				return "Transgender";	
			} else if (howMuch <= 0 && howMuch > -.0025f) {
				return "Indeterminate";	
			} else if (howMuch <= .0025f && howMuch > 0) {
				return "Female";
			} else {
				return "Male";
			}
		} else if (whatAmI == "Race") {
			if (howMuch <= -.0017f) {
				return "Darkest";	
			} else if (howMuch <= .0016f && howMuch > -.0017f) {
				return "Inbetween";	
			} else {
				return "Lightest";
			}
		} else if (whatAmI == "Money") {
			if (howMuch <= -.0030f) {
				return "Generational Poverty";	
			} else if (howMuch <= -.0010f && howMuch > -.0030f) {
				return "Working Class";	
			} else if (howMuch <= .0010f && howMuch > -.0010f) {
				return "Middle Class";
			} else if (howMuch <= .0030f && howMuch > .0010f) {
				return "Upper Class";
			} else {
				return "Generational Wealth";
			}
		}
		return "Error";
	}
	
	
	//popup window to view the 2d sides of the cube.  this should just move to x/y/z axis of the plan relative to the camera
	void popUpWindow ()
	{
		
		GUI.BeginGroup (new Rect (Screen.width / 4, Screen.height / 4, (Screen.width / 4 + Screen.width / 2) - Screen.width / 4, (Screen.height / 4 + Screen.height / 2) - Screen.height / 4), "");
		int tempwidth = (Screen.width / 4 + Screen.width / 2) - Screen.width / 4;
		int tempheight = (Screen.height / 4 + Screen.height / 2) - Screen.height / 4;
		//border of the group
		GUI.depth = 0;
		GUI.Box (new Rect (0, 0, (Screen.width / 4 + Screen.width / 2) - Screen.width / 4, (Screen.height / 4 + Screen.height / 2) - Screen.height / 4), "");
		GUI.depth = 3;
		GUI.color = Color.cyan;
		if (GUI.Button (new Rect (5, 20, 100, 40), "Gender / Class")) {
			//button for gender/class option
			ClassView.UnsetVals ();
			ClassView.SetVals ("gc");
			PopUp = false;
		}
		GUI.color = Color.red;
		if (GUI.Button (new Rect (5, 80, 100, 40), "Race / Gender")) {
			//button for race/gender option
			ClassView.UnsetVals ();
			ClassView.SetVals ("rg");
			PopUp = false;
		}
		GUI.color = Color.green;
		if (GUI.Button (new Rect (5, 140, 100, 40), "Class / Race")) {
			//button for class/race option
			ClassView.UnsetVals ();
			ClassView.SetVals ("cr");
			PopUp = false;
		}
		
		if (GUI.Button (new Rect (125, 20, 100, 40), "3D view")) {
			//button for class/race option
			ClassView.UnsetVals ();
			ClassView.SetVals ("default");
			PopUp = false;
		}
		//the text area will display what the user has selected
			
		GUI.color = Color.white;
		GUI.EndGroup ();
	}
	
	
}