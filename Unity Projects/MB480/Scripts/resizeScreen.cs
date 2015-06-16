using UnityEngine;
using System.Collections;

public delegate void OnScreenSizeChange(Vector2 newScreenSize);

public class resizeScreen : MonoBehaviour {
	public float lastScreenWidth = 0f;
	void Awake(){
		lastScreenWidth = Screen.width;
	}

	void Update(){
		if( lastScreenWidth != Screen.width ){
			
			lastScreenWidth = Screen.width;
			
			StartCoroutine("AdjustScale");
			
		}
	}

	IEnumerator AdjustScale(){
		print ("rawr");
		Screen.SetResolution(Screen.width,Screen.height,false);
		yield return new WaitForSeconds(2);
		// set up the other scene params.
		
	}
}
