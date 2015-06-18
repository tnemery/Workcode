using UnityEngine;
using System.Collections;

public class guiGame : MonoBehaviour {
	public GUISkin solidBox;
	public GUISkin endGameSkin;
	public GUISkin transparent;
	public GUIStyle myStyle = new GUIStyle();
	public static GameObject Scope;
	
	public int count = 0;
	private int randNum;
	private bool needTask = true;
	public int taskNum = 1;
	public bool endGameSequence = false;
	public static bool noMoreTasks = false;
	private int min;
	private int sec;
	private int fraction;
	private int countDown;
	private float timecount;
	private float starttime;
	private float totalTime = 0f;
	private bool timeReady = false;
	private bool checkOnce = true;
	private int endLoop = 0;
	private bool initTime = true;
	private bool doOnce = true;
	
	
	public static int levelOneComp = 0;
	public float endTime;
	public float endTask;
	public float endRank;
	public float endScore;
	public float score = 0f;
	public string rank;
	
	// Use this for initialization
	void Start () {
		Scope = GameObject.FindGameObjectWithTag("MicroScope");
		endTask = -(Screen.width);
		endTime = -(Screen.width);
		endRank = -(Screen.width);
		endScore = -(Screen.width);
		totalTime = Time.time;
	}
	
	
	// Update is called once per frame
	void Update () {
		//scrolling end screen
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
		//end of endscene scroll
		
		if(gameStart.begin == true){
			if(initTime == true){
				starttime = Time.time;
				initTime = false;	
			}
			if(noMoreTasks == false){
				if(min >= 0){ //creates a timer, currently counts down from 10:00:00
					timecount = Time.time - starttime;
					min = 9-(int)(timecount/60f);
					sec = 59-(int)(timecount % 60f);
					fraction = 99-(int)((timecount * 100) %100);
					countDown = 3 - (int)(timecount % 100f); //task countdown
				}
				if(min < 0){ //stops timer at 00:00:00
					min = 0;
					sec = 0;
					fraction = 0;
				}
			}
			timeReady = true;
		}
	}
	
