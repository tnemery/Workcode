using UnityEngine;
using System.Collections;

public class GUIGoBack : MonoBehaviour {
	public float off = 0;
	public GUISkin customGuiStyle;
	// Use this for initialization
	void Start () {
	
	}
	
	void OnGUI (){
		GUI.skin = customGuiStyle;
		off += (Time.deltaTime*100);
	
		GUI.Box (new Rect(0,-3400 + off,Screen.width, 5000), "<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n <color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n<color=yellow>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.\n");	
				
		
		
		
		if(GUI.Button (new Rect(Screen.width/2-125,Screen.height/2-40,250,80), "Go Back")){
			Application.LoadLevel ("mainmenu");	
		}
		
	}
	
	
	// Update is called once per frame
	void Update () {
	
	}
}
