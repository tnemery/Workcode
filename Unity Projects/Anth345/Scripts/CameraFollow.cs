using UnityEngine;
using System.Collections;

public class CameraFollow : MonoBehaviour {
	public GameObject IME;
	public Camera cam;
	// Use this for initialization
	void Awake () {
		cam.transform.localPosition = new Vector3(6.397734f,2.930051f,-0.03056145f);
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
