#pragma strict


                var words : TextAsset; //replaces all the I/O stuff (sigh)
                var linesIn: String[];

                var titles: String[];
                var descrips: String[];
                var testSplit: String[];
                var blarg: String[];
                var getTag: String[];
                var getTalk: String[];
                var getName: String[];
                var chatRoam: String[];
                var chatNext: String[];
                var chatAnim: String[];
                
                var textToType: String;
                var count : int = 0;
                var splitMe : String;
               private var letterPause : float = 0.07;
                var letter : char[];
                var moveChat : int = 0;
                var nextButton : int;
				var endButton : int;
				
				var waitForTyping : int = 0;


function Start () {
   // linesIn = words.text.Split("#"[0]); //0 is titles, 1 is welcome message, 2 is descrips
    //titles =  linesIn[0].Split("\n"[0]); //each title is stored on it's own line
   // descrips =  linesIn[2].Split("^"[0]); //each descrip starts with ^
   //define arrays for tags and strings
    getTag = new String[20];
    getName = new String[20];
    getTalk = new String[20];
    chatNext = new String[20];
    chatAnim = new String[20];
     var index1:int = 0;
     var index2:int = 0;
     var index3:int = 0;
	//split the strings at the beginning of each tag
	testSplit = words.text.Split("<"[0]);
	//iterate through the string to find all tags
	for(var v:int = 1; v < testSplit.Length; v++){ //start at index 1 to get the start of the tag from the split
		//split the tag from the parsed string
		blarg = testSplit[v].Split(">"[0]);
		//chatRoam = testSplit[v].Split("^"[1]);
		//store the tag and the string in the same element of different arrays for now
		getTag[v-1] = blarg[0]; //v-1 = starting space 0, 0 is tags, 1 is strings
		
		if(getTag[v-1].Substring(0,4) == "char"){
			var temp : String = getTag[v-1];
			Debug.Log(getTag[v-1]);
			chatAnim[index3] = getTag[v-1].Substring(5,temp.Length-5); //start index after = max length is string - start index
			index3++;
		}else if(getTag[v-1].Substring(0,4) == "talk"){
			//Debug.Log(blarg[1]);
			chatRoam = blarg[1].Split("^"[0]); //splits the other command off the end of the string
			//Debug.Log(chatRoam[0]);
			getTalk[index1] = chatRoam[0]; //gets the string parse
			if(chatRoam[1].Substring(chatRoam[1].Length-1,1) == "\n"){ //ensures no newline is part of the string
				chatNext[index1] = chatRoam[1].Substring(0,chatRoam[1].Length-1);
			}else{
				chatNext[index1] = chatRoam[1].Substring(0,chatRoam[1].Length);
			}
			index1++;
		}else if(getTag[v-1].Substring(0,4) == "name"){
			getName[index2] = blarg[1];
			index2++;
		}
		
		
//		chatRoam = blarg[1].Split("^"[1]);
		//getString[v-1] = chatRoam[0];
		
	}
	
	callTyping(getTalk[moveChat]);
}

function callTyping(typeThis : String){
    letter =  typeThis.ToCharArray();

     TypeText();
}


function Update(){
	if(chatNext[moveChat] == "hasNext"){
		nextButton = 1;
		endButton = 0;
	}else if(chatNext[moveChat] == "endChat"){
		nextButton = 0;
		endButton = 1;
	}
}

function OnGUI(){
if(nextButton != 0 || endButton != 0){
	GUI.BeginGroup(new Rect(0,0,Screen.width/2,Screen.height/2));
		GUI.Box(new Rect(0,0,Screen.width/6,Screen.height/12),getName[moveChat]);
    	GUI.Box(new Rect(0,Screen.height/12,Screen.width/3,Screen.height/3),splitMe);
    	if(nextButton == 1 && GUI.Button(new Rect(Screen.width/6,0,Screen.width/6,Screen.height/12),"Next") && waitForTyping == 0){
    		moveChat++;
    		splitMe = null;
    		count = 0;
    		callTyping(getTalk[moveChat]);
    	}else if(endButton == 1 && GUI.Button(new Rect(Screen.width/6,0,Screen.width/6,Screen.height/12),"Done") && waitForTyping == 0){
    		moveChat++;
    		endButton = 0;
    	}
    GUI.EndGroup();
   }
}


/* - Typewritter function
	




*/
function TypeText () {
	while(count < letter.Length){
		yield WaitForSeconds (letterPause);
		splitMe += letter[count];
		count++;
		waitForTyping = 1;
	}
	waitForTyping = 0;
}





function randomNumber( start : int,  end : int):int{
		return Random.Range(start, end);
	}
