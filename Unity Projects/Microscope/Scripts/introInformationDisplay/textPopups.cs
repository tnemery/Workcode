using UnityEngine;
using System.Collections;
//using Graphics;

public class textPopups : MonoBehaviour {
	public static bool introComplete = false;
	public Camera cam1;
	public Camera cam2;
	public float progCount = 0.0f;
	public bool timerRunning = true;
	private Texture2D s3;
	public GUISkin customGuiStyle;
	public GUISkin solidBox;
	private int count = 0;
	protected Animator animator;
	public GameObject glowObject;
	public Color glowColor = Color.green;
	public Color defaultColor;
	private bool dColorStop = true;

	
	//public  currentTimeInRunAnimation = animation["Run"].time;
	
	// Use this for initialization
	void Start () {
		animator = GetComponent<Animator>();
		//glowObject = GameObject.FindGameObjectWithTag("Knob");
	}
	
	// Update is called once per frame
	void Update () {
		if(timerRunning){
			progCount += Time.deltaTime; //(float)count/100; //progCount = 1 per second
		}
			//Debug.Log (progCount);
		if(animator){
			//AnimatorStateInfo stateInfo = animator.GetCurrentAnimatorStateInfo(0);
			
			//Debug.Log(stateInfo.nameHash == Animator.StringToHash("Base Layer.hello"));
			//Debug.Log(animator["hello"]);
#region every stop in the animation			
			if(progCount >= 1.33f && count == 0){
				
				timerRunning = false;
				animator.enabled = false;
				
			}
			
			if(progCount >= 2.66f && count == 1){
				
				timerRunning = false;
				animator.enabled = false;
				
				glowObject = GameObject.FindGameObjectWithTag("Head");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
			}
			
			
			if(progCount >= 4.00f && count == 2){
				glowObject = GameObject.FindGameObjectWithTag("Arm");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 5.33f && count == 3){
				
				glowObject = GameObject.FindGameObjectWithTag("FineFocus");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 6.66f && count == 4){
				
				glowObject = GameObject.FindGameObjectWithTag("FineFocus");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 8.00f && count == 5){
				
				glowObject = GameObject.FindGameObjectWithTag("OnOff");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				glowObject = GameObject.FindGameObjectWithTag("Intensity");
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 9.33f && count == 6){
				
				glowObject = GameObject.FindGameObjectWithTag("StageAdjust1");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				glowObject = GameObject.FindGameObjectWithTag("StageAdjust2");
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 10.66f && count == 7){
				
				glowObject = GameObject.FindGameObjectWithTag("Base");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 12.00f && count == 8){
				
				glowObject = GameObject.FindGameObjectWithTag("Lamp");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 13.33f && count == 9){
				
				glowObject = GameObject.FindGameObjectWithTag("Turret1");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				glowObject = GameObject.FindGameObjectWithTag("Turret2");
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 14.66f && count == 10){
				
				glowObject = GameObject.FindGameObjectWithTag("Condenser");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 16.00f && count == 11){
				
				glowObject = GameObject.FindGameObjectWithTag("MechStage");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 17.33f && count == 12){
				
				glowObject = GameObject.FindGameObjectWithTag("ScanLens");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 18.66f && count == 13){
				
				glowObject = GameObject.FindGameObjectWithTag("HPLens");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 20.00f && count == 14){
				
				glowObject = GameObject.FindGameObjectWithTag("InterLens");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
			if(progCount >= 21.33f && count == 15){
				
				glowObject = GameObject.FindGameObjectWithTag("NosePiece");
				if(dColorStop){
					defaultColor = glowObject.renderer.material.color;
					dColorStop = false;
				}
				glowColor.r = 160;
				glowColor.a = .3f;
				glowObject.renderer.material.color = glowColor;
				
				timerRunning = false;
				animator.enabled = false;
			}
#endregion
		}
		
	}
	
	void OnGUI (){
		
		if(GUI.Button (new Rect(Screen.width-260,Screen.height-90,250,80), "Return to Main Menu")){
			Application.LoadLevel("mainmenu");
		}
		
#region Drawing a line
		//not needed for the demo part
		//GUIHelper.DrawLine(new Vector2(Screen.width/2-1, 0), new Vector2(Screen.width/2-1, Screen.height), Color.black);
		//GUIHelper.DrawLine(new Vector2(Screen.width/2, 0), new Vector2(Screen.width/2, Screen.height), Color.black);
		//GUIHelper.DrawLine(new Vector2(Screen.width/2+1, 0), new Vector2(Screen.width/2+1, Screen.height), Color.black);

#endregion	
		
		
		//GUI.Box (new Rect(Screen.width-100,0,100,20), "Num: "+progCount); //create a box in the upper corner to count, updates on progCount
		
#region text comment Block
	/*
		\n for new line
		<b></b> for bold
		<i></i> for italic
		<color=green></color> to add color
		
		
		static function Box (position : Rect, text : String) : void
		static function Box (position : Rect, image : Texture) : void
		static function Box (position : Rect, content : GUIContent) : void
		static function Box (position : Rect, text : String, style : GUIStyle) : void
		static function Box (position : Rect, image : Texture, style : GUIStyle) : void
		static function Box (position : Rect, content : GUIContent, style : GUIStyle) : void
		
		
	*/	
#endregion
		
#region Popups		
		if(progCount >= 1.33f && count == 0){ //popups
			//GUI.skin = customGuiStyle;
			/*
			GUI.BeginGroup (new Rect(0,0,314,80));
				GUI.skin = solidBox;
				GUI.Box (new Rect(0,0,314,80), ""); //create a border
				GUI.skin = customGuiStyle;
				GUI.Box (new Rect(0,0,64,80), s3);
				GUI.Box (new Rect(64,0,250,80), "<color=green>testing the text in this box</color> to see what \nI can format <b>and</b> how I can <i>format</i> it.");	
				GUI.skin = null;
			GUI.EndGroup();	
			*/
			GUI.Box (new Rect(64,0,250,80), "Oculars");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				count++;
			}
		}
		if(progCount >= 2.66f && count == 1){
			GUI.Box (new Rect(64,0,250,80), "Head");	
			
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}	
		}
		if(progCount >= 4.00f && count == 2){
			GUI.Box (new Rect(64,0,250,80), "Arm");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}	
		}
		if(progCount >= 5.33f && count == 3){
			GUI.Box (new Rect(64,0,250,80), "Coarse Focus");		
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 6.66f && count == 4){
			GUI.Box (new Rect(64,0,250,80), "Fine Focus");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 8.00f && count == 5){
			GUI.Box (new Rect(64,0,250,80), "On/Off Switch and Intensity Lever");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				glowObject = GameObject.FindGameObjectWithTag("OnOff");
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 9.33f && count == 6){
			GUI.Box (new Rect(64,0,250,80), "Stage Adjustment Knobs");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				glowObject = GameObject.FindGameObjectWithTag("StageAdjust1");
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 10.66f && count == 7){
			GUI.Box (new Rect(64,0,250,80), "Base");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 12.00f && count == 8){
			GUI.Box (new Rect(64,0,250,80), "Lamp");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 13.33f && count == 9){
			GUI.Box (new Rect(64,0,250,80), "Iris Diaphragm and Phase Contrast Turret");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				glowObject = GameObject.FindGameObjectWithTag("Turret1");
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 14.66f && count == 10){
			GUI.Box (new Rect(64,0,250,80), "Condenser Adjustment Knob");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 16.00f && count == 11){
			GUI.Box (new Rect(64,0,250,80), "Mechanical Stage");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 17.33f && count == 12){
			GUI.Box (new Rect(64,0,250,80), "Scanning Lens");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 18.66f && count == 13){
			GUI.Box (new Rect(64,0,250,80), "High Power Lens");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 20.00f && count == 14){
			GUI.Box (new Rect(64,0,250,80), "Intermediate Lens");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = true;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
			}
		}
		if(progCount >= 21.33f && count == 15){
			GUI.Box (new Rect(64,0,250,80), "Revolving Nosepiece");	
			if(GUI.Button (new Rect(10,140,250,80), "Continue?")){ //pop up button to go back
				timerRunning = true;
				animator.enabled = false;
				glowObject.renderer.material.color = defaultColor;
				dColorStop = true;
				count++;
				introComplete = true;
				cam1.enabled = false;
				cam2.enabled = true;
			}
		}
		if( progCount >= 21.55f && GUI.Button (new Rect(10,140,250,80), "Go Back")){ //pop up button to go back
			cam1.enabled = true;
			cam2.enabled = false;
			introComplete = false;
			Application.LoadLevel ("mainmenu");
		}
#endregion		
		
	}
	
}