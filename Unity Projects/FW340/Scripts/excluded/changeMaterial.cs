using UnityEngine;
using System.Collections;

public class changeMaterial : MonoBehaviour {
	
	//public Material mat1;
	//public Material mat2;
	public GameObject obj1;
	public GameObject obj2;
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKey(KeyCode.A)){
			//this.renderer.material = mat1;
			obj1.SetActive(true);
			obj2.SetActive(false);
		}else{
			//this.renderer.material = mat2;
			obj1.SetActive(false);
			obj2.SetActive(true);
		}
		
		
	}
}
