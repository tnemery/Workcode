using UnityEngine;
using System.Collections;

public class HpLensOnFocus : MonoBehaviour {
	public Collision collision;
	
	void OnCollisionEnter(Collision collision) {
		
		if(collision.collider.gameObject.name == "MechStage"){
			Debug.Log ("HpLens is focused on Stage");
		}
	}
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
