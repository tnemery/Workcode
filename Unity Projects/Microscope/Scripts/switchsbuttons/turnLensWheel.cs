/*
	This script is used for turning the coarse and fine focusing knob ( they are attached together in the prefab... hopefully this is changed later)
*/
using UnityEngine;
using System.Collections;

public class turnLensWheel : MonoBehaviour {
	private GameObject turner;
	public float count = 0f;
	private Color defaultColor;
	private int mouseMode = 3;
	private bool upX = true;
	private bool upZ = false;
	private float moveX = 330.468f;
	private float moveZ = 359.4162f;
	// Use this for initialization
	void Start () {
		turner = GameObject.FindGameObjectWithTag("NosePiece");
		defaultColor = turner.renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () {
		if(mouseMode == 0){
			//count+=.01f;
			turner.transform.RotateAround(turner.collider.bounds.center, turner.transform.up, count);
			turner.renderer.material.color = Color.blue;
		}
		else if(mouseMode == 1){
			//count-=.01f;
			turner.transform.RotateAround(turner.collider.bounds.center, turner.transform.up, count);
			turner.renderer.material.color = Color.cyan;
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
			count = 2;
		}
		if (Input.GetMouseButtonDown(1)){
			mouseMode = 1;
			count = -2;
		}
	}
	
	
	void OnMouseDrag(){
		
    	
		
	}
	
	
}
