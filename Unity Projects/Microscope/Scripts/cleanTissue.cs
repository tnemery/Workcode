using UnityEngine;
using System.Collections;

public class cleanTissue : MonoBehaviour {
	public GameObject master;
	// Use this for initialization
	void Start () {
		master.SendMessage("openTissueBox");
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	
}
