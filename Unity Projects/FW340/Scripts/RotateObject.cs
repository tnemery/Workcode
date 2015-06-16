using UnityEngine;
using System.Collections;

public class RotateObject : MonoBehaviour
{
	public GameObject myThing;
	private int go = 1;
	private Vector3 rotation = new Vector3(360f,1.2f,120f);
	void Update ()
	{
		go++;
	    myThing.transform.localRotation =  Quaternion.Lerp(Quaternion.identity,Quaternion.Euler(rotation),go);
	}
}
