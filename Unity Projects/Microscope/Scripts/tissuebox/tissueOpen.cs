using UnityEngine;
using System.Collections;

public class tissueOpen : MonoBehaviour {
	private GameObject tissueBox;
	private bool openBox = false;
	private bool closeBox = false;
	private float speed = 0.4f;
	private float startTime;
	
	void Start () {
		tissueBox = GameObject.Find ("boxTop");
		Debug.Log (tissueBox.name);
	}
	// Update is called once per frame
	void Update () {
		if(openBox){
			tissueBox.transform.localRotation =  Quaternion.Lerp (Quaternion.Euler (0,0,0), Quaternion.Euler (180,0,0), (Time.time-startTime)* speed);
		}else if(closeBox){ // 
			tissueBox.transform.localRotation =  Quaternion.Lerp (Quaternion.Euler (180,0,0), Quaternion.Euler (0,0,0), (Time.time-startTime) *speed);
		}
	}
	
	void openTissueBox(){
		startTime = Time.time;
		openBox = true;
		closeBox = false;
	}
	
	void closeTissueBox(){
		startTime = Time.time;
		openBox =false;
		closeBox = true;
	}
}
