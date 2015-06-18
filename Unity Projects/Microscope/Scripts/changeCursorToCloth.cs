using UnityEngine;
using System.Collections;

public class changeCursorToCloth : MonoBehaviour {
	public Texture2D cursorTexture;
    public CursorMode cursorMode = CursorMode.Auto;
    public Vector3 hotSpot; // = Vector2.zero;
	public GameObject changeMe;
	public static bool changeToMover = false;

	// Use this for initialization
	void Start () {

	}
	
	// Update is called once per frame
	void Update () {
		if(changeToMover == true){
			hotSpot.x = 40-Input.mousePosition.x/Screen.width; //40 = half pixel width of image, this method will centor the cursor image on the mouse
			hotSpot.y = 40-Input.mousePosition.y/Screen.height;
			Cursor.SetCursor(cursorTexture, hotSpot, cursorMode);
			changeMe.SetActive(false);
		}else{
			changeMe.SetActive(true);
			Cursor.SetCursor (null, Vector2.zero, cursorMode); //default cursor	
		}
	
	}
	void OnMouseDown(){
		if(cursorChange.changeToMover == false){
			changeToMover = !changeToMover; //switch states on mousedown always
		}
	}
	
}
