using UnityEngine;
using System.Collections;

public class gameStart : MonoBehaviour {
	private int sec;
	private float timecount;
	private float starttime;
	public Texture2D yellow1Texture;
	public Texture2D redTexture;
	public Texture2D yellow2Texture;
	public static bool begin = false;
	public bool reallyGo = false;
	public bool initTime = true;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(gameWelcome.letsGo == true){
			if(initTime){
				starttime = Time.time;
				initTime = false;
				reallyGo = true;
			}
			timecount = Time.time - starttime;
			sec = 59-(int)(timecount % 60f);
		}
	}
	
	void OnGUI () {
		GUI.depth = 1; // sets the level at which the GUI elements will be displayed
		if(reallyGo == true){
			if (sec == 59) {
			    GUI.Label(new Rect(Screen.width/2-100,Screen.height/2-100,200,200),redTexture);
			}
			if (sec == 58) {
			    GUI.Label(new Rect(Screen.width/2-100,Screen.height/2-100,200,200),yellow1Texture);
			}
			if (sec == 57) {
			    GUI.Label(new Rect(Screen.width/2-100,Screen.height/2-100,200,200),yellow2Texture);
			}
			if (sec == 56) {
				begin = true;
				reallyGo = false; //prevent numbers from displaying if user goes over the 1min mark
			}
		}
	}
}
