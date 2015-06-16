using UnityEngine;
using System.Collections;

public class Randomizer : MonoBehaviour {
	static private float[] myY,myX;
	private float countx = 0.7f;
	private float county = 0.53f;
	private int check1,check2;
	private bool clear = false;

	// Use this for initialization
	void Awake(){
		myY = new float[18]; // Random.Range (5,14);
		myX = new float[18];
		for(int i = 0; i<18;i++){
			myY[i] = 5+(county*i);
			myX[i] = -10+(countx*i); //= Random.Range (-10,2);
		}
	}

	void Start () {
		check1 = Random.Range (0,18);
		check2 = Random.Range (0,18);
		clear = false;
		do{
			if(myX[check1] != -50 && myY[check2] != -50){
				this.transform.position = new Vector3(myX[check1], myY[check2], this.transform.position.z);
				myX[check1] = -50;
				myY[check2] = -50;
				clear = true;
			}else{
				check1 = Random.Range (0,18);
				check2 = Random.Range (0,18);
			}
		}while(clear == false);
	}

}
