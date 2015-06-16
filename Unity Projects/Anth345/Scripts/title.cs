using UnityEngine;
using System.Collections;

public class title : MonoBehaviour {
	public Texture2D myTitle;
	
	void OnGUI(){
		GUI.DrawTexture(new Rect(0,0,Screen.width,Screen.height),myTitle, ScaleMode.StretchToFill);
		if(Input.GetKeyDown(KeyCode.A)){
			Application.LoadLevel ("IMAKER");	
		}
	}
	
	
}

