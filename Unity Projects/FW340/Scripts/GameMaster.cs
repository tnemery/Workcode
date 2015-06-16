using UnityEngine;
using System.Collections;

public class GameMaster : MonoBehaviour
{
	//GUI accesses these variables to determine which scenes Gui it needs to display
	static public bool defaultScene = true;
	static public bool classScene = false;
	static public bool createScene = false;
	static public bool class2DScene = false;
	
	//tells the GUI which GUI to use for the new scene
	static public void setSceneGUI (string GuiScene)
	{
		defaultScene = false;
		classScene = false;
		createScene = false;
		class2DScene = false;
	
		if (GuiScene == "default")
			defaultScene = true;
		if (GuiScene == "class")
			classScene = true;
		if (GuiScene == "create")
			createScene = true;
		if (GuiScene == "2D")
			class2DScene = true;
	}
	
	static public void SaveAxis (float myX, float myY, float myZ, bool type)
	{
		//Debug.Log ("x: "+(myX*10000)+" y: "+myY+" z: "+myZ);
		if (type == false) {
			PopulateCube.createPopulate (myX, myY, myZ);
		}
	}
	
	//called when player clicks create to check if they have a saved sphere already, if they do wont allow them to go to create
	static public bool checkPlayer ()
	{
		//call network
		
		return false; //SoloView.getPlayerStats();
	}
}
