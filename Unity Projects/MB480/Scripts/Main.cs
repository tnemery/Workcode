using UnityEngine;
using System.Collections;

public class Main : MonoBehaviour {

	void OnGUI(){
		if(GUI.Button (new Rect(Screen.width/2-100,Screen.height-41,200,40), "<size=30>Start Game</size>")){
			Application.LoadLevel("mb480scene1");
		}
	}
}
