using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System;

public class ClassView : MonoBehaviour
{
	public Transform cubey;
	public Transform parent;
	private Transform clone;
	static bool gc = false;
	static bool rg = false;
	static bool cr = false;
	static bool default3D = false;
	static bool inClass = false;
	private float[] classX;
	private float[] classY;
	private float[] classZ;
	private string[] xs;
	private string[] ys;
	private string[] zs;
	private float defScaleX;
	private float defScaleY;
	private float defScaleZ;
	private string myCoords;
	private string URL = "";
	
	public static float yourX;
	public static float yourY;
	public static float yourZ;
	
	private Vector2 scrollPosition = Vector2.zero;
	
	GameObject ns; //reference to the network settings
	
	void Start ()
	{
		getData (); //grab the data to setup the scene
		defScaleX = parent.localScale.x;
		defScaleY = parent.localScale.y;
		defScaleZ = parent.localScale.z;
		//Debug.Log ("x: " + defScaleX + "y: " + defScaleY + "z: " + defScaleZ);
		
	}
	
	//used to grab the data from the database - these functions are actually called by initiating getData() at the start of the scene
	IEnumerator Connect() {
		WWW ww = new WWW (URL); 
		yield return ww;
		if (ww.error == null)
        {
            Debug.Log("WWW Ok!: " + ww.text);
				myCoords = ww.text; // on success gets all data as a comma delimiated string
				ParseData(); //this function will parse the string into readable and useable data
        } else {
            Debug.Log("WWW Error: "+ ww.error);
        } 
	}
	
	//these if blocks are just lerping the cube to various 2d views depending on which button was selected.
	void Update ()
	{
		if (gc) {
			parent.localRotation = Quaternion.Euler (0, 0, 0);
			parent.localRotation = Quaternion.Euler (-90, 0, 0);
			parent.localScale = Vector3.Slerp (parent.transform.localScale, new Vector3 (defScaleX, 0.1f, defScaleZ), Time.deltaTime);
			if (parent.localScale.y < 0.3f) {
				//Debug.Log ("stopped");
				gc = false;	
			}
		}
		if (rg) {
			parent.localRotation = Quaternion.Euler (0, 0, 0);
			parent.localScale = Vector3.Slerp (parent.transform.localScale, new Vector3 (defScaleX, defScaleY, 0.1f), Time.deltaTime);
			if (parent.localScale.z < 0.3f) {
				//Debug.Log ("stopped");
				rg = false;	
			}
		}
		if (cr) {
			parent.localRotation = Quaternion.Euler (0, 0, 0);
			parent.localRotation = Quaternion.Euler (0, 90, 0);
			parent.localScale = Vector3.Slerp (parent.transform.localScale, new Vector3 (0.1f, defScaleY, defScaleZ), Time.deltaTime);
			if (parent.localScale.x < 0.3f) {
				//Debug.Log ("stopped");
				cr = false;	
			}
		}
		if (default3D) {
			parent.localRotation = Quaternion.Euler (0, 0, 0);
			parent.localScale = Vector3.Slerp (parent.transform.localScale, new Vector3 (defScaleX, defScaleY, defScaleZ), Time.deltaTime);
			//parent.localScale = new Vector3 (defScaleX, defScaleY, defScaleZ);
			if (parent.localScale.x > (defScaleX-0.2f) && parent.localScale.y > (defScaleY-0.2f) && parent.localScale.z > (defScaleZ-0.2f)) {
				default3D = false;
			}
		}
	}
	
	//used to determine which 2d value the cube will lerp to.
	public static void SetVals (string myString)
	{
		switch (myString) {
		case "gc":
			gc = true;
			break;
		case "rg":
			rg = true;
			break;
		case "cr":
			cr = true;
			break;
		case "default":
			default3D = true;
			break;
		case "inClass":
			inClass = true;
			break;
		default:
			Debug.Log ("could not set values, invalid string");
			break;
		}
	}
	
	//used when changing 2d views so that it has nothing else selected when it changes.
	public static void UnsetVals ()
	{
		gc = false;
		rg = false;
		cr = false;
		default3D = false;
	}
	
