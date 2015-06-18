using UnityEngine;
using System.Collections;

public class stageAdjustFocus : MonoBehaviour {
	public GameObject glowObject;
	public GameObject glowObject2;
	public Color glowColor = Color.green;
	public Color defaultColor;
	// Use this for initialization
	void Start () {
		glowObject = GameObject.FindGameObjectWithTag("StageAdjust1");
		glowObject2 = GameObject.FindGameObjectWithTag("StageAdjust2");
		defaultColor = glowObject.renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnMouseExit(){
		if(textPopups.introComplete == true){
			glowObject.renderer.material.color = defaultColor;
			glowObject2.renderer.material.color = defaultColor;
		}
	}
	
	void OnMouseDown(){
		if(textPopups.introComplete == true && glowObject.renderer.material.color != glowColor){
			glowColor.r = 160;
			glowColor.a = .3f;
			glowObject.renderer.material.color = glowColor;
			glowObject2.renderer.material.color = glowColor;
		}
	}
	
	
	void OnGUI() {
		if(textPopups.introComplete == true){
			if(glowObject.renderer.material.color == glowColor){
				GUI.Box (new Rect(64,0,250,80), "Stage Adjustment Knobs");
			}
		}
	}
	
}
