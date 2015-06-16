using UnityEngine;
using System.Collections;

public class GameGUI : MonoBehaviour {
	[HideInInspector]
	public string myScore = "0";
	public GUISkin mySkin;
	private GameObject myGui;
	public attach checkCount;
	public GameObject[] getattscripts;
	public int count = 0;
	private int myTime;
	private bool getOnce = false;

	void Awake(){
		myGui = GameObject.Find ("__GUI");
		getattscripts = GameObject.FindGameObjectsWithTag("tent");
		checkCount = getattscripts[0].GetComponent<attach>();
	}

	void OnGUI() {
		GUI.skin = mySkin;
		GUI.Box(new Rect(Screen.width-176,Screen.height-41,175,40),"<size=25>Score:     "+"<color=yellow>"+myScore+"</color></size>");
		GUI.depth = 0;
		if(GUI.Button(new Rect(Screen.width-76,0,75,20),"Reset")){
			Destroy (myGui);
			Application.LoadLevel("mb480scene1");
		}
		if(count == 18){
			if(getOnce == false){
				myTime = Mathf.FloorToInt(Time.time);
				getOnce = true;
			}
			if((myTime+2)<Time.time){
				GUI.Box(new Rect(Screen.width/2-((Screen.width/2)/2),Screen.height/2-((Screen.height/2)/2),Screen.width/2,Screen.height/2),"<size=30>Congratulations!!!</size> \n<size=20>You matched the lifecycles, You completed with a score of <color=yellow>"+myScore+"</color>. \nWould you like to play again?</size>");
				if(GUI.Button(new Rect(Screen.width/2-76,Screen.height/2-10,75,20),"Yes")){
					Destroy (myGui);
					Application.LoadLevel("mb480scene1");
				}
				if(GUI.Button(new Rect(Screen.width/2,Screen.height/2-10,75,20),"Main")){
					Destroy (myGui);
					Application.LoadLevel("Main");
				}
			}
		}
	}

}
