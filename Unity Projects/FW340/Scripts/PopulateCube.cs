using UnityEngine;
using System.Collections;

public class PopulateCube : MonoBehaviour
{
	public GameObject cubey;
	public static float newX;
	public static float newY;
	public static float newZ;
	
	//This function grabs coords for x,y,z based off slider values and lets the other functions use them - I could skip this and update directly on slider move
	static public void createPopulate (float newx, float newy, float newz)
	{
		newX = newx;
		newY = newy;
		newZ = newz;
	}

	void Update ()
	{
		createObject ();
	}
	
	//updates the sphere position for users sphere
	void createObject ()
	{
		cubey.transform.localPosition = new Vector3 (newX, newY, newZ);
	}
	
}
