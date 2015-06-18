using UnityEngine;
using System.Collections;

public class moveMicro : MonoBehaviour {
	private GameObject micro;
	private int count = 0;
	// Use this for initialization
	void Start () {
		micro = GameObject.FindGameObjectWithTag("MicroScope");
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnMouseDrag(){
		count++;
		micro.transform.rotation = Quaternion.Euler(0,count,0);
	}
}
