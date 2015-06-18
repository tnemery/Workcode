using UnityEngine;
using System.Collections;

public class rotateObject : MonoBehaviour {

	//How quickly to rotate the object.
	public float sensitivityX = 4f;
	public float sensitivityY = 4f;
	public int moving = 0;
	public Transform mainObj;
	
	//Camera that acts as a point of view to rotate the object relative to.
	public Transform referenceCamera;
	public Transform movingObj;
	 
	//The script in Start() is executed before Update(), so we can use it to
	//doublecheck our variables have valid values before we try to run the script in Update().
	void Start() {
	 		//mainObj =  GameObject.FindGameObjectsWithTag("mover");
	        //Ensure the referenceCamera variable has a valid value before letting this script run.
	        //If the user didn't set a camera manually, try to automatically assign the scene's Main Camera.
	        if (!referenceCamera) {
	                if (!Camera.main) {
	                        Debug.LogError("No Camera with 'Main Camera' as its tag was found. Please either assign a Camera to this script, or change a Camera's tag to 'Main Camera'.");
	                        Destroy(this);
	                        return;
	                }
	                referenceCamera = Camera.main.transform;
	        }
	}
	 
	//Update() is called once every frame, and should be used to run script that
	//should be doing something constantly. In this case, we potentially want to
	//rotate the object constantly if the user is always moving the mouse.
	void Update () {
	 
	        //Get how far the mouse has moved by using the Input.GetAxis().
	        float rotationX = Input.GetAxis("Mouse X") * sensitivityX;
	        float rotationY = Input.GetAxis("Mouse Y") * sensitivityY;
	 		//Debug.Log("moving");
	        //Rotate the object around the camera's "up" axis, and the camera's "right" axis.
	       if(cursorChange.Micro == true){ //if the user has the moving hand cursor then move the micro
	        	mainObj.collider.enabled = true;
	        }else{
	        	mainObj.collider.enabled = false;
	        }
	        if(moving == 1){
	       		movingObj.transform.RotateAroundLocal( referenceCamera.up        , -Mathf.Deg2Rad * rotationX );
	       		//transform.RotateAroundLocal( referenceCamera.right      ,  Mathf.Deg2Rad * rotationY );
	       		}
	 
	}
	
	void OnMouseDown(){
		moving = 1;
	}
	
	void OnMouseUp(){
		moving = 0;
	}
}