	//clones the sphere that is in the cube prefab and places them at the locations determined by the data recieved from the database
	private void createClones ()
	{
		int numClones = classX.Length;
		Transform clone2;
		
		for (int i = 0; i<numClones; i++) {
			//if all of these conditions are met (tolerance for determining which sphere is the current users) then generate a sphere and add a glow to it
			if(((Mathf.FloorToInt(classX[i] * 10000)+50) == (Mathf.FloorToInt(yourX * 10000)+50) ||
				(Mathf.FloorToInt(classX[i] * 10000)+50) == (Mathf.FloorToInt(yourX * 10000)+50)+1 ||
				(Mathf.FloorToInt(classX[i] * 10000)+50) == (Mathf.FloorToInt(yourX * 10000)+50)-1) && 
				((Mathf.FloorToInt(classY[i] * 10000)+50) == (Mathf.FloorToInt(yourY * 10000)+50) ||
				(Mathf.FloorToInt(classY[i] * 10000)+50) == (Mathf.FloorToInt(yourY * 10000)+50)+1 ||
				(Mathf.FloorToInt(classY[i] * 10000)+50) == (Mathf.FloorToInt(yourY * 10000)+50)-1) && 
				((Mathf.FloorToInt(classZ[i] * 10000)+50) == (Mathf.FloorToInt(yourZ * 10000)+50) ||
				(Mathf.FloorToInt(classZ[i] * 10000)+50) == (Mathf.FloorToInt(yourZ * 10000)+50)-1 ||
				(Mathf.FloorToInt(classZ[i] * 10000)+50) == (Mathf.FloorToInt(yourZ * 10000)+50)+1)){
				clone2 = Instantiate (cubey, transform.localPosition, transform.localRotation) as Transform; //creates a new sphere at the same spot as the original
				clone2.transform.parent = parent; //attaches the new clone to our cube as a child
				clone2.transform.localScale = new Vector3 (0.0009402661f, 0.0009983093f, 0.00101478f); //makes sure the scale is correct
				clone2.transform.localPosition = new Vector3 (classX [i], classY [i], classZ [i]);	//changes the clone to the next position in the array
				clone2.active = true; //show the clones but not the original
				(clone2.GetComponent("Halo") as Behaviour).enabled = true; //access the halo component and activate it creating the glow
				
			}else{
				clone = Instantiate (cubey, transform.localPosition, transform.localRotation) as Transform; //creates a new sphere at the same spot as the original
				clone.transform.parent = parent; //attaches the new clone to our cube as a child
				clone.transform.localScale = new Vector3 (0.0009402661f, 0.0009983093f, 0.00101478f); //makes sure the scale is correct
				clone.transform.localPosition = new Vector3 (classX [i], classY [i], classZ [i]);	//changes the clone to the next position in the array
				clone.active = true; //show the clones but not the original
			}
		}
	}
	
	
	//Recieves data from the parser, will recieve data from a database instead sent from same script
	#region getting the values from the xml parser
	/// <summary>
	/// Gets the data.
	/// calls a php script which will access the database to pull all data for x, y, and z for the current term
	/// </summary>
	public void getData(){
		URL = "http://oregonstate.edu/instruct/dce/fw340/cube/fetchdata.php";
		StartCoroutine(Connect());
	}
	
	//creating the set of data on the class view, counts number of participants as iterations through the for loop then prints the data in a values that humans can understand
	//otherwise data is in the scaled down version that the cube uses.  Uses a scrollpane incase the data is larger than the window.
	public void OnGUI(){
		int offset = 20;
		if(inClass == true){
			GUI.color = Color.black;
			scrollPosition = GUI.BeginScrollView(new Rect(Screen.width/2+20, Screen.height/2-Screen.height/3+10, 275, 200), scrollPosition, new Rect(0, 0, 220, classX.Length*20+20));
	        GUI.Label (new Rect(0,0,300,20)," Participant\tGender(x)  Race(y)\t   Class(z)\t\t");
			for(int i = 0;i<classX.Length;i++){
				GUI.Label (new Rect(0,offset,300,20),"\t\t"+(i+1).ToString()+"\t\t\t\t"+(Mathf.FloorToInt(classX[i] * 10000)+50).ToString()+"\t\t\t\t"+(Mathf.FloorToInt(classY[i] * 10000)+50).ToString()+"\t\t\t\t"+(Mathf.FloorToInt(classZ[i] * 10000)+50).ToString()+"\t");
				offset+= 20;
			}
		}
		
		
				
		
	}
	
	//changes the data that is recieved from the database into numbers that the cube can use to place a sphere inside itself. Scales the 
	// numbers down to the proper size.
	public void ParseData(){
		
		int index = 0;
		int start = 0;
		
		xs = new string[myCoords.Length/3]; //array of all the x coords
		ys = new string[myCoords.Length/3]; //array of all the y coords
		zs = new string[myCoords.Length/3]; //array of all the z coords
		
		for(int i = 0; i < myCoords.Length; i++){ //this for loop sorts each number into the proper array
			if(myCoords.Substring(i,1) == "'"){
				xs[index] = myCoords.Substring(start,i-start);
				start = i+1;
			}
			if(myCoords.Substring(i,1) == ","){
				ys[index] = myCoords.Substring(start,i-start);
				start = i+1;
			}
			if(myCoords.Substring(i,1) == "*"){
				zs[index] = myCoords.Substring(start,i-start);
				start = i+1;
				index++;
			}
		}
		//create new arrays for x, y, and z but this time make them floats
		classX = new float[index];
		classY = new float[index];
		classZ = new float[index];
		
		if(xs.Length == 0 ){ //special case if there is no class data
			classX = new float[1];
			classY = new float[1];
			classZ = new float[1];
		}
		for (int i = 0; i<classX.Length; i++) { //this for loop will convert the string arrays into floats so the program can use the raw data
			float.TryParse (xs[i], out classX[i]);
			float.TryParse (ys[i], out classY[i]);
			float.TryParse (zs[i], out classZ[i]);
		}
		for(int a = 0; a < classX.Length; a++){ //this for loop will convert the solid numbers back into the approproate scaled down floating point numbers so that the spheres appear in the proper places
			classX[a] = (classX[a]-50) / 10000;
			classY[a] = (classY[a]-50) / 10000;
			classZ[a] = (classZ[a]-50) / 10000;
		}
		createClones();
	}
	#endregion
}