	void OnGUI (){	
		//Holds the game content in the upper right section
#region GameLoop
		if(timeReady == true){
			GUI.BeginGroup (new Rect(Screen.width/2,0,Screen.width/2,Screen.height/2));
				GUI.skin = solidBox;
				GUI.Box (new Rect(0,0,Screen.width/2,Screen.height/2), ""); //create a border
				if(needTask == true){
					randNum = randomNumber (1,8);
					needTask = false;
					globalVars.TaskActive[randNum] = true;
					globalVars.task = true;
				}
				if(globalVars.taskComplete == false){
					GUI.Box (new Rect(0,Screen.height/2-100,Screen.width/2+64,30), globalVars.Task[randNum]);
				}
				if(globalVars.taskComplete == true && endLoop >= 100){
					endGameSequence = true;
					noMoreTasks = true;
				}
				GUI.Label (new Rect(Screen.width/2-64,0,64,35), "<color=blue><size=30>   "+countDown.ToString()+"</size></color>"); //string.Format("{0:00}:{1:00}:{2:00}",min,sec,fraction));
				if(countDown == 0){
					globalVars.taskComplete = true; // kill the task message if there is one -- task failed, new task or finish
					//GUI.Box (new Rect(0,Screen.height/2-100,Screen.width/2+64,30), "You Have Run Out Of Time");
					noMoreTasks = true;
					//endGameSequence = true;
					globalVars.TaskActive[randNum] = false;
					globalVars.TasksCompleted[randNum] = true;
					if(checkOnce == true){
						taskLists.changeState (taskNum, false);
						taskNum++;
						checkOnce = false;
					}
					if(taskNum == (globalVars.levelOne+1)){
						endGameSequence = true;
					}
				}
			GUI.EndGroup();	
			
			if(globalVars.taskComplete == true && endLoop < 100){
				if(checkOnce == true){
					taskLists.changeState (taskNum, true);
					taskNum++;
					checkOnce = false;
				}
				if(taskNum == (globalVars.levelOne+1)){
					endGameSequence = true;
				}
				if(taskNum < (globalVars.levelOne+1)){
					if(GUI.Button (new Rect(Screen.width/2-100,0,100,30), "New Task")){
						starttime = Time.time;
						timecount = Time.time - starttime;
						countDown = 3 - (int)(timecount % 100f);
						noMoreTasks = false;
	
						//pick a random new task
						while(globalVars.TasksCompleted[randNum] == true){
							randNum = randomNumber (1,8);
							endLoop++;
							if(endLoop >= 100){
								globalVars.taskComplete = true;
								break;
							}
							checkOnce = true;
						}
						if(endLoop < 100){
							globalVars.TaskActive[randNum] = true;
							globalVars.task = true;
							globalVars.taskComplete = false;
							checkOnce = true;
						}
				}
				}
			}
		}
#endregion
		
		/* end game stats and things, based on some flag that denotes endgame to appear cease action on microscope, kill timer - show stats periodically
		 * Create a large box, probably the same as the welcome box - scroll background (for now) - use inner boxes large font black
		 * In the box display scores 1 by 1 in some formate - total clear time - tasks complete - tasks failed - rank - total score
		 * return to main menu or restart
		 * 
		 * 
		 */
		if(endGameSequence == true){
			GUI.depth = 0;
			GUI.skin = endGameSkin;
			
			if(doOnce == true){
				timecount = Time.time - totalTime;
				doOnce = false;
				calcScore();
			}
			min = 9-(9-(int)(timecount/60f));
			sec = 59-(59-(int)(timecount % 60f));
			fraction = 99-(99-(int)((timecount * 100) %100));
			
			//create Score+ Rank
			//calcScore();
			
			GUI.Box (new Rect(0,25,Screen.width,Screen.height-50), "<size=40><color=magenta>Game Over</color></size>");	
			GUI.skin = transparent;
			GUI.Box (new Rect(endTask+100,Screen.height/6,Screen.width-200,50), "<size=30><color=magenta>Tasks Completed:                                                   "+levelOneComp+"/"+globalVars.levelOne+"</color></size>");	
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
		
	}
	
	int randomNumber(int start, int end){
		return Random.Range(start, end);
	}
	
	void calcScore(){
		if(levelOneComp == 0){
			score += 0f;
		}else if(levelOneComp >= 1 && levelOneComp <=2){
			score += 100f;
		}else if(levelOneComp >= 3 && levelOneComp <= 4){
			score += 500f;
		}else if(levelOneComp == 5){
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
		noMoreTasks = false;
		cursorChange.Micro = false;
		Scope.transform.position = new Vector3(0f, 0f, 0f);
		Scope.transform.rotation = Quaternion.Euler(0,0,0);
		globalVars.taskComplete = false;
		gameStart.begin = false;
		gameWelcome.letsGo = false;
		levelOneComp = 0;
		countDown = 3;
		joyPad.rotLeftRight = 0;
		joyPad.upDown = 0f;
		joyPad.leftRight = 0f;
		joyPad.inOut = 0f;
		turnFocus.count = 0;
		turnMechStageKnob.storeY = 0;
		for(count = 0; count < globalVars.TaskActive.Length; count++){
			globalVars.TaskActive[count] = false;
			globalVars.TasksCompleted[count] = false;
		}
		taskLists.reset();
		Application.LoadLevel ("mainmenu");
	}
	
	void initialVars2() { //return all globals to default state -- restart at game loop
		needTask = true;
		noMoreTasks = false;
		cursorChange.Micro = false;
		Scope.transform.position = new Vector3(0f, 0f, 0f);
		Scope.transform.rotation = Quaternion.Euler(0,0,0);
		globalVars.taskComplete = false;
		gameStart.begin = false;
		levelOneComp = 0;
		countDown = 3;
		joyPad.rotLeftRight = 0;
		joyPad.upDown = 0f;
		joyPad.leftRight = 0f;
		joyPad.inOut = 0f;
		turnFocus.count = 0;
		turnMechStageKnob.storeY = 0;
		taskLists.reset();
		for(count = 0; count < globalVars.TaskActive.Length; count++){
			globalVars.TaskActive[count] = false;
			globalVars.TasksCompleted[count] = false;
		}
		Application.LoadLevel ("gameScene");
	}
	
}
