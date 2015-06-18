using UnityEngine;
using System.Collections;

public class cursorChange : MonoBehaviour {
	public Texture2D grabbyHandTexture;
	public Texture2D towelTexture;
    public CursorMode cursorMode = CursorMode.Auto;
    public Vector3 hotSpot; // = Vector2.zero;
	public GameObject selectedTool;
	private GameObject[] refObjects = new GameObject[10];
	public static bool Micro = false;
	public static bool changeToMover = false;
	public float deg = 0F;
	
	public string check;
	// Use this for initialization
	void Start () {
		refObjects[0] = GameObject.FindGameObjectWithTag("handTool");
		refObjects[1] = GameObject.FindGameObjectWithTag("cloth");
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void LoadActiveTool(string toolname){
		
		switch(toolname){
		case ("handTool") : Micro = true;
						SetActiveCursorPosition(grabbyHandTexture.height/2,grabbyHandTexture.width/2);
						Cursor.SetCursor(grabbyHandTexture, hotSpot, cursorMode);
						refObjects[1].SetActive(false);
						break;
		case ("cloth") : 
						SetActiveCursorPosition(towelTexture.height/2,towelTexture.width/2);
						Cursor.SetCursor(towelTexture, hotSpot, cursorMode);
						refObjects[0].SetActive(false);
						break;
		default :
			Debug.Log ("something went wrong");
			break;
		}
		
	}
	
	void LoadAllTools(){
		Micro = false;
		Cursor.SetCursor (null, Vector2.zero, cursorMode); //default cursor	
		refObjects[0].SetActive(true);
		refObjects[1].SetActive(true);
	}
	
	void SetActiveCursorPosition(float textWidth, float textHeight){
		hotSpot.x = textWidth-Input.mousePosition.x/Screen.width;
		hotSpot.y = textHeight-Input.mousePosition.y/Screen.height;
	}
	
	void OnMouseDown(){
		changeToMover = !changeToMover; //switch states on mousedown always
		if(changeToMover == false){
			LoadAllTools();
		}else{
			LoadActiveTool(selectedTool.tag);
		}
	}
	
}



/*
 * send game master object name that should be the active tool
 * game master turns off other tools
 * cursorchange then checks the name and applys the correct cursor
 * 
 * 
 */