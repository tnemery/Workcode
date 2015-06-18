/*
	This script is used for turning the coarse and fine focusing knob ( they are attached together in the prefab... hopefully this is changed later)
*/
using UnityEngine;
using System.Collections;

public class turnIntensity : MonoBehaviour {
	private GameObject turner;
	//public GameObject Scope;
	private int count = 0;
	private float objectY;
	private Color defaultColor;
	private int mouseMode = 3;
	public Light lampLight;
	public Light lampLight2;
	// Use this for initialization
	void Start () {
		turner = GameObject.FindGameObjectWithTag("OnOff");
		defaultColor = turner.renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () {
		//objectY = guiGame.Scope.transform.eulerAngles.y;
		if(mouseMode == 0){
			count+=1;
			turner.transform.localRotation =  Quaternion.Euler(count,270,270); //        .Euler(0, 0, ); -- turns the knob counterclockwise when left mouse button is clicked
			turner.renderer.material.color = Color.blue;
			if(lampLight.intensity < 4){
				lampLight.intensity += .01f;
				lampLight2.intensity += .01f;
			}
		}
		else if(mouseMode == 1){
			count-=1;
			turner.transform.localRotation =  Quaternion.Euler(count,270,270); //        .Euler(0, 0, ); -- turns the knob clockwise when the right mouse button is clicked
			turner.renderer.material.color = Color.cyan;
			if(lampLight.intensity > 1){
				lampLight.intensity -= .01f;
				lampLight2.intensity -= .01f;
			}
			if(Input.GetMouseButtonUp(1)){
				OnMouseUp();	
			}
		}
	}
	
	void OnMouseExit () {
		turner.renderer.material.color = defaultColor;
		mouseMode = 3;
	}
	
	void OnMouseUp () {
		turner.renderer.material.color = defaultColor;
		mouseMode = 3;
	}
	
	 void OnMouseOver () {
		
		if (Input.GetMouseButtonDown(0)){
			mouseMode = 0;
		}
		if (Input.GetMouseButtonDown(1)){
			mouseMode = 1;	
		}
	}
}
