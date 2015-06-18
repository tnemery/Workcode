using UnityEngine;
using System.Collections;

public class PowerSwitch : MonoBehaviour {
	public Light lampLight;
	public Light lampLight2;
	
	// Use this for initialization
	void Start () {
		//lampLight = Light.GetComponent("LampLight"); //GameObject.FindGameObjectWithTag("LampLight");
		lampLight.enabled = false;
		lampLight2.enabled = false;
		
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnMouseDown(){
		lampLight.enabled = !lampLight.enabled;
		lampLight2.enabled = !lampLight2.enabled;
	}
	
	
}
