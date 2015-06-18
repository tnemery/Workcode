/*
	This script is used for turning the coarse and fine focusing knob ( they are attached together in the prefab... hopefully this is changed later)
*/
using UnityEngine;
using System.Collections;

public class turnCondenser : MonoBehaviour {
	private GameObject turner;
	private float objectY;
	private int count = 0;
	private Color defaultColor;
	private int mouseMode = 3;
	private float speed;
	
	
	private float _sensitivity;
    private Vector3 _mouseReference;
    private Vector3 _mouseOffset;
    private Vector3 _rotation;
    private bool _isRotating;
	
	
	// Use this for initialization
	void Start () {
		turner = GameObject.FindGameObjectWithTag("Condenser");
		defaultColor = turner.renderer.material.color;
		
		_sensitivity = 0.4f;
       _rotation = Vector3.zero;
		
		
	}
	
	// Update is called once per frame
	void Update () {
		
		if(_isRotating)
       {
         // offset
         _mouseOffset = (Input.mousePosition - _mouseReference);
 
         // apply rotation
         _rotation.x = -( _mouseOffset.x) * _sensitivity;
 
         // rotate
         transform.Rotate(_rotation);
 
         // store mouse
         _mouseReference = Input.mousePosition;
       }
		
		
		
		/*
		objectY = guiGame.Scope.transform.eulerAngles.y;
		if(mouseMode == 0){
			count-=1;
			turner.renderer.material.color = Color.blue;
			turner.transform.rotation =  Quaternion.Euler(count,objectY,0); //        .Euler(0, 0, ); -- turns the knob counterclockwise when left mouse button is clicked
			
			
		}
		else if(mouseMode == 1){
			count+=1;
			turner.transform.rotation =  Quaternion.Euler(count,objectY,0); //        .Euler(0, 0, ); -- turns the knob clockwise when the right mouse button is clicked
			turner.renderer.material.color = Color.cyan;
			if(Input.GetMouseButtonUp(1)){
				OnMouseUp();	
			}
		}
		*/
	}
	
	
	 void OnMouseDown()
    {
       // rotating flag
       _isRotating = true;
 
       // store mouse
       _mouseReference = Input.mousePosition;
    }
 
	
	void OnMouseExit () {
		turner.renderer.material.color = defaultColor;
		mouseMode = 3;
	}
	
	void OnMouseUp () {
		turner.renderer.material.color = defaultColor;
		mouseMode = 3;
		
		
		// rotating flag
       _isRotating = false;
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
