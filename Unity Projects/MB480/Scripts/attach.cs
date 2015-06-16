using UnityEngine;
using System.Collections;

public class attach : MonoBehaviour {

	private bool attached = false;
	private GameObject cardp;
	public GameGUI score;
	public GameObject[] getattscripts;
	public attach thisTent;
	public spawnParticles myPart;
	[HideInInspector]
	public bool checkhit = false;

	void Awake(){
		myPart = GameObject.FindGameObjectWithTag("GUI").GetComponent<spawnParticles>();
		score = GameObject.FindGameObjectWithTag("GUI").GetComponent<GameGUI>();
		getattscripts = GameObject.FindGameObjectsWithTag("tent");
		//Debug.Log ("length: " + getattscripts.Length);
	}
	
	// Update is called once per frame
	void Update () {
		if (attached == true) {
			cardp.transform.position = transform.position;
		}
		myPart.stoppart();
	}



	void OnTriggerEnter(Collider other) {
		cardp = other.gameObject;
		if(cardp.name.Substring (0,3) == this.name.Substring (0,3)){
			attached = true;
			cardp.collider.enabled = false;
			this.collider.enabled = false;
			int temp = int.Parse(score.myScore);
			temp = temp+1;
			score.myScore = temp.ToString();
			myPart.playpart(this.transform.position, 0);
			score.count++;
			for(int i = 0;i<getattscripts.Length;i++){
				thisTent = getattscripts[i].GetComponent<attach>();
				thisTent.checkhit = false;
			}
			//getattscripts.checkhit = false;
		}else if(checkhit == false){
			int temp = int.Parse(score.myScore);
			temp = temp-1;
			score.myScore = temp.ToString();
			checkhit = true;
			myPart.playpart(this.transform.position, 1);
		}
	}

}
