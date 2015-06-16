using UnityEngine;
using System.Collections;

public class bulletSpawn : MonoBehaviour {
	public Transform bulletPrefab;
	private Transform bulletref;
	private NetworkViewID bulletID;


	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown ("space")){
			bulletref = (Transform)Network.Instantiate(bulletPrefab,transform.position,transform.rotation,0);
		}


	}

}
