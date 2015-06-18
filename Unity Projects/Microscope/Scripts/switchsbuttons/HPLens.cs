/*
	This script is used for turning the coarse and fine focusing knob ( they are attached together in the prefab... hopefully this is changed later)
*/
using UnityEngine;
using System.Collections;

public class HPLens : MonoBehaviour {
	private GameObject turner;
	private GameObject lens;
	//private int count = 0;
	private Color defaultColor;
	//private int mouseMode = 3;
	// Use this for initialization
	void Start () {
		turner = GameObject.FindGameObjectWithTag("NosePiece");
		lens = GameObject.FindGameObjectWithTag("HPLens");
		defaultColor = lens.renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnMouseExit () {
		lens.renderer.material.color = defaultColor;
		//mouseMode = 3;
	}
	
	void OnMouseUp () {
		lens.renderer.material.color = defaultColor;
		//mouseMode = 3;
	}
	
	 void OnMouseOver () {
		
	}
	
	void OnMouseDown() {
		Debug.Log("HPLens");
		lens.renderer.material.color = Color.blue;
	}
	
}
