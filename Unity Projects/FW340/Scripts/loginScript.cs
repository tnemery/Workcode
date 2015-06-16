/// <summary>
/// Login script.
/// This script uses the newtowrk settings that are imbedded on a global game object ns to check
/// if a user is logged in or needs to log in.
/// 
/// if a user is logged in then this script should do nothing
/// 
/// if a user needs to login then it will pop up a window asking them to login and then send the onid to be stored for later
/// </summary>

using UnityEngine;
using System.Collections;

public class loginScript : MonoBehaviour {
	public GameObject ns;
	
	static bool login = true;
	
	// Use this for initialization
	void Awake () {
		DontDestroyOnLoad(this); //makes sure that the game object this is attached to is not destroyed between scenes
		//if(login){ //if the user needs to login then this is accessed
			//login = false;
			ns.GetComponent<networkAssist>().getOnid(); //grab the onid from the networksettings
			//check(); //call this function to make sure we got an onid
		//} 
	}
	
	//checks to see if the user has logged in already, if they have it will close the window if they havent it will ask them to login.
	void check(){
		ns.GetComponent<networkAssist>().getOnid(); //get the onid again
		/*
		if(	ns.GetComponent<networkAssist>().onid == "" || ns.GetComponent<networkAssist>().onid == "default" ||
			ns.GetComponent<networkAssist>().onid.Length > 30){ //if the onid is not valid reload the main menu and ask again
			Application.LoadLevel ("mainMenu");
			GameMaster.setSceneGUI ("default"); //call GameMaster script directly to set the UI to mainmenu UI
			loginAgain(); //call this function to load a new login window
		}else{
			Application.ExternalEval("window.close('http://oregonstate.edu/instruct/dce/fw340/cube/index2.php','Login Screen')"); //this is suppose to close the window after you login
		}
		*/
	}
	
	//calls the login page, this is a php script that asks the user to log in, uses index2.php
	//ExternalEval parses code into a javascript command as done on a webpage and executes it.  The argument after the webpage is the title that will appear on the page browser
	void loginAgain(){
		Application.ExternalEval("window.open('http://oregonstate.edu/instruct/dce/fw340/cube/index2.php','Login Screen')"); //open a new login window
		ns.GetComponent<networkAssist>().getOnid(); //get a new onid
		check (); // check again
	}
}
