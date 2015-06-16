/// <summary>
/// Solo view.
/// just sets the values of your cube to use for later
/// </summary>

using UnityEngine;
using System.Collections;

public class SoloView  : ClassView
{
	static public void setPlayerStats (float gender, float race, float Class)
	{
		PlayerPrefs.DeleteAll ();
		
		//GameObject ns = GameObject.Find("__Network");
		//ns.GetComponent<networkAssist>().recieveNums(gender, race, Class); //calls a function without the use of static protection
		ClassView.yourX = gender;
		ClassView.yourY = race;
		ClassView.yourZ = Class;
	}
}
