using UnityEngine;
using System.Collections;

public class gameOver : MonoBehaviour {
	
	public float endTime;
	public float endTask;
	public float endRank;
	public float endScore;
	public float score = 0f;
	public string rank;
	public bool endGameSequence = false;
	public GUISkin endGameSkin;
	private bool doOnce = true;
	private float totalTime = 0f;
	private int min;
	private int sec;
	private int fraction;
	static float timecount;
	public GUISkin transparent;
	private bool needTask = true;
	private int countDown;
	public int count = 0;
	private int randNum;
	// Use this for initialization
	void Start () {
		endTask = -(Screen.width);
		endTime = -(Screen.width);
		endRank = -(Screen.width);
		endScore = -(Screen.width);
		totalTime = Time.time;
	}
	
	public static void setVars(float timeSet){
		timecount = timeSet;
	}
	
	// Update is called once per frame
	void Update () {
		scrollStats ();
	}
	
	
	void scrollStats(){
		if(endGameSequence == true){
			if(endTask < 0){
				endTask += (Time.deltaTime*400);
			}else{
				endTask = 0;
				if(endTime < 0){
					endTime += (Time.deltaTime*400);
				}else{
					endTime = 0;	
					if(endScore< 0){
						endScore += (Time.deltaTime*400);
					}else{
						endScore = 0;
						if(endRank < 0){
							endRank += (Time.deltaTime*400);
						}else{
							endRank = 0;	
						}
					}
				}
			}
		}
	}
	
	void OnGUI () {
		GUI.depth = 0;
		GUI.skin = endGameSkin;
		
		if(doOnce == true){
			doOnce = false;
			calcScore();
		}
		min = 9-(9-(int)(timecount/60f));
		sec = 59-(59-(int)(timecount % 60f));
		fraction = 99-(99-(int)((timecount * 100) %100));
		
		GUI.Box (new Rect(0,25,Screen.width,Screen.height-50), "<size=40><color=magenta>Game Over</color></size>");	
		GUI.skin = transparent;
		GUI.Box (new Rect(endTask+100,Screen.height/6,Screen.width-200,50), "<size=30><color=magenta>Tasks Completed:                                                   "+guiGame.levelOneComp+"/"+globalVars.levelOne+"</color></size>");	
		GUI.Box (new Rect(endTime+100,Screen.height/4,Screen.width-200,50), "<size=30><color=magenta>Time Completed:                                           "+string.Format("{0:00}:{1:00}:{2:00}",min,sec,fraction)+"</color></size>");
		GUI.Box (new Rect(endScore+100,Screen.height/3,Screen.width-200,50), "<size=30><color=magenta>Score:                                                                   "+string.Format("{0:0000}",score)+"</color></size>");
		GUI.Box (new Rect(endRank+100,Screen.height/6+Screen.height/2,Screen.width-200,50), "<size=30><color=magenta>Rank:                                                                          "+rank+"</color></size>");
		if(GUI.Button (new Rect(50,Screen.height-80,200,50), "Start Over")){
			initialVars2();	
		}
		if(GUI.Button (new Rect(Screen.width-250,Screen.height-80,200,50), "Main Menu")){
			initialVars();	
		}	
	}
	
	
	void calcScore(){
		if(guiGame.levelOneComp == 0){
			score += 0f;
		}else if(guiGame.levelOneComp >= 1 && guiGame.levelOneComp <=2){
			score += 100f;
		}else if(guiGame.levelOneComp >= 3 && guiGame.levelOneComp <= 4){
			score += 500f;
		}else if(guiGame.levelOneComp == 5){
			score += 1000f;
		}
		
		score = score + score*((1/timecount)*100);
		
		if(score >= 0 && score <= 1000){
			rank = "C";
		}else if(score >= 1001 && score <= 3500){
			rank = "B";
		}else if(score >= 3501 && score <= 6500){
			rank = "A";
		}else if(score >= 6501){
			rank = "S";
		}
	}
	
	void initialVars() { //return all globals to default state --restart at intro screen
		needTask = true;
		guiGame.noMoreTasks = false;
		cursorChange.Micro = false;
		globalVars.taskComplete = false;
		gameStart.begin = false;
		gameWelcome.letsGo = false;
		guiGame.levelOneComp = 0;
		countDown = 3;
		turnFocus.count = 0;
		turnMechStageKnob.storeY = 0;
		for(count = 0; count < globalVars.TaskActive.Length; count++){
			globalVars.TaskActive[count] = false;
			globalVars.TasksCompleted[count] = false;
		}
		Application.LoadLevel ("mainmenu");
	}
	
	void initialVars2() { //return all globals to default state -- restart at game loop
		needTask = true;
		guiGame.noMoreTasks = false;
		cursorChange.Micro = false;
		globalVars.taskComplete = false;
		gameStart.begin = false;
		guiGame.levelOneComp = 0;
		countDown = 3;
		turnFocus.count = 0;
		turnMechStageKnob.storeY = 0;
		for(count = 0; count < globalVars.TaskActive.Length; count++){
			globalVars.TaskActive[count] = false;
			globalVars.TasksCompleted[count] = false;
		}
		Application.LoadLevel ("gameScene");
	}
	
}
