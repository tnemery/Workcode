using UnityEngine;
using System.Collections;

public class fineFocus : MonoBehaviour {
	public GameObject glowObject;
	public Color glowColor = Color.green;
	public Color defaultColor;
	// Use this for initialization
	void Start () {
		glowObject = GameObject.FindGameObjectWithTag("FineFocus");
		defaultColor = glowObject.renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnMouseExit(){
		if(textPopups.introComplete == true){
			glowObject.renderer.material.color = defaultColor;
		}
	}
	
	void OnMouseDown(){
		if(textPopups.introComplete == true && glowObject.renderer.material.color != glowColor){
			glowColor.r = 160;
			glowColor.a = .3f;
			glowObject.renderer.material.color = glowColor;
		}
	}
	
	
	void OnGUI() {
		if(textPopups.introComplete == true){
			if(glowObject.renderer.material.color == glowColor){
				GUI.Box (new Rect(64,0,250,80), "Fine/Coarse Focus");
			}
		}
	}
	
}
