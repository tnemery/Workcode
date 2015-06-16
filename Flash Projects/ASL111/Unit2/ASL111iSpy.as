/******************************************
Oregon State University Extended Campus 
-Designed and Written by: Warren Blyth, Thomas Emery
.created: July 17, 2012 
.approved: 
.delivered: 

- iSpy game for ASL11
- This will be template code for the scenese that will be done at a later time

--> Choose the MC you wish to identify
--> Click one of the videos to play it
--> type in the text to identify the video
--> text then appears below the videos thumbnail
--> video lights up in the thumbnail
--> images will be on the stage, find the image and click it
--> once it's found the image is removed off the stage and put in a slot above the thumbnail
--> repeat until there are no more videos to find in the area
--> stairs or something appear to move on to the next area or scoreboard

//clean up the code and this above pretense, add descriptive commetns so no one gets lost.
To Do:

Variables:


Functions:

/// ----------- goto line 1296

*******************************************/

package{
	
import fl.video.*;
import flash.errors.IOError;
import flash.events.IOErrorEvent;
import flash.display.*;
import flash.geom.*;
import flash.events.*;
import flash.text.*;
import flash.media.*;
import flash.net.*;
import flash.xml.*;
import flash.utils.*;
import flash.text.Font;
import flash.filters.*;

	public class ASL111iSpy extends MovieClip{
		
		var videoURL:String;
		var g_curVid:String;
		var connection:NetConnection;
		var stream:NetStream;
		var video:Video = new Video();
		var videosInPlay:Array = new Array();
		var shiftX:Number = 180;
		var leftThumbInvis:Boolean = false;
		var rightThumbInvis:Boolean = false;
		var usedThumbs:Array = new Array(0);
		var firstContainerFlag:Boolean = true; //is this the first object clicked
		var thumbCounter:Number = 0; //count the number of thumbs currently on the stage, needed for shifting
		var leftPointer:Number = 0; //keeps track of the thumb currently on the left side
		var rightPointer:Number = 0; //keeps track of the thumb currently on the right side
		var thumbsOnStage:Number = 0; //keep track of the number of thumbs on the stage
		var currentMatchTarget:String = ""; //keeps track of the currently selected item to find
		var myGlow:GlowFilter = new GlowFilter(0x00FF00,1,6,6,10,1); //add a glow for objects
		var thumbGlow:GlowFilter = new GlowFilter(0xFFFF00,1,6,6,2,15,false,false); //add a glow for Thumbs
		var thumbGlowWrong:GlowFilter = new GlowFilter(0xFF0000,1,6,6,2,15,false,false); //add a glow for Thumbs
		var imageFound:Array = new Array("no","no","no","no","no","no","no","no","no",
										 "no","no","no","no","no","no","no","no","no","no","no","no","no","no","no",
										 "no","no","no","no","no","no","no","no","no","no","no","no","no","no","no",
										 "no","no","no","no","no","no"); //extend to 45 slots
		var thumbTypedWords:Array = new Array("","","","","","","","","","","","","",
											  "","","","","","","","","","","","","",
											  "","","","","","","","","","","","","",
											  "","","","","","");	//extend to 45 slots									  
		var realWordList:Array = new Array("Oh I See","Chair","Man","Learn","Girl","Sit","Window","Light","Don't Know","Yes","Where","No","Right",
											  "Teacher","Who","Boy","Class","Same As", "Deaf", "Not", "Door", "Woman", "Open", "Wrong", "Remember",
											  "Stand","Teach","Learner","Hearing","Spanish","French","Know","College","On","CCC","PSU","WOU",
											  "School","Elementary","High School","Off","OSU","Close","Sigh(Language)","University"); //fix words
		var currentPercent:Number;
		var myTimer:Timer = new Timer(1000);
		var rockWallBreakFlag:Boolean = true;
		var timeSnapShot:Number = 0;
		var classTime:Number = 20;
		var localTime:Number;

		public function ASL111iSpy() {
			// constructor code
			trace("linked");
			allEvents(); //cleans up the code a bit and toss the events at the end
			instructions.visible = false // default instructions are off
			playMovies.visible = false;
			gameOver.visible = false;
			thumbLeft.leftA.gotoAndStop(1); //default thumb arrow positions
			thumbRight.rightA.gotoAndStop(1);
			
			scene02.visible = false; //only scene01 will be available at the start
			scene03.visible = false;
			scene04.visible = false;
			scene05.visible = false;
			scene06.visible = false;
			scene07.visible = false;
			scene08.visible = false;
			scene09.visible = false;
			scene10.visible = false;
			scene11.visible = false;
			scene12.visible = false;
			scene13.visible = false;
			scene14.visible = false;
			scene15.visible = false;
			scene16.visible = false;
			scene17.visible = false;
			scene18.visible = false;
			
			
			
				
			myTimer.start();
		}
		
		public function scaleBtnUp(evt:MouseEvent):void{ //when moused over the button will become enlarged
			evt.currentTarget.scaleX += .1;
			evt.currentTarget.scaleY += .1;
		}
		
		public function scaleBtnDown(evt:MouseEvent):void{ //when moused out the button will go back to normal
			evt.currentTarget.scaleX -= .1;
			evt.currentTarget.scaleY -= .1;
		}
		
		public function gotoFirstScreen(evt:MouseEvent):void{ 
			scene02.visible = false;
			scene01.visible = true;
		}
		
		public function nextScreenFadeIn(evt:MouseEvent):void{
			evt.currentTarget.alpha = .5;
		}
		
		public function nextScreenFadeOut(evt:MouseEvent):void{
			evt.currentTarget.alpha = .01;
		}
		
		public function beginGame(evt:MouseEvent):void{
			startGame.blackFade.gotoAndPlay(2);
			startGame.blackFade.gotoAndPlay(2); //for some reason adding this twice makes the tween play, but adding it once makes it not?
			addEventListener(Event.ENTER_FRAME, timeTaken);
		}
		
		public function timeTaken(evt:Event):void{
			localTime = classTime - convertMinutesOnly();
			
			timeForClass.text = String(localTime);
		}
		
		public function instructionsOff(evt:MouseEvent):void{
			instructions.visible = false;
		}
		public function instructionsOn(evt:MouseEvent):void{
			instructions.visible = true;
		}
		
		public function imageOut(evt:MouseEvent):void{
			evt.currentTarget.filters = [];
		}
		
		public function imageOver(evt:MouseEvent):void{
			evt.currentTarget.filters = [myGlow];
		}
		
		public function setupGameOver(){
			myTimer.stop();
			trace(myTimer.currentCount+" seconds");
			currentPercent = 0;
			currentPercent+= (thumbCounter*1.11);
			for(var imageCheck:int=0;imageCheck<imageFound.length;imageCheck++){
				if(imageFound[imageCheck] == "yes"){
					currentPercent += 1.11;
					trace("image check True");
				}
			}
			currentPercent = roundDecimal(currentPercent,2);
			if(currentPercent >= 99.9){
				currentPercent = 100;
			}//Time bonus, if you finish in 4 minutes or less your score does not change
			trace("localTime is: "+ localTime);
			
			if(localTime >= 20){ //bonus points for having time left to get to class
				currentPercent += 100; 
			}else if(localTime >= 15 && localTime < 20){
				currentPercent += 75;
			}else if(localTime >= 10 && localTime < 15){
				currentPercent += 50;
			}else if(localTime >= 5 && localTime < 10){
				currentPercent += 25;
			}else if(localTime >= 0 && localTime < 5){
				currentPercent += 5;
			}else if(localTime < 0){
				//You are late
				currentPercent -= 50;
			}
			gameOver.blackFade.gameOver.timeLoss.text = convertTime();
			removeEventListener(Event.ENTER_FRAME, timeTaken);
			gameOver.blackFade.gameOver.score.text = String(Math.round(currentPercent*100)/100); //Just a number not to be taken seriously
			gameOver.blackFade.gameOver.wordList.addColumn("Your Word");
			gameOver.blackFade.gameOver.wordList.addColumn("Actual Word");
			gameOver.blackFade.gameOver.wordList.addColumn("Object Found");
			gameOver.blackFade.gameOver.disksFound.text = String(thumbCounter)+"/45";
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[0],"Actual Word":realWordList[0],"Object Found":imageFound[0]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[1],"Actual Word":realWordList[1],"Object Found":imageFound[1]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[2],"Actual Word":realWordList[2],"Object Found":imageFound[2]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[3],"Actual Word":realWordList[3],"Object Found":imageFound[3]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[4],"Actual Word":realWordList[4],"Object Found":imageFound[4]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[5],"Actual Word":realWordList[5],"Object Found":imageFound[5]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[6],"Actual Word":realWordList[6],"Object Found":imageFound[6]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[7],"Actual Word":realWordList[7],"Object Found":imageFound[7]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[8],"Actual Word":realWordList[8],"Object Found":imageFound[8]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[9],"Actual Word":realWordList[9],"Object Found":imageFound[9]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[10],"Actual Word":realWordList[10],"Object Found":imageFound[10]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[11],"Actual Word":realWordList[11],"Object Found":imageFound[11]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[12],"Actual Word":realWordList[12],"Object Found":imageFound[12]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[13],"Actual Word":realWordList[13],"Object Found":imageFound[13]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[14],"Actual Word":realWordList[14],"Object Found":imageFound[14]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[15],"Actual Word":realWordList[15],"Object Found":imageFound[15]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[16],"Actual Word":realWordList[16],"Object Found":imageFound[16]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[17],"Actual Word":realWordList[17],"Object Found":imageFound[17]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[18],"Actual Word":realWordList[18],"Object Found":imageFound[18]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[19],"Actual Word":realWordList[19],"Object Found":imageFound[19]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[20],"Actual Word":realWordList[20],"Object Found":imageFound[20]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[21],"Actual Word":realWordList[21],"Object Found":imageFound[21]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[22],"Actual Word":realWordList[22],"Object Found":imageFound[22]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[23],"Actual Word":realWordList[23],"Object Found":imageFound[23]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[24],"Actual Word":realWordList[24],"Object Found":imageFound[24]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[25],"Actual Word":realWordList[25],"Object Found":imageFound[25]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[26],"Actual Word":realWordList[26],"Object Found":imageFound[26]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[27],"Actual Word":realWordList[27],"Object Found":imageFound[27]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[28],"Actual Word":realWordList[28],"Object Found":imageFound[28]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[29],"Actual Word":realWordList[29],"Object Found":imageFound[29]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[30],"Actual Word":realWordList[30],"Object Found":imageFound[30]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[31],"Actual Word":realWordList[31],"Object Found":imageFound[31]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[32],"Actual Word":realWordList[32],"Object Found":imageFound[32]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[33],"Actual Word":realWordList[33],"Object Found":imageFound[33]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[34],"Actual Word":realWordList[34],"Object Found":imageFound[34]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[35],"Actual Word":realWordList[35],"Object Found":imageFound[35]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[36],"Actual Word":realWordList[36],"Object Found":imageFound[36]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[37],"Actual Word":realWordList[37],"Object Found":imageFound[37]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[38],"Actual Word":realWordList[38],"Object Found":imageFound[38]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[39],"Actual Word":realWordList[39],"Object Found":imageFound[39]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[40],"Actual Word":realWordList[40],"Object Found":imageFound[40]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[41],"Actual Word":realWordList[41],"Object Found":imageFound[41]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[42],"Actual Word":realWordList[42],"Object Found":imageFound[42]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[43],"Actual Word":realWordList[43],"Object Found":imageFound[43]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[44],"Actual Word":realWordList[44],"Object Found":imageFound[44]});
		}
		
		public function convertMinutesOnly():Number{
			var minutes:int = 0;
			var remainder:int = myTimer.currentCount;
			var count:int = 0;
			var remLessThan10:String;
			while(count<remainder){
				count++;
				if(count%60 == 0){
					minutes++;
				}
			}
			if((remainder-(minutes*60))<10){
				remLessThan10 = "0"+ String((remainder-(minutes*60)));
				return minutes;
			}else{
				return minutes;
			}
		}
		
		public function convertTime():String{ //takes the total time used to complete the game and converts it into minutes and seconds
			var minutes:int = 0;
			var remainder:int = myTimer.currentCount;
			var count:int = 0;
			var remLessThan10:String;
			while(count<remainder){
				count++;
				if(count%60 == 0){
					minutes++;
				}
			}
			if((remainder-(minutes*60))<10){
				remLessThan10 = "0"+ String((remainder-(minutes*60)));
				return String(minutes)+":"+remLessThan10;
			}else{
				return String(minutes+":"+(remainder-(minutes*60)));
			}
		}
		
		public function gotoNextScene(evt:MouseEvent):void{ //takes the current scene and determines the next scene
			trace(evt.currentTarget.parent.name);
			switch(evt.currentTarget.parent.name){
				case "scene01" :
								scene01.visible = false;
								scene02.visible = true;
								break;
				case "scene02" :
								scene02.visible = false;
								scene03.visible = true;
								break;
				case "scene03" :
								scene03.visible = false;
								scene04.visible = true;
								break;
				case "scene04" : //double scene -> S5, S7
								scene04.visible = false;
								scene07.visible = true;
								break;
				case "scene05" :
								scene05.visible = false;
								scene06.visible = true;
								break;
				case "scene07" : //double scene -> S3, S8
								scene07.visible = false;
								scene08.visible = true;
								break;
				case "scene08" : //double scene S9, S10
								scene08.visible = false;
								scene10.visible = true;
								break;
				case "scene10" :
								scene10.visible = false;
								scene11.visible = true;
								break;
				case "scene11" : //double scene S12, S13
								scene11.visible = false;
								scene13.visible = true;
								break;
				case "scene13" :
								scene13.visible = false;
								scene14.visible = true;
								break;
				case "scene14" :
								scene14.visible = false;
								scene15.visible = true;
								break;
				case "scene15" : //triple scene -> S16, S17, S18
								scene15.visible = false;
								scene18.visible = true;
								break;
				case "scene18" : scene18.endGamePopUp.visible = true;
								 scene18.endGamePopUp.EGyes.addEventListener(MouseEvent.CLICK, endGame);
								 scene18.endGamePopUp.EGno.addEventListener(MouseEvent.CLICK, doNotEndGame);
								break; 
				default:
						trace("scene does not exist");
			}
		}
		
		public function endGame(evt:MouseEvent):void{
			gameOver.visible = true; //goes to the game over screen with a fade in/out
			gameOver.blackFade.gotoAndPlay(0);
			setupGameOver();
		}
		
		public function doNotEndGame(evt:MouseEvent):void{
			scene18.endGamePopUp.visible = false;
			scene18.endGamePopUp.EGyes.removeEventListener(MouseEvent.CLICK, endGame);
			scene18.endGamePopUp.EGno.removeEventListener(MouseEvent.CLICK, doNotEndGame);
		}
		
		public function gotoSceneSpecial01(evt:MouseEvent):void{ //determines the next scene by taking in a scene
			switch(evt.currentTarget.parent.name){
				case "scene04" :
								scene04.visible = false;
								scene05.visible = true;
								break;
				case "scene07" :
								scene07.visible = false;
								scene03.visible = true;
								break;
				case "scene08" :
								scene08.visible = false;
								scene09.visible = true;
								break;
				case "scene11" :
								scene11.visible = false;
								scene12.visible = true;
								break;
				case "scene15" :
								scene15.visible = false;
								scene16.visible = true;
								break;
				default :
								trace("scene does not exist");
								break;
			}
		}
		
		public function gotoSceneSpecial02(evt:MouseEvent):void{ // only one use, to go below the desk in this case
			scene15.visible = false;
			scene17.visible = true;
		}
		
		public function gotoPreviousScene(evt:MouseEvent):void{ //goes back to the previous scene, takes the current scene as an arg
			trace(evt.currentTarget.parent.name);
			switch(evt.currentTarget.parent.name){
				case "scene02" :
								scene02.visible = false;
								scene01.visible = true;
								break;
				case "scene03" :
								scene03.visible = false;
								scene02.visible = true;
								break;
				case "scene04" :
								scene04.visible = false;
								scene03.visible = true;
								break;
				case "scene05" :
								scene05.visible = false;
								scene04.visible = true;
								break;
				case "scene06" : //this will only have a go back to S5
								scene06.visible = false;
								scene05.visible = true;
								break;
				case "scene07" : 
								scene07.visible = false;
								scene04.visible = true;
								break;
				case "scene08" : 
								scene08.visible = false;
								scene07.visible = true;
								break;
				case "scene09" : //Just goes back to S8
								scene09.visible = false;
								scene08.visible = true;
								break;
				case "scene10" :
								scene10.visible = false;
								scene08.visible = true;
								break;
				case "scene11" : //this will only have a go back to S5
								scene11.visible = false;
								scene10.visible = true;
								break;
				case "scene12" : //only goes back to S11
								scene12.visible = false;
								scene11.visible = true;
								break;
				case "scene13" : //this will only have a go back to S5
								scene13.visible = false;
								scene11.visible = true;
								break;
				case "scene14" : //this will only have a go back to S5
								scene14.visible = false;
								scene13.visible = true;
								break;
				case "scene15" : //double case, but will name both the same
								scene15.visible = false;
								scene14.visible = true;
								break;
				case "scene16" : //These only go back to S15
								scene16.visible = false;
								scene15.visible = true;
								break;
				case "scene17" :
								scene17.visible = false;
								scene15.visible = true;
								break; 
				case "scene18" :
								scene18.visible = false;
								scene15.visible = true;
								break;
				default:
						trace("scene does not exist");
			}
		}
		
		public function clearText(evt:MouseEvent):void{ //clear the text box when clicked
			playMovies.nameVideo.submitTitle.text = "";
		}
		
		public function checkImage(evt:MouseEvent){
			if(evt.currentTarget.name == currentMatchTarget){
				trace(evt.currentTarget.name);
				//images.removeChild(MovieClip(evt.currentTarget));
				setImage(evt.currentTarget);
			}else{
				evt.currentTarget.filters = [thumbGlowWrong];
			}
		}
		
		public function setImage(correctImage:Object){
			switch(correctImage.name){
				case "img00":  	scene02.img00.x = 0;
								scene02.img00.y = 0;
								scene02.img00.width = 82;
								scene02.img00.height = 61;
								scene02.img00.visible = false; //fixes an afterimage bug
								scene01.img00.visible = false;
								t00.img00copy.visible = true;
								imageFound[0] = "yes";
								t00.filters = [];
								classTime += 1;
								scene01.img00.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								scene02.img00.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img01":  	scene02.img01.x = 0;
								scene02.img01.y = 0;
								scene02.img01.width = 82;
								scene02.img01.height = 61;
								scene02.img01.visible = false;
								t01.img01copy.visible = true;
								imageFound[1] = "yes";
								t01.filters = [];
								classTime += 1;
								scene02.img01.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img02":  	scene02.img02.x = 0;
								scene02.img02.y = 0;
								scene02.img02.width = 82;
								scene02.img02.height = 61;
								scene02.img02.visible = false;
								t02.img02copy.visible = true;
								imageFound[2] = "yes";
								t02.filters = [];
								classTime += 1;
								scene02.img02.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img03":  	scene02.img03.x = 0;
								scene02.img03.y = 0;
								scene02.img03.width = 82;
								scene02.img03.height = 61;
								scene02.img03.visible = false;
								t03.img03copy.visible = true;
								imageFound[3] = "yes";
								t03.filters = [];
								classTime += 1;
								scene02.img03.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img04":  	scene10.img04.x = 0;
								scene10.img04.y = 0;
								scene10.img04.width = 82;
								scene10.img04.height = 61;
								scene10.img04.visible = false;
								t04.img04copy.visible = true;
								imageFound[4] = "yes";
								t04.filters = [];
								classTime += 1;
								scene10.img04.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img05":  	scene04.img05.x = 0;
								scene04.img05.y = 0;
								scene04.img05.width = 82;
								scene04.img05.height = 61;
								scene04.img05.visible = false;
								t05.img05copy.visible = true;
								imageFound[5] = "yes";
								t05.filters = [];
								classTime += 1;
								scene04.img05.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img06":  	scene05.img06.x = 0;
								scene05.img06.y = 0;
								scene05.img06.width = 82;
								scene05.img06.height = 61;
								scene05.img06.visible = false;
								t06.img06copy.visible = true;
								imageFound[6] = "yes";
								t06.filters = [];
								classTime += 1;
								scene05.img06.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img07":  	scene05.img07.x = 0;
								scene05.img07.y = 0;
								scene05.img07.width = 82;
								scene05.img07.height = 61;
								scene05.img07.visible = false;
								t07.img07copy.visible = true;
								imageFound[7] = "yes";
								t07.filters = [];
								classTime += 1;
								scene05.img07.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img08":   scene06.img08.x = 0;
								scene06.img08.y = 0;
								scene06.img08.width = 82;
								scene06.img08.height = 61;
								scene06.img08.visible = false;
								t08.img08copy.visible = true;
								imageFound[8] = "yes";
								t08.filters = [];
								classTime += 1;
								scene06.img08.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img09":   scene06.img09.x = 0;
								scene06.img09.y = 0;
								scene06.img09.width = 82;
								scene06.img09.height = 61;
								scene06.img09.visible = false;
								t09.img09copy.visible = true;
								imageFound[9] = "yes";
								t09.filters = [];
								classTime += 1;
								scene06.img09.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img10":   scene07.img10.x = 0;
								scene07.img10.y = 0;
								scene07.img10.width = 82;
								scene07.img10.height = 61;
								scene07.img10.visible = false;
								t10.img10copy.visible = true;
								imageFound[10] = "yes";
								t10.filters = [];
								classTime += 1;
								scene07.img10.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img11":  	scene07.img11.x = 0;
								scene07.img11.y = 0;
								scene07.img11.width = 82;
								scene07.img11.height = 61;
								scene07.img11.visible = false;
								t11.img11copy.visible = true;
								imageFound[11] = "yes";
								t11.filters = [];
								classTime += 1;
								scene07.img11.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img12": 	scene07.img12.x = 0;
								scene07.img12.y = 0;
								scene07.img12.width = 82;
								scene07.img12.height = 61;
								scene07.img12.visible = false;
								t12.img12copy.visible = true;
								imageFound[12] = "yes";
								classTime += 1;
								t12.filters = []; //remove the glow since the img is correct
								scene07.img12.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img13":  	scene08.img13.x = 0;
								scene08.img13.y = 0;
								scene08.img13.width = 82;
								scene08.img13.height = 61;
								scene08.img13.visible = false;
								t13.img13copy.visible = true;
								imageFound[13] = "yes";
								t13.filters = [];
								classTime += 1;
								scene08.img13.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img14":  	scene08.img14.x = 0;
								scene08.img14.y = 0;
								scene08.img14.width = 82;
								scene08.img14.height = 61;
								scene08.img14.visible = false;
								t14.img14copy.visible = true;
								imageFound[14] = "yes";
								t14.filters = [];
								classTime += 1;
								scene08.img14.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img15":  	scene08.img15.x = 0;
								scene08.img15.y = 0;
								scene08.img15.width = 82;
								scene08.img15.height = 61;
								scene08.img15.visible = false;
								t15.img15copy.visible = true;
								imageFound[15] = "yes";
								t15.filters = [];
								classTime += 1;
								scene08.img15.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img16":  	scene08.img16.x = 0;
								scene08.img16.y = 0;
								scene08.img16.width = 82;
								scene08.img16.height = 61;
								scene08.img16.visible = false;
								t16.img16copy.visible = true;
								imageFound[16] = "yes";
								t16.filters = [];
								classTime += 1;
								scene08.img16.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img17":  	scene09.img17.x = 0;
								scene09.img17.y = 0;
								scene09.img17.width = 82;
								scene09.img17.height = 61;
								scene09.img17.visible = false;
								t17.img17copy.visible = true;
								imageFound[17] = "yes";
								t17.filters = [];
								classTime += 1;
								scene09.img17.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img18":  	scene09.img18.x = 0;
								scene09.img18.y = 0;
								scene09.img18.width = 82;
								scene09.img18.height = 61;
								scene09.img18.visible = false;
								t18.img18copy.visible = true;
								imageFound[18] = "yes";
								t18.filters = [];
								classTime += 1;
								scene09.img18.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img19":  	scene10.img19.x = 0;
								scene10.img19.y = 0;
								scene10.img19.width = 82;
								scene10.img19.height = 61;
								scene10.img19.visible = false;
								t19.img19copy.visible = true;
								imageFound[19] = "yes";
								t19.filters = [];
								classTime += 1;
								scene10.img19.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img20":  	scene10.img20.x = 0;
								scene10.img20.y = 0;
								scene10.img20.width = 82;
								scene10.img20.height = 61;
								scene10.img20.visible = false;
								t20.img20copy.visible = true;
								imageFound[20] = "yes";
								t20.filters = [];
								classTime += 1;
								scene10.img20.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img21":  	scene03.img21.x = 0;
								scene03.img21.y = 0;
								scene03.img21.width = 82;
								scene03.img21.height = 61;
								scene03.img21.visible = false;
								t21.img21copy.visible = true;
								imageFound[21] = "yes";
								t21.filters = [];
								classTime += 1;
								scene03.img21.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img22":  	scene10.img22.x = 0;
								scene10.img22.y = 0;
								scene10.img22.width = 82;
								scene10.img22.height = 61;
								scene10.img22.visible = false;
								t22.img22copy.visible = true;
								imageFound[22] = "yes";
								t22.filters = [];
								classTime += 1;
								scene10.img22.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img23":  	scene10.img23.x = 0;
								scene10.img23.y = 0;
								scene10.img23.width = 82;
								scene10.img23.height = 61;
								scene10.img23.visible = false;
								t23.img23copy.visible = true;
								imageFound[23] = "yes";
								t23.filters = [];
								classTime += 1;
								scene10.img23.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img24":  	scene11.img24.x = 0;
								scene11.img24.y = 0;
								scene11.img24.width = 82;
								scene11.img24.height = 61;
								scene11.img24.visible = false;
								t24.img24copy.visible = true;
								imageFound[24] = "yes";
								t24.filters = [];
								classTime += 1;
								scene11.img24.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img25":  	scene11.img25.x = 0;
								scene11.img25.y = 0;
								scene11.img25.width = 82;
								scene11.img25.height = 61;
								scene11.img25.visible = false;
								t25.img25copy.visible = true;
								imageFound[25] = "yes";
								t25.filters = [];
								classTime += 1;
								scene11.img25.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img26":  	scene13.img26.x = 0;
								scene13.img26.y = 0;
								scene13.img26.width = 82;
								scene13.img26.height = 61;
								scene13.img26.visible = false;
								t26.img26copy.visible = true;
								imageFound[26] = "yes";
								t26.filters = [];
								classTime += 1;
								scene13.img26.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img27":  	scene13.img27.x = 0;
								scene13.img27.y = 0;
								scene13.img27.width = 82;
								scene13.img27.height = 61;
								scene13.img27.visible = false;
								t27.img27copy.visible = true;
								imageFound[27] = "yes";
								t27.filters = [];
								classTime += 1;
								scene13.img27.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img28":  	scene14.img28.x = 0;
								scene14.img28.y = 0;
								scene14.img28.width = 82;
								scene14.img28.height = 61;
								scene14.img28.visible = false;
								t28.img28copy.visible = true;
								imageFound[28] = "yes";
								t28.filters = [];
								classTime += 1;
								scene14.img28.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img29":  	scene14.img29.x = 0;
								scene14.img29.y = 0;
								scene14.img29.width = 82;
								scene14.img29.height = 61;
								scene14.img29.visible = false;
								t29.img29copy.visible = true;
								imageFound[29] = "yes";
								t29.filters = [];
								classTime += 1;
								scene14.img29.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img30":  	scene14.img30.x = 0;
								scene14.img30.y = 0;
								scene14.img30.width = 82;
								scene14.img30.height = 61;
								scene14.img30.visible = false;
								t30.img30copy.visible = true;
								imageFound[0] = "yes";
								t30.filters = [];
								classTime += 1;
								scene14.img30.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img31":  	scene15.img31.x = 0;
								scene15.img31.y = 0;
								scene15.img31.width = 82;
								scene15.img31.height = 61;
								scene15.img31.visible = false;
								t31.img31copy.visible = true;
								imageFound[31] = "yes";
								t31.filters = [];
								classTime += 1;
								scene15.img31.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img32":  	scene15.img32.x = 0;
								scene15.img32.y = 0;
								scene15.img32.width = 82;
								scene15.img32.height = 61;
								scene15.img32.visible = false;
								t32.img32copy.visible = true;
								imageFound[32] = "yes";
								t32.filters = [];
								classTime += 1;
								scene15.img32.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img33":  	scene15.img33.x = 0;
								scene15.img33.y = 0;
								scene15.img33.width = 82;
								scene15.img33.height = 61;
								scene15.img33.visible = false;
								t33.img33copy.visible = true;
								imageFound[33] = "yes";
								t33.filters = [];
								classTime += 1;
								scene15.img33.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img34":  	scene16.img34.x = 0;
								scene16.img34.y = 0;
								scene16.img34.width = 82;
								scene16.img34.height = 61;
								scene16.img34.visible = false;
								t34.img34copy.visible = true;
								imageFound[34] = "yes";
								t34.filters = [];
								classTime += 1;
								scene16.img34.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img35":  	scene16.img35.x = 0;
								scene16.img35.y = 0;
								scene16.img35.width = 82;
								scene16.img35.height = 61;
								scene16.img35.visible = false;
								t35.img35copy.visible = true;
								imageFound[35] = "yes";
								t35.filters = [];
								classTime += 1;
								scene16.img35.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img36":  	scene16.img36.x = 0;
								scene16.img36.y = 0;
								scene16.img36.width = 82;
								scene16.img36.height = 61;
								scene16.img36.visible = false;
								t36.img36copy.visible = true;
								imageFound[36] = "yes";
								t36.filters = [];
								classTime += 1;
								scene16.img36.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img37":  	scene17.img37.x = 0;
								scene17.img37.y = 0;
								scene17.img37.width = 82;
								scene17.img37.height = 61;
								scene17.img37.visible = false;
								t37.img37copy.visible = true;
								imageFound[37] = "yes";
								t37.filters = [];
								classTime += 1;
								scene17.img37.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img38":  	scene15.img38.x = 0;
								scene15.img38.y = 0;
								scene15.img38.width = 82;
								scene15.img38.height = 61;
								scene15.img38.visible = false;
								t38.img38copy.visible = true;
								imageFound[38] = "yes";
								t38.filters = [];
								classTime += 1;
								scene15.img38.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img39":  	scene17.img39.x = 0;
								scene17.img39.y = 0;
								scene17.img39.width = 82;
								scene17.img39.height = 61;
								scene17.img39.visible = false;
								t39.img39copy.visible = true;
								imageFound[39] = "yes";
								t39.filters = [];
								classTime += 1;
								scene17.img39.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img40":  	scene17.img40.x = 0;
								scene17.img40.y = 0;
								scene17.img40.width = 82;
								scene17.img40.height = 61;
								scene17.img40.visible = false;
								t40.img40copy.visible = true;
								imageFound[40] = "yes";
								t40.filters = [];
								classTime += 1;
								scene17.img40.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img41":  	scene18.img41.x = 0;
								scene18.img41.y = 0;
								scene18.img41.width = 82;
								scene18.img41.height = 61;
								scene18.img41.visible = false;
								t41.img41copy.visible = true;
								imageFound[41] = "yes";
								t41.filters = [];
								classTime += 1;
								scene18.img41.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img42":  	scene18.img42.x = 0;
								scene18.img42.y = 0;
								scene18.img42.width = 82;
								scene18.img42.height = 61;
								scene18.img42.visible = false;
								t42.img42copy.visible = true;
								imageFound[42] = "yes";
								t42.filters = [];
								classTime += 1;
								scene18.img42.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img43":  	scene18.img43.x = 0;
								scene18.img43.y = 0;
								scene18.img43.width = 82;
								scene18.img43.height = 61;
								scene18.img43.visible = false;
								t43.img43copy.visible = true;
								imageFound[43] = "yes";
								t43.filters = [];
								classTime += 1;
								scene18.img43.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img44":  	scene18.img44.x = 0;
								scene18.img44.y = 0;
								scene18.img44.width = 82;
								scene18.img44.height = 61;
								scene18.img44.visible = false;
								t44.img44copy.visible = true;
								imageFound[44] = "yes";
								t44.filters = [];
								classTime += 1;
								scene18.img44.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				default: trace("the image was lost, cannot place in the thumb");
			}
		}
		
		public function thumbSelection(item:String){
			t00.filters = [];
			t01.filters = [];
			t02.filters = [];
			t03.filters = [];
			t04.filters = [];
			t05.filters = [];
			t06.filters = [];
			t07.filters = [];
			t08.filters = [];
			t09.filters = [];
			t10.filters = [];
			t11.filters = [];
			t12.filters = [];
			t13.filters = [];
			t14.filters = [];
			t15.filters = [];
			t16.filters = [];
			t17.filters = [];
			t18.filters = [];
			t19.filters = [];
			t20.filters = [];
			t21.filters = [];
			t22.filters = [];
			t23.filters = [];
			t24.filters = [];
			t25.filters = [];
			t26.filters = [];
			t27.filters = [];
			t28.filters = [];
			t29.filters = [];
			t30.filters = [];
			t31.filters = [];
			t32.filters = [];
			t33.filters = [];
			t34.filters = [];
			t35.filters = [];
			t36.filters = [];
			t37.filters = [];
			t38.filters = [];
			t39.filters = [];
			t40.filters = [];
			t41.filters = [];
			t42.filters = [];
			t43.filters = [];
			t44.filters = [];
			switch(item){
				case "img00": if(imageFound[0] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t00.filters = [thumbGlow];
								}
								break;
				case "img01": if(imageFound[1] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t01.filters = [thumbGlow];
								}
								break;
				case "img02": if(imageFound[2] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t02.filters = [thumbGlow];
								}
								break;
				case "img03": if(imageFound[3] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t03.filters = [thumbGlow];
								}
								break;
				case "img04": if(imageFound[4] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t04.filters = [thumbGlow];
								}
								break;
				case "img05": if(imageFound[5] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t05.filters = [thumbGlow];
								}
								break;
				case "img06": if(imageFound[6] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t06.filters = [thumbGlow];
								}
								break;
				case "img07": if(imageFound[7] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t07.filters = [thumbGlow];
								}
								break;
				case "img08": if(imageFound[8] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t08.filters = [thumbGlow];
								}
								break;
				case "img09": if(imageFound[9] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t09.filters = [thumbGlow];
								}
								break;
				case "img10": if(imageFound[10] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t10.filters = [thumbGlow];
								}
								break;
				case "img11": if(imageFound[11] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t11.filters = [thumbGlow];
								}
								break;
				case "img12": if(imageFound[12] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t12.filters = [thumbGlow];
								}
								break;
				case "img13": if(imageFound[13] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t13.filters = [thumbGlow];
								}
								break;
				case "img14": if(imageFound[14] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t14.filters = [thumbGlow];
								}
								break;
				case "img15": if(imageFound[15] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t15.filters = [thumbGlow];
								}
								break;
				case "img16": if(imageFound[16] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t16.filters = [thumbGlow];
								}
								break;
				case "img17": if(imageFound[17] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t17.filters = [thumbGlow];
								}
								break;
				case "img18": if(imageFound[18] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t18.filters = [thumbGlow];
								}
								break;
				case "img19": if(imageFound[19] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t19.filters = [thumbGlow];
								}
								break;
				case "img20": if(imageFound[20] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t20.filters = [thumbGlow];
								}
								break;
				case "img21": if(imageFound[21] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t21.filters = [thumbGlow];
								}
								break;
				case "img22": if(imageFound[22] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t22.filters = [thumbGlow];
								}
								break;
				case "img23": if(imageFound[23] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t23.filters = [thumbGlow];
								}
								break;
				case "img24": if(imageFound[24] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t24.filters = [thumbGlow];
								}
								break;
				case "img25": if(imageFound[25] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t25.filters = [thumbGlow];
								}
								break;
				case "img26": if(imageFound[26] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t26.filters = [thumbGlow];
								}
								break;
				case "img27": if(imageFound[27] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t27.filters = [thumbGlow];
								}
								break;
				case "img28": if(imageFound[28] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t28.filters = [thumbGlow];
								}
								break;
				case "img29": if(imageFound[29] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t29.filters = [thumbGlow];
								}
								break;
				case "img30": if(imageFound[30] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t30.filters = [thumbGlow];
								}
								break;
				case "img31": if(imageFound[31] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t31.filters = [thumbGlow];
								}
								break;
				case "img32": if(imageFound[32] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t32.filters = [thumbGlow];
								}
								break;
				case "img33": if(imageFound[33] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t33.filters = [thumbGlow];
								}
								break;
				case "img34": if(imageFound[34] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t34.filters = [thumbGlow];
								}
								break;
				case "img35": if(imageFound[35] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t35.filters = [thumbGlow];
								}
								break;
				case "img36": if(imageFound[36] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t36.filters = [thumbGlow];
								}
								break;
				case "img37": if(imageFound[37] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t37.filters = [thumbGlow];
								}
								break;
				case "img38": if(imageFound[38] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t38.filters = [thumbGlow];
								}
								break;
				case "img39": if(imageFound[39] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t39.filters = [thumbGlow];
								}
								break;
				case "img40": if(imageFound[40] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t40.filters = [thumbGlow];
								}
								break;
				case "img41": if(imageFound[41] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t41.filters = [thumbGlow];
								}
								break;
				case "img42": if(imageFound[42] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t42.filters = [thumbGlow];
								}
								break;
				case "img43": if(imageFound[43] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t43.filters = [thumbGlow];
								}
								break;
				case "img44": if(imageFound[44] == "yes"){
									//image was found don't glow the thumb
								}else{
							 		 t44.filters = [thumbGlow];
								}
								break;
				default: trace("image doesn't exist");
			}
		}
		
		public function playASparkle(flashDrive:MovieClip){
			var mc:MovieClip = MovieClip(flashDrive.parent);
			var sparkle:MovieClip = new stSparkle();
			mc.addChild(sparkle);
			sparkle.x = flashDrive.x;
			sparkle.y = flashDrive.y;
			sparkle.gotoAndPlay(0);
			flashDrive.visible = false;
		}
		
		
		public function containerClicked(evt:MouseEvent):void{
			//var newObject:Object = new findItemIcon();
			thumbCounter++; //thumb is placed increase the counter
			switch(evt.currentTarget.name){
				case "c00" : trace("c00 clicked");
							placeThumbs(t00);
							usedThumbs.push(t00);
							trace(thumbCounter);
							if(thumbCounter>8){
								autoShifting();
							}
							//pop an image into the thumbnail
							t00.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbOhISee.x = 0;
							allThumbs.thumbOhISee.y = 0;
							t00.thumbSet.addChild(allThumbs.thumbOhISee);
							playASparkle(MovieClip(evt.currentTarget));
							scene02.c00.visible = false;
							break;
				case "c01" : trace("c01 clicked");
							placeThumbs(t01);
							usedThumbs.push(t01);
							if(thumbCounter>8){
								autoShifting();
							}
							t01.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbChair.x = 0;
							allThumbs.thumbChair.y = 0;
							t01.thumbSet.addChild(allThumbs.thumbChair);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c02" : trace("c02 clicked");
							placeThumbs(t02);
							usedThumbs.push(t02);
							if(thumbCounter>8){
								autoShifting();
							}
							t02.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbMan.x = 0;
							allThumbs.thumbMan.y = 0;
							t02.thumbSet.addChild(allThumbs.thumbMan);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c03" : trace("c03 clicked");
							placeThumbs(t03);
							usedThumbs.push(t03);
							if(thumbCounter>8){
								autoShifting();
							}
							t03.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbLearn.x = 0;
							allThumbs.thumbLearn.y = 0;
							t03.thumbSet.addChild(allThumbs.thumbLearn);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c04" : trace("c04 clicked");
							placeThumbs(t04);
							usedThumbs.push(t04);
							if(thumbCounter>8){
								autoShifting();
							}
							t04.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbGirl.x = 0;
							allThumbs.thumbGirl.y = 0;
							t04.thumbSet.addChild(allThumbs.thumbGirl);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c05" : trace("c05 clicked");
							placeThumbs(t05);
							usedThumbs.push(t05);
							if(thumbCounter>8){
								autoShifting();
							}
							t05.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbSit.x = 0;
							allThumbs.thumbSit.y = 0;
							t05.thumbSet.addChild(allThumbs.thumbSit);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c06" : trace("c06 clicked");
							placeThumbs(t06);
							usedThumbs.push(t06);
							if(thumbCounter>8){
								autoShifting();
							}
							t06.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWindow.x = 0;
							allThumbs.thumbWindow.y = 0;
							t06.thumbSet.addChild(allThumbs.thumbWindow);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c07" : trace("c07 clicked");
							placeThumbs(t07);
							usedThumbs.push(t07);
							if(thumbCounter>8){
								autoShifting();
							}
							t07.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbLight.x = 0;
							allThumbs.thumbLight.y = 0;
							t07.thumbSet.addChild(allThumbs.thumbLight);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c08" : trace("c08 clicked");
							placeThumbs(t08);
							usedThumbs.push(t08);
							if(thumbCounter>8){
								autoShifting();
							}
							t08.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbDontKnow.x = 0;
							allThumbs.thumbDontKnow.y = 0;
							t08.thumbSet.addChild(allThumbs.thumbDontKnow);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c09" : trace("c09 clicked");
							placeThumbs(t09);
							usedThumbs.push(t09);
							if(thumbCounter>8){
								autoShifting();
							}
							t09.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbYes.x = 0;
							allThumbs.thumbYes.y = 0;
							t09.thumbSet.addChild(allThumbs.thumbYes);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c10" : trace("c10 clicked");
							placeThumbs(t10);
							usedThumbs.push(t10);
							if(thumbCounter>8){
								autoShifting();
							}
							t10.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWhere.x = 0;
							allThumbs.thumbWhere.y = 0;
							t10.thumbSet.addChild(allThumbs.thumbWhere);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c11" : trace("c11 clicked");
							placeThumbs(t11);
							usedThumbs.push(t11);
							if(thumbCounter>8){
								autoShifting();
							}
							t11.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbNo.x = 0;
							allThumbs.thumbNo.y = 0;
							t11.thumbSet.addChild(allThumbs.thumbNo);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c12" : trace("c12 clicked");
							placeThumbs(t12); //positions the thumbnails on the top bar
							usedThumbs.push(t12);
							if(thumbCounter>8){
								autoShifting();
							}
							t12.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbRight.x = 0;
							allThumbs.thumbRight.y = 0;
							t12.thumbSet.addChild(allThumbs.thumbRight);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c13" : trace("c13 clicked");
							placeThumbs(t13);
							usedThumbs.push(t13);
							if(thumbCounter>8){
								autoShifting();
							}
							t13.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbTeacher.x = 0;
							allThumbs.thumbTeacher.y = 0;
							t13.thumbSet.addChild(allThumbs.thumbTeacher);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c14" : trace("c14 clicked");
							placeThumbs(t14);
							usedThumbs.push(t14);
							if(thumbCounter>8){
								autoShifting();
							}
							t14.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWho.x = 0;
							allThumbs.thumbWho.y = 0;
							t14.thumbSet.addChild(allThumbs.thumbWho);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c15" : trace("c15 clicked");
							placeThumbs(t15);
							usedThumbs.push(t15);
							if(thumbCounter>8){
								autoShifting();
							}
							t15.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbBoy.x = 0;
							allThumbs.thumbBoy.y = 0;
							t15.thumbSet.addChild(allThumbs.thumbBoy);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c16" : trace("c16 clicked");
							placeThumbs(t16);
							usedThumbs.push(t16);
							if(thumbCounter>8){
								autoShifting();
							}
							t16.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbClass.x = 0;
							allThumbs.thumbClass.y = 0;
							t16.thumbSet.addChild(allThumbs.thumbClass);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c17" : trace("c17 clicked");
							placeThumbs(t17);
							usedThumbs.push(t17);
							if(thumbCounter>8){
								autoShifting();
							}
							t17.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbSameAs.x = 0;
							allThumbs.thumbSameAs.y = 0;
							t17.thumbSet.addChild(allThumbs.thumbSameAs);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c18" : trace("c18 clicked");
							placeThumbs(t18);
							usedThumbs.push(t18);
							if(thumbCounter>8){
								autoShifting();
							}
							t18.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbDeaf.x = 0;
							allThumbs.thumbDeaf.y = 0;
							t18.thumbSet.addChild(allThumbs.thumbDeaf);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c19" : trace("c19 clicked");
							placeThumbs(t19);
							usedThumbs.push(t19);
							if(thumbCounter>8){
								autoShifting();
							}
							t19.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbNot.x = 0;
							allThumbs.thumbNot.y = 0;
							t19.thumbSet.addChild(allThumbs.thumbNot);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c20" : trace("c20 clicked");
							placeThumbs(t20);
							usedThumbs.push(t20);
							if(thumbCounter>8){
								autoShifting();
							}
							t20.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbDoor.x = 0;
							allThumbs.thumbDoor.y = 0;
							t20.thumbSet.addChild(allThumbs.thumbDoor);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c21" : trace("c21 clicked");
							placeThumbs(t21);
							usedThumbs.push(t21);
							if(thumbCounter>8){
								autoShifting();
							}
							t21.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWoman.x = 0;
							allThumbs.thumbWoman.y = 0;
							t21.thumbSet.addChild(allThumbs.thumbWoman);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c22" : trace("c22 clicked");
							placeThumbs(t22);
							usedThumbs.push(t22);
							if(thumbCounter>8){
								autoShifting();
							}
							t22.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbOpen.x = 0;
							allThumbs.thumbOpen.y = 0;
							t22.thumbSet.addChild(allThumbs.thumbOpen);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c23" : trace("c23 clicked");
							placeThumbs(t23);
							usedThumbs.push(t23);
							if(thumbCounter>8){
								autoShifting();
							}
							t23.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWrong.x = 0;
							allThumbs.thumbWrong.y = 0;
							t23.thumbSet.addChild(allThumbs.thumbWrong);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c24" : trace("c24 clicked");
							placeThumbs(t24);
							usedThumbs.push(t24);
							if(thumbCounter>8){
								autoShifting();
							}
							t24.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbRemember.x = 0;
							allThumbs.thumbRemember.y = 0;
							t24.thumbSet.addChild(allThumbs.thumbRemember);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c25" : trace("c25 clicked");
							placeThumbs(t25);
							usedThumbs.push(t25);
							if(thumbCounter>8){
								autoShifting();
							}
							t25.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbStand.x = 0;
							allThumbs.thumbStand.y = 0;
							t25.thumbSet.addChild(allThumbs.thumbStand);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c26" : trace("c26 clicked");
							placeThumbs(t26);
							usedThumbs.push(t26);
							if(thumbCounter>8){
								autoShifting();
							}
							t26.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbTeach.x = 0;
							allThumbs.thumbTeach.y = 0;
							t26.thumbSet.addChild(allThumbs.thumbTeach);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c27" : trace("c27 clicked");
							placeThumbs(t27);
							usedThumbs.push(t27);
							if(thumbCounter>8){
								autoShifting();
							}
							t27.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbLearner.x = 0;
							allThumbs.thumbLearner.y = 0;
							t27.thumbSet.addChild(allThumbs.thumbLearner);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c28" : trace("c28 clicked");
							placeThumbs(t28);
							usedThumbs.push(t28);
							if(thumbCounter>8){
								autoShifting();
							}
							t28.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbHearing.x = 0;
							allThumbs.thumbHearing.y = 0;
							t28.thumbSet.addChild(allThumbs.thumbHearing);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c29" : trace("c29 clicked");
							placeThumbs(t29);
							usedThumbs.push(t29);
							if(thumbCounter>8){
								autoShifting();
							}
							t29.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbSpanish.x = 0;
							allThumbs.thumbSpanish.y = 0;
							t29.thumbSet.addChild(allThumbs.thumbSpanish);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c30" : trace("c30 clicked");
							placeThumbs(t30);
							usedThumbs.push(t30);
							if(thumbCounter>8){
								autoShifting();
							}
							t30.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbFrench.x = 0;
							allThumbs.thumbFrench.y = 0;
							t30.thumbSet.addChild(allThumbs.thumbFrench);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c31" : trace("c31 clicked");
							placeThumbs(t31);
							usedThumbs.push(t31);
							if(thumbCounter>8){
								autoShifting();
							}
							t31.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbKnow.x = 0;
							allThumbs.thumbKnow.y = 0;
							t31.thumbSet.addChild(allThumbs.thumbKnow);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c32" : trace("c32 clicked");
							placeThumbs(t32);
							usedThumbs.push(t32);
							if(thumbCounter>8){
								autoShifting();
							}
							t32.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbCollege.x = 0;
							allThumbs.thumbCollege.y = 0;
							t32.thumbSet.addChild(allThumbs.thumbCollege);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c33" : trace("c33 clicked");
							placeThumbs(t33);
							usedThumbs.push(t33);
							if(thumbCounter>8){
								autoShifting();
							}
							t33.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbOn.x = 0;
							allThumbs.thumbOn.y = 0;
							t33.thumbSet.addChild(allThumbs.thumbOn);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c34" : trace("c34 clicked");
							placeThumbs(t34);
							usedThumbs.push(t34);
							if(thumbCounter>8){
								autoShifting();
							}
							t34.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbCCC.x = 0;
							allThumbs.thumbCCC.y = 0;
							t34.thumbSet.addChild(allThumbs.thumbCCC);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c35" : trace("c35 clicked");
							placeThumbs(t35);
							usedThumbs.push(t35);
							if(thumbCounter>8){
								autoShifting();
							}
							t35.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbPSU.x = 0;
							allThumbs.thumbPSU.y = 0;
							t35.thumbSet.addChild(allThumbs.thumbPSU);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c36" : trace("c36 clicked");
							placeThumbs(t36);
							usedThumbs.push(t36);
							if(thumbCounter>8){
								autoShifting();
							}
							t36.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWOU.x = 0;
							allThumbs.thumbWOU.y = 0;
							t36.thumbSet.addChild(allThumbs.thumbWOU);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c37" : trace("c37 clicked");
							placeThumbs(t37);
							usedThumbs.push(t37);
							if(thumbCounter>8){
								autoShifting();
							}
							t37.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbSchool.x = 0;
							allThumbs.thumbSchool.y = 0;
							t37.thumbSet.addChild(allThumbs.thumbSchool);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c38" : trace("c38 clicked");
							placeThumbs(t38);
							usedThumbs.push(t38);
							if(thumbCounter>8){
								autoShifting();
							}
							t38.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbElementary.x = 0;
							allThumbs.thumbElementary.y = 0;
							t38.thumbSet.addChild(allThumbs.thumbElementary);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c39" : trace("c39 clicked");
							placeThumbs(t39);
							usedThumbs.push(t39);
							if(thumbCounter>8){
								autoShifting();
							}
							t39.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbHighSchool.x = 0;
							allThumbs.thumbHighSchool.y = 0;
							t39.thumbSet.addChild(allThumbs.thumbHighSchool);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c40" : trace("c40 clicked");
							placeThumbs(t40);
							usedThumbs.push(t40);
							if(thumbCounter>8){
								autoShifting();
							}
							t40.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbOff.x = 0;
							allThumbs.thumbOff.y = 0;
							t40.thumbSet.addChild(allThumbs.thumbOff);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c41" : trace("c41 clicked");
							placeThumbs(t41);
							usedThumbs.push(t41);
							if(thumbCounter>8){
								autoShifting();
							}
							t41.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbOSU.x = 0;
							allThumbs.thumbOSU.y = 0;
							t41.thumbSet.addChild(allThumbs.thumbOSU);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c42" : trace("c42 clicked");
							placeThumbs(t42);
							usedThumbs.push(t42);
							if(thumbCounter>8){
								autoShifting();
							}
							t42.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbClose.x = 0;
							allThumbs.thumbClose.y = 0;
							t42.thumbSet.addChild(allThumbs.thumbClose);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c43" : trace("c43 clicked");
							placeThumbs(t43);
							usedThumbs.push(t43);
							if(thumbCounter>8){
								autoShifting();
							}
							t43.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbSign.x = 0;
							allThumbs.thumbSign.y = 0;
							t43.thumbSet.addChild(allThumbs.thumbSign);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				case "c44" : trace("c44 clicked");
							placeThumbs(t44);
							usedThumbs.push(t44);
							if(thumbCounter>8){
								autoShifting();
							}
							t44.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbUniversity.x = 0;
							allThumbs.thumbUniversity.y = 0;
							t44.thumbSet.addChild(allThumbs.thumbUniversity);
							playASparkle(MovieClip(evt.currentTarget));
							break;
				default:
						trace("something broke while selecting container");
			}
		}
		
		public function placeThumbs(myMC:MovieClip){ //positions the thumbnails along the top
			if(firstContainerFlag){
				myMC.x = 42.25;
				myMC.y = 28.45;
				firstContainerFlag = false;
			}else{
				myMC.x = MovieClip(usedThumbs[usedThumbs.length-1]).x + 89.85;
				myMC.y = 28.45;
			}
		}
		
		public function autoShifting(){
			trace("shifting left");
			thumbLeft.visible = true;
			thumbRight.visible = true;
			if(rightPointer==0){ //first time the shift is called
				rightPointer = 7;
			}
			while(rightPointer<usedThumbs.length-1){
				MovieClip(usedThumbs[leftPointer]).x = -3000;
				leftPointer++;
				MovieClip(usedThumbs[leftPointer]).x = 42.25;
				MovieClip(usedThumbs[leftPointer+1]).x = 132.1;
				MovieClip(usedThumbs[leftPointer+2]).x = 221.95;
				MovieClip(usedThumbs[leftPointer+3]).x = 311.8;
				MovieClip(usedThumbs[leftPointer+4]).x = 401.65;
				MovieClip(usedThumbs[leftPointer+5]).x = 491.5;
				MovieClip(usedThumbs[leftPointer+6]).x = 581.35;
				MovieClip(usedThumbs[leftPointer+7]).x = 671.2;
				rightPointer++;
			}
			trace("finished shifting");
		}
		
		public function thumbClicked(evt:MouseEvent):void{
			videoPlay(MovieClip(evt.currentTarget));
			playMovies.nameVideo.submitTitle.text = MovieClip(evt.currentTarget).textSet.guessName.text;
		}
		
		public function videoPlay(objectMC:MovieClip){
			playMovies.visible = true;
			switch(objectMC.name){
				case "t00":
							videoURL = "videos/Unit2/unit02_w10_oh-i-see.flv"; trace(videoURL);
							g_curVid = "m00";
							currentMatchTarget = "img00";
							thumbSelection("img00");
							break;
				case "t01":
							videoURL = "videos/Unit2/unit02_w06_chair.flv"; trace(videoURL);
							g_curVid = "m01";
							currentMatchTarget = "img01";
							thumbSelection("img01");
							break;
				case "t02":
							videoURL = "videos/Unit2/unit02_w01_man.flv"; trace(videoURL);
							g_curVid = "m02";
							currentMatchTarget = "img02";
							thumbSelection("img02");
							break;
				case "t03":
							videoURL = "videos/Unit2/unit02_w08_learn.flv"; trace(videoURL);
							g_curVid = "m03";
							currentMatchTarget = "img03";
							thumbSelection("img03");
							break;
				case "t04":
							videoURL = "videos/Unit2/unit02_w27_girl.flv"; trace(videoURL);
							g_curVid = "m04";
							currentMatchTarget = "img04";
							thumbSelection("img04");
							break;
				case "t05":
							videoURL = "videos/Unit2/unit02_w19_sit.flv"; trace(videoURL);
							g_curVid = "m05";
							currentMatchTarget = "img05";
							thumbSelection("img05");
							break;
				case "t06":
							videoURL = "videos/Unit2/unit02_w17_window.flv"; trace(videoURL);
							g_curVid = "m06";
							currentMatchTarget = "img06";
							thumbSelection("img06");
							break;
				case "t07":
							videoURL = "videos/Unit2/unit02_w22_light.flv"; trace(videoURL);
							g_curVid = "m07";
							currentMatchTarget = "img07";
							thumbSelection("img07");
							break;
				case "t08":
							videoURL = "videos/Unit2/unit02_w36_dont-know.flv"; trace(videoURL);
							g_curVid = "m08";
							currentMatchTarget = "img08";
							thumbSelection("img08");
							break;
				case "t09":
							videoURL = "videos/Unit2/unit02_w16_yes.flv"; trace(videoURL);
							g_curVid = "m09";
							currentMatchTarget = "img09";
							thumbSelection("img09");
							break;
				case "t10":
							videoURL = "videos/Unit2/unit02_w05_where.flv"; trace(videoURL);
							g_curVid = "m10";
							currentMatchTarget = "img10";
							thumbSelection("img10");
							break;
				case "t11":
							videoURL = "videos/Unit2/unit02_w21_no.flv"; trace(videoURL);
							g_curVid = "m11";
							currentMatchTarget = "img11";
							thumbSelection("img11");
							break;
				case "t12":
							videoURL = "videos/Unit2/unit02_w26_right.flv"; trace(videoURL);
							g_curVid = "m12";
							currentMatchTarget = "img12";
							thumbSelection("img12");
							break;
				case "t13":
							videoURL = "videos/Unit2/unit02_w09_teacher.flv"; trace(videoURL);
							g_curVid = "m13";
							currentMatchTarget = "img13";
							thumbSelection("img13");
							break;
				case "t14":
							videoURL = "videos/Unit2/unit02_w11_who.flv"; trace(videoURL);
							g_curVid = "m14";
							currentMatchTarget = "img14";
							thumbSelection("img14");
							break;
				case "t15":
							videoURL = "videos/Unit2/unit02_w23_boy.flv"; trace(videoURL);
							g_curVid = "m15";
							currentMatchTarget = "img15";
							thumbSelection("img15");
							break;
				case "t16":
							videoURL = "videos/Unit2/unit02_w03_class.flv"; trace(videoURL);
							g_curVid = "m16";
							currentMatchTarget = "img16";
							thumbSelection("img16");
							break;
				case "t17":
							videoURL = "videos/Unit2/unit02_w14_same-as.flv"; trace(videoURL);
							g_curVid = "m17";
							currentMatchTarget = "img17";
							thumbSelection("img17");
							break;
				case "t18":
							videoURL = "videos/Unit2/unit02_w13_deaf.flv"; trace(videoURL);
							g_curVid = "m18";
							currentMatchTarget = "img18";
							thumbSelection("img18");
							break;
				case "t19":
							videoURL = "videos/Unit2/unit02_w04_not.flv"; trace(videoURL);
							g_curVid = "m19";
							currentMatchTarget = "img19";
							thumbSelection("img19");
							break;
				case "t20":
							videoURL = "videos/Unit2/unit02_w12_door.flv"; trace(videoURL);
							g_curVid = "m20";
							currentMatchTarget = "img20";
							thumbSelection("img20");
							break;
				case "t21":
							videoURL = "videos/Unit2/unit02_w07_woman.flv"; trace(videoURL);
							g_curVid = "m21";
							currentMatchTarget = "img21";
							thumbSelection("img21");
							break;
				case "t22":
							videoURL = "videos/Unit2/unit02_w28_open.flv"; trace(videoURL);
							g_curVid = "m22";
							currentMatchTarget = "img22";
							thumbSelection("img22");
							break;
				case "t23":
							videoURL = "videos/Unit2/unit02_w30_wrong.flv"; trace(videoURL);
							g_curVid = "m23";
							currentMatchTarget = "img23";
							thumbSelection("img23");
							break;
				case "t24":
							videoURL = "videos/Unit2/unit02_w39_remember.flv"; trace(videoURL);
							g_curVid = "m24";
							currentMatchTarget = "img24";
							thumbSelection("img24");
							break;
				case "t25":
							videoURL = "videos/Unit2/unit02_w24_stand.flv"; trace(videoURL);
							g_curVid = "m25";
							currentMatchTarget = "img25";
							thumbSelection("img25");
							break;
				case "t26":
							videoURL = "videos/Unit2/unit02_w02_teach.flv"; trace(videoURL);
							g_curVid = "m26";
							currentMatchTarget = "img26";
							thumbSelection("img26");
							break;
				case "t27":
							videoURL = "videos/Unit2/unit02_w15_learner(student).flv"; trace(videoURL);
							g_curVid = "m27";
							currentMatchTarget = "img27";
							thumbSelection("img27");
							break;
				case "t28":
							videoURL = "videos/Unit2/unit02_w18_hearing.flv"; trace(videoURL);
							g_curVid = "m28";
							currentMatchTarget = "img28";
							thumbSelection("img28");
							break;
				case "t29":
							videoURL = "videos/Unit2/unit02_w25_spanish.flv"; trace(videoURL);
							g_curVid = "m29";
							currentMatchTarget = "img29";
							thumbSelection("img29");
							break;
				case "t30":
							videoURL = "videos/Unit2/unit02_w29_french.flv"; trace(videoURL);
							g_curVid = "m30";
							currentMatchTarget = "img30";
							thumbSelection("img30");
							break;
				case "t31":
							videoURL = "videos/Unit2/unit02_w33_know.flv"; trace(videoURL);
							g_curVid = "m31";
							currentMatchTarget = "img31";
							thumbSelection("img31");
							break;
				case "t32":
							videoURL = "videos/Unit2/unit02_w35_college.flv"; trace(videoURL);
							g_curVid = "m32";
							currentMatchTarget = "img32";
							thumbSelection("img32");
							break;
				case "t33":
							videoURL = "videos/Unit2/unit02_w34_on.flv"; trace(videoURL);
							g_curVid = "m33";
							currentMatchTarget = "img33";
							thumbSelection("img33");
							break;
				case "t34":
							videoURL = "videos/Unit2/unit02_w43_ccc.flv"; trace(videoURL);
							g_curVid = "m34";
							currentMatchTarget = "img34";
							thumbSelection("img34");
							break;
				case "t35":
							videoURL = "videos/Unit2/unit02_w44_psu.flv"; trace(videoURL);
							g_curVid = "m35";
							currentMatchTarget = "img35";
							thumbSelection("img35");
							break;
				case "t36":
							videoURL = "videos/Unit2/unit02_w45_wou.flv"; trace(videoURL);
							g_curVid = "m36";
							currentMatchTarget = "img36";
							thumbSelection("img36");
							break;
				case "t37":
							videoURL = "videos/Unit2/unit02_w32_school.flv"; trace(videoURL);
							g_curVid = "m37";
							currentMatchTarget = "img37";
							thumbSelection("img37");
							break;
				case "t38":
							videoURL = "videos/Unit2/unit02_w40_elementary.flv"; trace(videoURL);
							g_curVid = "m38";
							currentMatchTarget = "img38";
							thumbSelection("img38");
							break;
				case "t39":
							videoURL = "videos/Unit2/unit02_w41_hs.flv"; trace(videoURL);
							g_curVid = "m39";
							currentMatchTarget = "img39";
							thumbSelection("img39");
							break;
				case "t40":
							videoURL = "videos/Unit2/unit02_w37_off.flv"; trace(videoURL);
							g_curVid = "m40";
							currentMatchTarget = "img40";
							thumbSelection("img40");
							break;
				case "t41":
							videoURL = "videos/Unit2/unit02_w42_osu.flv"; trace(videoURL);
							g_curVid = "m41";
							currentMatchTarget = "img41";
							thumbSelection("img41");
							break;
				case "t42":
							videoURL = "videos/Unit2/unit02_w31_close.flv"; trace(videoURL);
							g_curVid = "m42";
							currentMatchTarget = "img42";
							thumbSelection("img42");
							break;
				case "t43":
							videoURL = "videos/Unit2/unit02_w20_sign(language).flv"; trace(videoURL);
							g_curVid = "m43";
							currentMatchTarget = "img43";
							thumbSelection("img43");
							break;
				case "t44":
							videoURL = "videos/Unit2/unit02_w38_universtiy.flv"; trace(videoURL);
							g_curVid = "m44";
							currentMatchTarget = "img44";
							thumbSelection("img44");
							break;					
				default:
						trace("something went wrong when displaying the movie.");
							//videosInPlay.push(stFind01);
			}
			
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.connect(null);
		}
		
		public function connectStream():void { //tells flash to play a video
			//trace("connected");
			var stream:NetStream = new NetStream(connection);
			playMovies.addEventListener(KeyboardEvent.KEY_DOWN, enterKeyPressed);
			playMovies.submitVideo.addEventListener(MouseEvent.CLICK, movieComplete);
			playMovies.videoArea.addEventListener(MouseEvent.CLICK, replayVideo);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			video.attachNetStream(stream);
			video.width = playMovies.videoArea.width;
			video.height = playMovies.videoArea.height;
			playMovies.videoArea.addChild(video);
			stream.play(videoURL);
			
			function replayVideo(evt:MouseEvent):void { //loop the signing until the user hits submit
				stream.seek(0);
				stream.play(videoURL);
			}
			//stream.addEventListener(NetStatusEvent.NET_STATUS, loopPlay);
			
			function onMetaData(infoObject:Object):void 
			{ 
				// stub for callback function 
			}
			
			function enterKeyPressed(evt:KeyboardEvent):void{
				if(evt.keyCode == 13){
					playMovies.submitVideo.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				}
			}
			
			function movieComplete(evt:Event):void{ //closes the stream and exits the video
				playMovies.visible = false;
				video.clear();
				stream.close();
				SoundMixer.stopAll();
				//trace("tracing: "+g_curVid)
				switch(g_curVid){
					case "m00":
								t00.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[0] = t00.textSet.guessName.text;
								break;
					case "m01":
								t01.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[1] = t01.textSet.guessName.text;
								break;
					case "m02":
								t02.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[2] = t02.textSet.guessName.text;
								break;
					case "m03":
								t03.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[3] = t03.textSet.guessName.text;
								break;
					case "m04":
								t04.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[4] = t04.textSet.guessName.text;
								break;
					case "m05":
								t05.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[5] = t05.textSet.guessName.text;
								break;
					case "m06":
								t06.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[6] = t06.textSet.guessName.text;
								break;
					case "m07":
								t07.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[7] = t07.textSet.guessName.text;
								break;
					case "m08":
								t08.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[8] = t08.textSet.guessName.text;
								break;
					case "m09":
								t09.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[9] = t09.textSet.guessName.text;
								break;
					case "m10":
								t10.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[10] = t10.textSet.guessName.text;
								break;
					case "m11":
								t11.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[11] = t11.textSet.guessName.text;
								break;
					case "m12":
								t12.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[12] = t12.textSet.guessName.text;
								break;
					case "m13":
								t13.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[13] = t13.textSet.guessName.text;
								break;
					case "m14":
								t14.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[14] = t14.textSet.guessName.text;
								break;
					case "m15":
								t15.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[15] = t15.textSet.guessName.text;
								break;
					case "m16":
								t16.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[16] = t16.textSet.guessName.text;
								break;
					case "m17":
								t17.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[17] = t17.textSet.guessName.text;
								break;
					case "m18":
								t18.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[18] = t18.textSet.guessName.text;
								break;
					case "m19":
								t19.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[19] = t19.textSet.guessName.text;
								break;
					case "m20":
								t20.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[20] = t20.textSet.guessName.text;
								break;
					case "m21":
								t21.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[21] = t21.textSet.guessName.text;
								break;
					case "m22":
								t22.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[22] = t22.textSet.guessName.text;
								break;
					case "m23":
								t23.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[23] = t23.textSet.guessName.text;
								break;
					case "m24":
								t24.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[24] = t24.textSet.guessName.text;
								break;
					case "m25":
								t25.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[25] = t25.textSet.guessName.text;
								break;
					case "m26":
								t26.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[26] = t26.textSet.guessName.text;
								break;
					case "m27":
								t27.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[27] = t27.textSet.guessName.text;
								break;
					case "m28":
								t28.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[28] = t28.textSet.guessName.text;
								break;
					case "m29":
								t29.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[29] = t29.textSet.guessName.text;
								break;
					case "m30":
								t30.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[30] = t30.textSet.guessName.text;
								break;
					case "m31":
								t31.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[31] = t31.textSet.guessName.text;
								break;
					case "m32":
								t32.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[32] = t32.textSet.guessName.text;
								break;
					case "m33":
								t33.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[33] = t33.textSet.guessName.text;
								break;
					case "m34":
								t34.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[34] = t34.textSet.guessName.text;
								break;
					case "m35":
								t35.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[35] = t35.textSet.guessName.text;
								break;
					case "m36":
								t36.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[36] = t36.textSet.guessName.text;
								break;
					case "m37":
								t37.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[37] = t37.textSet.guessName.text;
								break;
					case "m38":
								t38.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[38] = t38.textSet.guessName.text;
								break;
					case "m39":
								t39.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[39] = t39.textSet.guessName.text;
								break;
					case "m40":
								t40.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[40] = t40.textSet.guessName.text;
								break;
					case "m41":
								t41.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[41] = t41.textSet.guessName.text;
								break;
					case "m42":
								t42.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[42] = t42.textSet.guessName.text;
								break;
					case "m43":
								t43.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[43] = t43.textSet.guessName.text;
								break;
					case "m44":
								t44.textSet.guessName.text = playMovies.nameVideo.submitTitle.text;
								thumbTypedWords[44] = t44.textSet.guessName.text;
								break;

					default:
								trace("movieComplete transfer failed");
				}
				
				
			}
			
		}
		
		function netStatusHandler(event:NetStatusEvent):void { //connect the video
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Unable to locate video: " + videoURL);
					break;
			}
		}
		
		public function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		public function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}
	
		
		public function LeftThumbedOver(evt:MouseEvent):void{
			if(leftThumbInvis){
				thumbLeft.leftA.gotoAndStop(3);
			}
		}
		
		public function RightThumbedOver(evt:MouseEvent):void{
			if(rightThumbInvis){
				thumbRight.rightA.gotoAndStop(3);
			}
		}
		
		public function LeftThumbedOut(evt:MouseEvent):void{
			if(leftThumbInvis){
				thumbLeft.leftA.gotoAndStop(2);
			}
		}
		
		public function RightThumbedOut(evt:MouseEvent):void{
			if(rightThumbInvis){
				thumbRight.rightA.gotoAndStop(2);
			}
		}
		
		public function shiftThumbsRight(evt:MouseEvent):void{
			trace("Shifting Right"); //pop the thumb on the left into a different place and shift images to the left
			if(thumbCounter<9){
				thumbRight.visible = false;
				rightThumbInvis = false;
			}else if(rightPointer<(usedThumbs.length-1)){
				thumbRight.visible = true;
				rightThumbInvis = true;
				MovieClip(usedThumbs[leftPointer]).x = -3000;
				leftPointer++;
				MovieClip(usedThumbs[leftPointer]).x = 42.25;
				MovieClip(usedThumbs[leftPointer+1]).x = 132.1;
				MovieClip(usedThumbs[leftPointer+2]).x = 221.95;
				MovieClip(usedThumbs[leftPointer+3]).x = 311.8;
				MovieClip(usedThumbs[leftPointer+4]).x = 401.65;
				MovieClip(usedThumbs[leftPointer+5]).x = 491.5;
				MovieClip(usedThumbs[leftPointer+6]).x = 581.35;
				MovieClip(usedThumbs[leftPointer+7]).x = 671.2;
				rightPointer++;
			}
		}
		
		public function shiftThumbsLeft(evt:MouseEvent):void{
			trace("Shifting Left"); //pop the thumb on the right into a different place and shift the images to the right
			if(thumbCounter<9){
				thumbLeft.visible = false;
				leftThumbInvis = false;
			}else if(leftPointer>0){
				thumbLeft.visible = true;
				leftThumbInvis = true;
				MovieClip(usedThumbs[rightPointer]).x = 3000;
				leftPointer--;
				rightPointer--;
				MovieClip(usedThumbs[leftPointer]).x = 42.25;
				MovieClip(usedThumbs[leftPointer+1]).x = 132.1;
				MovieClip(usedThumbs[leftPointer+2]).x = 221.95;
				MovieClip(usedThumbs[leftPointer+3]).x = 311.8;
				MovieClip(usedThumbs[leftPointer+4]).x = 401.65;
				MovieClip(usedThumbs[leftPointer+5]).x = 491.5;
				MovieClip(usedThumbs[leftPointer+6]).x = 581.35;
				MovieClip(usedThumbs[leftPointer+7]).x = 671.2;
			}
		}
		
		public function closeLid(evt:MouseEvent):void{
			evt.currentTarget.gotoAndStop(0);
		}
		
		public function openUp(evt:MouseEvent):void{
			evt.currentTarget.gotoAndPlay(1);
		}
		
		public function allEvents(){
			thumbLeft.visible = false;
			thumbRight.visible = false;
			thumbLeft.addEventListener(MouseEvent.CLICK, shiftThumbsLeft);
			thumbLeft.addEventListener(MouseEvent.MOUSE_OVER, LeftThumbedOver);
			thumbLeft.addEventListener(MouseEvent.MOUSE_OUT, LeftThumbedOut);
			thumbRight.addEventListener(MouseEvent.CLICK, shiftThumbsRight);
			thumbRight.addEventListener(MouseEvent.MOUSE_OVER, RightThumbedOver);
			thumbRight.addEventListener(MouseEvent.MOUSE_OUT, RightThumbedOut);
			instructBTN.addEventListener(MouseEvent.CLICK, instructionsOn); //instructions can no be clicked
			
			playMovies.nameVideo.submitTitle.addEventListener(MouseEvent.MOUSE_DOWN, clearText);
			scene01.c00.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene02.c00.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene12.c01.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene02.c02.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene12.c03.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene07.c04.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene04.c05.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene13.c06.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene13.c07.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c08.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c09.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c10.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene07.c11.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c12.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene13.c13.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c14.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene08.c15.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c16.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene09.c17.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene09.c18.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene17.c19.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene10.c20.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene03.c21.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene10.c22.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene16.c23.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene11.c24.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene11.c25.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene13.c26.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene13.c27.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c28.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c29.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c30.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene15.c31.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene15.c32.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene15.c33.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene13.c34.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene16.c35.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene17.c36.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene16.c37.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene15.c38.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene16.c39.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene17.c40.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene14.c41.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene17.c42.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene16.c43.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene16.c44.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			
			scene01.c00.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene02.c00.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene12.c01.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene02.c02.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene12.c03.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene07.c04.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene04.c05.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene13.c06.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene13.c07.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c08.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c09.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c10.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene07.c11.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c12.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene13.c13.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c14.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene08.c15.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c16.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene09.c17.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene09.c18.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene17.c19.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene10.c20.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene03.c21.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene10.c22.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene16.c23.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene11.c24.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene11.c25.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene13.c26.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene13.c27.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c28.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c29.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c30.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene15.c31.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene15.c32.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene15.c33.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene13.c34.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene16.c35.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene17.c36.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene16.c37.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene15.c38.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene16.c39.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene17.c40.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene14.c41.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene17.c42.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene16.c43.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			scene16.c44.addEventListener(MouseEvent.MOUSE_OVER, openUp);
			
			scene01.c00.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene02.c00.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene12.c01.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene02.c02.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene12.c03.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene07.c04.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene04.c05.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene13.c06.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene13.c07.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c08.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c09.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c10.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene07.c11.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c12.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene13.c13.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c14.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene08.c15.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c16.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene09.c17.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene09.c18.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene17.c19.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene10.c20.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene03.c21.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene10.c22.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene16.c23.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene11.c24.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene11.c25.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene13.c26.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene13.c27.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c28.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c29.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c30.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene15.c31.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene15.c32.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene15.c33.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene13.c34.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene16.c35.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene17.c36.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene16.c37.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene15.c38.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene16.c39.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene17.c40.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene14.c41.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene17.c42.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene16.c43.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			scene16.c44.addEventListener(MouseEvent.MOUSE_OUT, closeLid);
			
			scene01.img00.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img00.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img01.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img02.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img03.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene10.img04.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene04.img05.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img06.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img07.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene06.img08.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene06.img09.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene07.img10.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene07.img11.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene07.img12.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene08.img13.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene08.img14.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene08.img15.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene08.img16.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene09.img17.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene09.img18.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene10.img19.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene10.img20.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene03.img21.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene10.img22.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene10.img23.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene11.img24.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene11.img25.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene13.img26.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene13.img27.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene14.img28.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene14.img29.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene14.img30.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene15.img31.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene15.img32.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene15.img33.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene16.img34.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene16.img35.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene16.img36.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene17.img37.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene15.img38.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene17.img39.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene17.img40.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene18.img41.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene18.img42.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene18.img43.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene18.img44.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			
			scene01.img00.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img00.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img01.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img02.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img03.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene10.img04.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene04.img05.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img06.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img07.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene06.img08.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene06.img09.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene07.img10.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene07.img11.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene07.img12.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene08.img13.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene08.img14.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene08.img15.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene08.img16.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene09.img17.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene09.img18.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene10.img19.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene10.img20.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene03.img21.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene10.img22.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene10.img23.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene11.img24.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene11.img25.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene13.img26.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene13.img27.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene14.img28.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene14.img29.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene14.img30.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene15.img31.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene15.img32.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene15.img33.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene16.img34.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene16.img35.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene16.img36.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene17.img37.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene15.img38.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene17.img39.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene17.img40.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene18.img41.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene18.img42.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene18.img43.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene18.img44.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			
			scene01.img00.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img00.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img01.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img02.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img03.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene10.img04.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene04.img05.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img06.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img07.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene06.img08.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene06.img09.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene07.img10.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene07.img11.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene07.img12.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene08.img13.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene08.img14.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene08.img15.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene08.img16.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene09.img17.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene09.img18.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene10.img19.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene10.img20.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene03.img21.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene10.img22.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene10.img23.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene11.img24.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene11.img25.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene13.img26.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene13.img27.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene14.img28.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene14.img29.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene14.img30.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene15.img31.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene15.img32.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene15.img33.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene16.img34.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene16.img35.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene16.img36.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene17.img37.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene15.img38.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene17.img39.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene17.img40.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene18.img41.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene18.img42.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene18.img43.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene18.img44.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			
			scene01.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene02.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene03.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene04.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene05.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene07.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene08.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene10.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene11.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene13.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene14.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene15.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene18.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			
			scene03.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene04.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene05.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene06.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene07.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene08.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene09.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene10.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene11.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene12.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene13.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene14.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene15.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene15.goBack02.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene16.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene17.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene18.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene18.goBack02.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			
			scene04.moveOn02.addEventListener(MouseEvent.MOUSE_DOWN, gotoSceneSpecial01);
			scene08.moveOn02.addEventListener(MouseEvent.MOUSE_DOWN, gotoSceneSpecial01);
			scene11.moveOn02.addEventListener(MouseEvent.MOUSE_DOWN, gotoSceneSpecial01);
			scene14.moveOn02.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene15.moveOn02.addEventListener(MouseEvent.MOUSE_DOWN, gotoSceneSpecial01);
			
			scene15.moveOn03.addEventListener(MouseEvent.MOUSE_DOWN, gotoSceneSpecial02);
			scene14.moveOn03.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene14.moveOn04.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			
			scene01.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene02.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene03.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene04.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene05.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene07.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene08.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene10.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene11.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene13.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene14.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene15.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			//scene18.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene03.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene04.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene05.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene06.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene07.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene08.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene09.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene10.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene11.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene12.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene13.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene14.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene15.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene15.goBack02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene16.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene17.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene18.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene18.goBack02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene04.moveOn02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene08.moveOn02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene11.moveOn02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene14.moveOn02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene15.moveOn02.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene15.moveOn03.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene14.moveOn03.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene14.moveOn04.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			
			scene01.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene02.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene03.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene04.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene05.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene07.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene08.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene10.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene11.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene13.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene14.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene15.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			//scene18.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene03.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene04.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene05.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene06.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene07.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene08.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene09.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene10.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene11.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene12.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene13.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene14.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene15.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene15.goBack02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene16.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene17.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene18.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene18.goBack02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene04.moveOn02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene08.moveOn02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene11.moveOn02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene14.moveOn02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene15.moveOn02.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene15.moveOn03.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene14.moveOn03.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene14.moveOn04.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			
			scene18.moveOn.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene18.moveOn.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			
			startGame.blackFade.startScreen.goToCave.addEventListener(MouseEvent.MOUSE_DOWN, beginGame);
			startGame.blackFade.startScreen.goToCave.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			startGame.blackFade.startScreen.goToCave.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			instructions.instructOff.addEventListener(MouseEvent.MOUSE_DOWN, instructionsOff);
		}
		
		public function roundDecimal(num:Number, precision:int):Number{ //decimal formating
			var decimal:Number = Math.pow(10, precision);
			trace(" The real number is: "+num);
			return Math.round(decimal* num) / decimal;
		}
		
	}
	
}
