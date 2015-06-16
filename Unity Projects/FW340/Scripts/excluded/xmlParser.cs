/*The dictionary for myInput will store the values from the xml file into an array
 * The dictionary for myInput2 will grab the size of the array to use
 * obj contrains the array that myInput will point to
 * obj2 contains the array that myInput2 will point to
 * MAXDATA is a contanst that will be filled by the value in obj2
 * classX,Y,Z will store the values of x,y, and z that can be found in the obj array
 * 
 * getData will use the xmldata that can be located in the textasset and parse it into to arrays, see the function for furthur documentation
 * 
 * Int32.TryParse(string, out int) this is a system function to parse a string to an int
 * Single.TryParse(string, out float) this is a system function to parse a string to a float
 * 
 * updateDataArrays will fill our float[] arrays with the parsed xml data so that we may use it later
 * 
 * after updateDataArrays completes all data will be sent to the appropriate scripts to then clone the class objects on the scene
 */
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using System;

public class xmlParser : MonoBehaviour
{
	
	public GameObject master;
	public TextAsset GameAsset;
	List<Dictionary<string,string>> myInput = new List<Dictionary<string,string>> ();
	List<Dictionary<string,string>> myInput2 = new List<Dictionary<string,string>> ();
	Dictionary<string,string> obj;
	Dictionary<string,string> obj2;
	private int MAXDATA = 0;
	private float[] classX;
	private float[] classY;
	private float[] classZ;
	
	// Use this for initialization
	void Start ()
	{
		getData ();
		
		
		string temp = "";
		myInput2 [0].TryGetValue ("max", out temp);
		Int32.TryParse (temp, out MAXDATA); //converts a string to an integer (requires using System to work)
		//Debug.Log ("maxdata " + MAXDATA);
		updataDataArrays ();
		
		//master.SendMessage ("recieveX", classX);
		//master.SendMessage ("recieveY", classY);
		//master.SendMessage ("recieveZ", classZ);
		//master.SendMessage ("createClones");
		/* code for retrieving parses
		
		string temp = "";
		float myX = 0;
		myInput[0].TryGetValue("z",out temp);
		Single.TryParse(temp, out myX); //converts a string to a float (requires using System to work)
		Debug.Log (myX);
		*/
	}

	void updataDataArrays ()
	{
		classX = new float[MAXDATA];
		classY = new float[MAXDATA];
		classZ = new float[MAXDATA];
	
		for (int i = 0; i<MAXDATA; i++) {
			string temp = "";
			float myNum = 0;
			myInput [i].TryGetValue ("x", out temp);
			Single.TryParse (temp, out myNum);
			classX [i] = myNum;
			myInput [i].TryGetValue ("y", out temp);
			Single.TryParse (temp, out myNum);
			classY [i] = myNum;
			myInput [i].TryGetValue ("z", out temp);
			Single.TryParse (temp, out myNum);
			classZ [i] = myNum;
		}
	}
	
	void getData ()
	{
		XmlDocument xmlDoc = new XmlDocument (); // xmlDoc is the new xml document.
		xmlDoc.LoadXml (GameAsset.text); // load the file.
		XmlNodeList levelsList = xmlDoc.GetElementsByTagName ("data"); // array of the level nodes.
		XmlNodeList grabSize = xmlDoc.GetElementsByTagName ("classNode");
		
		foreach (XmlNode mySize in grabSize) {
			XmlNodeList mySizeContent = mySize.ChildNodes;
			obj2 = new Dictionary<string,string> (); // Create a object(Dictionary) to colect the both nodes inside the level node and then put into levels[] array.
  
		
			foreach (XmlNode subIndex in mySizeContent) {
				if (subIndex.Name == "size") {
					switch (subIndex.Attributes ["max"].Value) {
					case "maxSize":
						obj2.Add ("max", subIndex.InnerText);
						break; // put this in the dictionary.
					}
				}
			}
			myInput2.Add (obj2); // add whole obj dictionary in the levels[].
		}
		
		
		foreach (XmlNode levelInfo in levelsList) {
			XmlNodeList levelcontent = levelInfo.ChildNodes;
			obj = new Dictionary<string,string> (); // Create a object(Dictionary) to colect the both nodes inside the level node and then put into levels[] array.
  
		
			foreach (XmlNode levelsItens in levelcontent) {
				if (levelsItens.Name == "position") {
					switch (levelsItens.Attributes ["name"].Value) {
					case "x":
						obj.Add ("x", levelsItens.InnerText);
						break; // put this in the dictionary.
					case "y":
						obj.Add ("y", levelsItens.InnerText);
						break; // put this in the dictionary.
					case "z":
						obj.Add ("z", levelsItens.InnerText);
						break; // put this in the dictionary.
					}
				}
			}
			myInput.Add (obj); // add whole obj dictionary in the levels[].
		}
	}
		
}
