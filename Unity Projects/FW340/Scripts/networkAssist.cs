/// <summary>
/// Network assist.
/// This script is a compilation of all the network settings that the program will use
/// 
/// this is the place I went to when I needed to learn how to do this:
/// http://answers.unity3d.com/questions/11021/how-can-i-send-and-receive-data-to-and-from-a-url.html
/// 
/// anything that is referencing this script must be done in this way:
/// object.getComponent<networkAssist>().function(vars); //this tells unity to look inside of the object for the script in the <> for the function after
/// 
/// </summary>


using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class networkAssist : MonoBehaviour {
	
	private bool test1 = false;
	private bool test2 = false;
	private bool test3 = false;
	private bool errcheck = false;
	private int x = 0;
	private int y = 0;
	private int z = 0;
	private static string myData = "";
	private static string myOnid = "";
	private string URL = "";
	public string onid = "";
	public WWW ww;
	
	/// <summary>
	/// make sure these settings persist through all levels
	/// </summary>
	void Awake() {
		//DontDestroyOnLoad(this); //this allows the settings to persist instead of dying every scene change
	}
	
	/// <summary>
	/// need to rename this function
	/// grabs the current onid, x,y, and z spots and sends them to a php script that will store the values to a database
	/// </summary>
	public void SendDataToPHP(){
		test1 = true;
		URL = "http://oregonstate.edu/instruct/dce/fw340/cube/fw340cubePostAndShow.php?onid="+onid+"&x="+x+"&y="+y+"&z="+z; //php script that will store the onid, x, y, and z to a database
		Debug.Log (URL); 
		WWW www = new WWW(URL);
		StartCoroutine(Connect(www)); //coroutine to connect to the script, stops the program while this is happening
		
	}
	 
	/// <summary>
	/// this function is called from a coroutine which means it needs to return an IEnumerator
	/// example of IEnumerator is yield return new WaitForSeconds(2); equivalent to javascript yield
	/// the internal code is parsing the WWW url that the URL is linked to, if it can access the URL then the echo data is transfered to myData
	/// </summary>
	IEnumerator Connect(WWW www) {
		myData = www.text;
		//yield return www;
		//WWW ww = new WWW (URL); //create a new WWW mod which will access the url
		if (www.error == null) //check to see if there were errors writing the data
        {
            Debug.Log("WWW Ok!: " + www.text); //no errors so grab the data that was returned and put it in the variable myData
				myData = www.text;
				test2 = true;
        } else {
            Debug.Log("WWW Error: "+ www.error); //an error occured while grabbing data
        } 
		yield return www; //wait for the page to finish calling the script
		// yield return new WaitForSeconds(2); //halt the program for 2 seconds before resuming
	}
	
	
	/// <summary>
	/// this function is called from a coroutine which means it needs to return an IEnumerator
	/// example of IEnumerator is yield return new WaitForSeconds(2); equivalent to javascript yield
	/// the internal code is parsing the WWW url that the URL is linked to, if it can access the URL then the echo data is transfered to myOnid
	/// </summary>
	IEnumerator onidReciever() { //this coroutine is used for getting the onid
		ww = new WWW (URL); //create a new WWW mod
		//myOnid = ww.text;

		//test3 = true;
		yield return ww;
		if (ww.error == null)
        {
            Debug.Log("WWW Ok!: " + ww.text);
			test3 = true;
				myOnid = ww.text; //if no errors store the returned data as myOnid
        } else {
			errcheck = true;
            Debug.Log("WWW Error: "+ ww.error);
        } 
		//return null;

		 //yield return new WaitForSeconds(2);
	}
	
	//grabs the data from the database and converts the data to a solid number from 1 through 100 instead of the decimals that the program
	//reads them as 
	public void recieveNums(float curX, float curY, float curZ){ 
		
		x = Mathf.FloorToInt(curX * 10000)+50; 
		y = Mathf.FloorToInt(curY * 10000)+50;
		z = Mathf.FloorToInt(curZ * 10000)+50;
		onid = myOnid; //set the onid to be what was recieved
		if(onid == "") onid = "default"; //if we have no onid set its name to default
		Debug.Log ("x: "+x+" y: "+y+" z: "+z);
	}
	
	//grabs the onid name fomr the index page


	public void getOnid(){
		URL = "http://oregonstate.edu/instruct/dce/fw340/cube/FW340DiversityCube.php?action=onid"; //calls the login page for viewing
		//URL = "http://oregonstate.edu/instruct/dce/fw340/cube/test.html";
		//Application.ExternalEval("window.close('http://oregonstate.edu/instruct/dce/fw340/cube/index2.php','Login Screen')"); //suppose to force close the window if its open
		//Debug.Log (URL);
		//test3 = true;
		//WWW ww = new WWW (URL); //create a new WWW mod
		//myOnid = ww.text;
		StartCoroutine(onidReciever()); //calls the coroutine to recieve data for onid
		//Application..OpenURL(URL);
		onid = myOnid; //sets the onid again just in case
	}
	
	void OnGUI (){ //for online debugging
		GUI.color = Color.black;
		//getOnid();
		//GUI.Label (new Rect (0,Screen.height-150, 800, 20), "wwerror = "+ ww.error);
		//GUI.Label (new Rect (0,Screen.height-130, 800, 20), "mydata = "+ ww.text);
		GUI.Label (new Rect (0,Screen.height-110, 800, 20), "onidReciever = "+ test3);
		//GUI.Label (new Rect (0,Screen.height-90, 800, 20), "Connect = "+ test2);
		//GUI.Label (new Rect (0,Screen.height-70, 800, 20), "SendDataToPHP = "+ test1);
		//GUI.Label (new Rect (0,Screen.height-50, 800, 20), "onid = "+ myOnid);
		GUI.Label (new Rect (0,Screen.height-50, 800, 20), "error = "+ errcheck);
		GUI.Label (new Rect (0,Screen.height-160, 800, 20), "URL = "+URL);
	}
	
}