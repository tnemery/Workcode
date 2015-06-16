using UnityEngine;
using System.Collections;

[RequireComponent(typeof(BoxCollider))]
public class drag : MonoBehaviour {

	private Vector3 screenPoint;
	private Vector3 offset;
	private GameObject sphereC;
	private float myY,myX;
		
	void OnMouseDown()
	{
		screenPoint = Camera.main.WorldToScreenPoint(gameObject.transform.position);
		
		offset = gameObject.transform.position - Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, screenPoint.z));
		
	}
	
	void OnMouseDrag()
	{
		Vector3 curScreenPoint = new Vector3(Input.mousePosition.x, Input.mousePosition.y, screenPoint.z);
		
		Vector3 curPosition = Camera.main.ScreenToWorldPoint(curScreenPoint), offset;
		transform.position = curPosition;
		
	}

	void OnTriggerEnter(Collider other) {
		sphereC = other.gameObject;
		if(sphereC.tag == "Sphere"){
			myY = Random.Range (5,14);
			myX = Random.Range (-11,2);
			this.transform.position = new Vector3(myX, myY, this.transform.position.z);
		}

	}
		

}
