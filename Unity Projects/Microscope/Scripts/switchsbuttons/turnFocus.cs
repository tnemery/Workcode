/*
	This script is used for turning the coarse and fine focusing knob ( they are attached together in the prefab... hopefully this is changed later)
*/
using UnityEngine;
using System.Collections;

public class turnFocus : MonoBehaviour {
	public GameObject wee;
	private float objectY;
	public static int count = 0;
	private Color defaultColor;
	private int mouseMode = 3;
	// Use this for initialization
	void Start () {
		wee = GameObject.FindGameObjectWithTag("FineFocus");
		defaultColor = wee.renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () {
		objectY = guiGame.Scope.transform.eulerAngles.y;
		if(mouseMode == 0){
			count+=1;
			wee.transform.rotation =  Quaternion.Euler(count,objectY,270); //        .Euler(0, 0, ); -- turns the knob counterclockwise when left mouse button is clicked
			wee.renderer.material.color = Color.blue;
		}
		else if(mouseMode == 1){
			count-=1;
			wee.transform.rotation =  Quaternion.Euler(count,objectY,270); //        .Euler(0, 0, ); -- turns the knob clockwise when the right mouse button is clicked
			wee.renderer.material.color = Color.cyan;
			if(Input.GetMouseButtonUp(1)){
				OnMouseUp();	
			}
		}
		
	}
	
	void OnMouseExit () {
		wee.renderer.material.color = defaultColor;
		mouseMode = 3;
	}
	
	void OnMouseUp () {
		wee.renderer.material.color = defaultColor;
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
