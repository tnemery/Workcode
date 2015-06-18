/*
	This script is used for turning the coarse and fine focusing knob ( they are attached together in the prefab... hopefully this is changed later)
*/
using UnityEngine;
using System.Collections;

public class turnMechStageKnob : MonoBehaviour {
	private GameObject turner;
	private GameObject turner2;
	private GameObject MechStage;
	private float objectY;
	public static float storeY = 0;
	private int count = 0;
	private Color defaultColor;
	private int mouseMode = 3;
	// Use this for initialization
	void Start () {
		turner = GameObject.FindGameObjectWithTag("StageAdjust1");
		turner2 = GameObject.FindGameObjectWithTag("StageAdjust2");
		MechStage = GameObject.FindGameObjectWithTag("MechStage");
		defaultColor = turner.renderer.material.color;
		MechStage.transform.position = new Vector3(joyPad.inOut, joyPad.upDown+storeY, joyPad.leftRight);
	}
	
	// Update is called once per frame
	void Update () {
		objectY = guiGame.Scope.transform.eulerAngles.y;
		if(mouseMode == 0){
			if(storeY < 0){
				count+=1;
				storeY += .001f;
				turner.transform.rotation =  Quaternion.Euler(0,count,0); //        .Euler(0, 0, ); -- turns the knob counterclockwise when left mouse button is clicked
				turner2.transform.rotation =  Quaternion.Euler(0,count,0);
				turner.renderer.material.color = Color.blue;
				turner2.renderer.material.color = Color.blue;
			//transform.position = new Vector3 (transform.position.x, 0, transform.position.z);
				MechStage.transform.position = new Vector3(joyPad.inOut, joyPad.upDown+storeY, joyPad.leftRight);
			}
		}
		else if(mouseMode == 1){
			if(storeY > -.33f){
				count-=1;
				storeY -= .001f;
				turner.transform.rotation =  Quaternion.Euler(0,count,0); //        .Euler(0, 0, ); -- turns the knob clockwise when the right mouse button is clicked
				turner2.transform.rotation =  Quaternion.Euler(0,count,0);
				turner.renderer.material.color = Color.cyan;
				turner2.renderer.material.color = Color.cyan;
				MechStage.transform.position = new Vector3(joyPad.inOut, joyPad.upDown+storeY, joyPad.leftRight);
			}
			if(Input.GetMouseButtonUp(1)){
				OnMouseUp();	
			}
		} 
		
	}
	
	void OnMouseExit () {
		turner.renderer.material.color = defaultColor;
		turner2.renderer.material.color = defaultColor;
		mouseMode = 3;
	}
	
	void OnMouseUp () {
		turner.renderer.material.color = defaultColor;
		turner2.renderer.material.color = defaultColor;
		mouseMode = 3;
	}
	
	 void OnMouseOver () {
		
		if (Input.GetMouseButtonDown(0)){
			mouseMode = 0;
		}
		if (Input.GetMouseButtonDown(1)){
			mouseMode = 1;	
			//OnMouseDrag ();
		}
		
	}
	
}
