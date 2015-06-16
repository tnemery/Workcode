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
		var usedThumbs:Array = new Array(0);
		var firstContainerFlag:Boolean = true; //is this the first object clicked
		var thumbCounter:Number = 0; //count the number of thumbs currently on the stage, needed for shifting
		var leftPointer:Number = 0; //keeps track of the thumb currently on the left side
		var rightPointer:Number = 0; //keeps track of the thumb currently on the right side
		var thumbsOnStage:Number = 0; //keep track of the number of thumbs on the stage
		var currentMatchTarget:String = ""; //keeps track of the currently selected item to find
		var myGlow:GlowFilter = new GlowFilter(); //add a glow for objects
		var imageFound:Array = new Array("no","no","no","no","no","no","no","no","no",
										 "no","no","no","no","no","no","no","no");
		var thumbTypedWords:Array = new Array("","","","","","","","","","","","","",
											  "","","","");											  
		var realWordList:Array = new Array("me","who","copy me","name","you","what","forget","nice to meet you","IX(there)","where","not know","same","go to",
											  "different","write on","draw","put down");
		var currentPercent:Number;
		var myTimer:Timer = new Timer(1000);
		var rockWallBreakFlag:Boolean = true;

		public function ASL111iSpyV2() {
			// constructor code
			//scene03.rubble01.visible = false;
			//scene03.rubble02.visible = false;
			//scene03.rubble03.visible = false;
			blackFade.gotoAndStop(0);
			instructions.visible = false // default instructions are off
			playMovies.visible = false;
			gameOver.visible = false;
			thumbLeft.leftA.gotoAndStop(1);
			thumbRight.rightA.gotoAndStop(1);
			thumbLeft.addEventListener(MouseEvent.CLICK, shiftThumbsLeft);
			thumbLeft.addEventListener(MouseEvent.MOUSE_OVER, LeftThumbedOver);
			thumbLeft.addEventListener(MouseEvent.MOUSE_OUT, LeftThumbedOut);
			thumbRight.addEventListener(MouseEvent.CLICK, shiftThumbsRight);
			thumbRight.addEventListener(MouseEvent.MOUSE_OVER, RightThumbedOver);
			thumbRight.addEventListener(MouseEvent.MOUSE_OUT, RightThumbedOut);
			scene02.visible = false;
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
			
			
			playMovies.nameVideo.submitTitle.addEventListener(MouseEvent.MOUSE_DOWN, clearText);
			scene03.c00.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene06.c01.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene04.c02.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene05.c03.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene04.c04.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene02.c05.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene04.c06.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene04.c07.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene03.c08.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene02.c09.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene02.c10.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene03.c11.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene01.c12.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene03.c13.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene03.c14.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene05.c15.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			scene05.c16.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			
			scene03.c00.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene06.c01.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene04.c02.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene05.c03.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene04.c04.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene02.c05.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene04.c06.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene04.c07.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene03.c08.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene02.c09.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene02.c10.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene03.c11.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene01.c12.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene03.c13.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene03.c14.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene05.c15.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			scene05.c16.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			
			scene03.c00.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene06.c01.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene04.c02.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene05.c03.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene04.c04.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene02.c05.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene04.c06.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene04.c07.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene03.c08.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene02.c09.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene02.c10.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene03.c11.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene01.c12.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene03.c13.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene03.c14.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene05.c15.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			scene05.c16.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			
			//c17.addEventListener(MouseEvent.MOUSE_DOWN, containerClicked);
			
			scene03.c00.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.c08.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.c11.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.c13.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.c14.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.img00.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.img08.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			scene03.img11.addEventListener(MouseEvent.MOUSE_DOWN, breakRockWall);
			
			
			scene03.img00.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img01.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img02.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img03.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img04.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img05.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img06.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene04.img07.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene03.img08.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img09.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene02.img10.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene03.img11.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene01.img12.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img13.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img14.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img15.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			scene05.img16.addEventListener(MouseEvent.MOUSE_DOWN, checkImage);
			
			scene03.img00.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img01.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img02.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img03.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img04.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img05.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img06.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene04.img07.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene03.img08.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img09.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene02.img10.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene03.img11.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene01.img12.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img13.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img14.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img15.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			scene05.img16.addEventListener(MouseEvent.MOUSE_OVER, imageOver);
			
			scene03.img00.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img01.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img02.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img03.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img04.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img05.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img06.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene04.img07.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene03.img08.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img09.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene02.img10.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene03.img11.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene01.img12.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img13.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img14.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img15.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			scene05.img16.addEventListener(MouseEvent.MOUSE_OUT, imageOut);
			
			scene01.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene02.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene02.backToOne.addEventListener(MouseEvent.MOUSE_DOWN, gotoFirstScreen);
			scene04.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene05.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene06.moveOn.addEventListener(MouseEvent.MOUSE_DOWN, gotoNextScene);
			scene02.moveOn2.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene03.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene04.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene05.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			scene06.goBack.addEventListener(MouseEvent.MOUSE_DOWN, gotoPreviousScene);
			
			scene01.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene02.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene04.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene05.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene06.moveOn.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene02.moveOn2.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene02.backToOne.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene03.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene04.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene05.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			scene06.goBack.addEventListener(MouseEvent.MOUSE_OVER, nextScreenFadeIn);
			
			scene01.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene02.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene02.backToOne.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene04.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene05.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene06.moveOn.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene02.moveOn2.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene03.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene04.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene05.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			scene06.goBack.addEventListener(MouseEvent.MOUSE_OUT, nextScreenFadeOut);
			
			startGame.goToCave.addEventListener(MouseEvent.MOUSE_DOWN, beginGame);
			startGame.goToCave.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			startGame.goToCave.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			instructions.instructOff.addEventListener(MouseEvent.MOUSE_DOWN, instructionsOff);	
			myTimer.start();
		}
		
		public function scaleBtnUp(evt:MouseEvent):void{
			evt.currentTarget.scaleX += .1;
			evt.currentTarget.scaleY += .1;
		}
		
		public function scaleBtnDown(evt:MouseEvent):void{
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
			startGame.visible = false;
			blackFade.gotoAndPlay(0);
			instructBTN.addEventListener(MouseEvent.CLICK, instructionsOn); //instructions can no be clicked
		}
		
		public function instructionsOff(evt:MouseEvent):void{
			instructions.visible = false;
		}
		public function instructionsOn(evt:MouseEvent):void{
			instructions.visible = true;
		}
		
		public function breakRockWall(evt:MouseEvent):void{
			if(rockWallBreakFlag){
				scene03.rubble01.visible = true;
				scene03.rubble02.visible = true;
				scene03.rubble03.visible = true;
				scene03.rubble01.gotoAndPlay(0);
				scene03.rubble02.gotoAndPlay(0);
				scene03.rubble03.gotoAndPlay(0);
				rockWallBreakFlag = false;
			}
			scene02.rockWall.visible = false;
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
			currentPercent+= (thumbCounter*1.9607);
			for(var imageCheck:int=0;imageCheck<imageFound.length;imageCheck++){
				if(imageFound[imageCheck] == "yes"){
					currentPercent += 1.9607;
					trace("image check True");
				}
			}
			for(var wordCheck:int=0;wordCheck<realWordList.length;wordCheck++){
				if(thumbTypedWords[wordCheck] == realWordList[wordCheck]){
					currentPercent += 1.9607;
					trace("word check True");
				}
			}
			currentPercent = roundDecimal(currentPercent,2);
			if(currentPercent >= 99.9){
				currentPercent = 100;
			}
			gameOver.score.text = String(currentPercent)+"%";
			gameOver.wordList.addColumn("Your Word");
			gameOver.wordList.addColumn("Actual Word");
			gameOver.wordList.addColumn("Image Found");
			gameOver.disksFound.text = String(thumbCounter)+"/17";
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[0],"Actual Word":"me","Image Found":imageFound[0]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[1],"Actual Word":"who","Image Found":imageFound[1]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[2],"Actual Word":"copy me","Image Found":imageFound[2]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[3],"Actual Word":"name","Image Found":imageFound[3]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[4],"Actual Word":"you","Image Found":imageFound[4]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[5],"Actual Word":"what","Image Found":imageFound[5]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[6],"Actual Word":"forget","Image Found":imageFound[6]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[7],"Actual Word":"nice to meet you","Image Found":imageFound[7]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[8],"Actual Word":"IX(there)","Image Found":imageFound[8]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[9],"Actual Word":"where","Image Found":imageFound[9]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[10],"Actual Word":"not know","Image Found":imageFound[10]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[11],"Actual Word":"same","Image Found":imageFound[11]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[12],"Actual Word":"go to","Image Found":imageFound[12]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[13],"Actual Word":"different","Image Found":imageFound[13]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[14],"Actual Word":"write on","Image Found":imageFound[14]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[15],"Actual Word":"draw","Image Found":imageFound[15]});
			gameOver.wordList.addItem({"Your Word":thumbTypedWords[16],"Actual Word":"put down","Image Found":imageFound[16]});
		}
		
		public function gotoNextScene(evt:MouseEvent):void{
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
				/*case "scene06" : //this will only have a go back to S5
								scene05.visible = false;
								scene06.visible = true;
								break; */
				case "scene07" : //double scene -> S3, S8
								scene07.visible = false;
								scene08.visible = true;
								break;
				case "scene08" : //double scene S9, S10
								scene08.visible = false;
								scene10.visible = true;
								break;
				/*case "scene09" : //Just goes back to S8
								scene05.visible = false;
								scene06.visible = true;
								break; */
				case "scene10" :
								scene10.visible = false;
								scene11.visible = true;
								break;
				case "scene11" : //double scene S12, S13
								scene11.visible = false;
								scene13.visible = true;
								break;
				/*case "scene12" : //only goes back to S11
								scene05.visible = false;
								scene06.visible = true;
								break; */
				case "scene13" :
								scene13.visible = false;
								scene14.visible = true;
								break;
				case "scene14" :
								scene14.visible = false;
								scene15.visible = true;
								break;
				case "scene15" : //triple scene -> S16, S17, S18
								scene05.visible = false;
								scene06.visible = true;
								break;
				/*case "scene16" : //These only go back to S15
								scene05.visible = false;
								scene06.visible = true;
								break;
				case "scene17" :
								scene05.visible = false;
								scene06.visible = true;
								break; */
				case "scene18" : //need to make some kind of exit from S18
								setupGameOver();
								blackFade.visible = true;
								blackFade.gotoAndPlay(0);
								gameOver.visible = true; //works but not set up yet
								break; 
				default:
						trace("scene does not exist");
			}
		}
		
		public function gotoPreviousScene(evt:MouseEvent):void{
			trace(evt.currentTarget.parent.name);
			switch(evt.currentTarget.parent.name){
				case "scene02" :
								scene02.visible = false;
								scene04.visible = true;
								break;
				case "scene03" :
								scene03.visible = false;
								scene02.visible = true;
								break;
				case "scene04" :
								scene04.visible = false;
								scene02.visible = true;
								break;
				case "scene05" :
								scene05.visible = false;
								scene04.visible = true;
								break;
				case "scene06" :
								scene06.visible = false;
								scene05.visible = true;
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
			}
		}
		
		public function setImage(correctImage:Object){
			switch(correctImage.name){
				case "img00":  	scene03.img00.x = 0;
								scene03.img00.y = 0;
								scene03.img00.width = 82;
								scene03.img00.height = 61;
								t00.thumbSet.addChild(scene03.img00);
								imageFound[0] = "yes";
								scene03.img00.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img01":  	scene05.img01.x = 0;
								scene05.img01.y = 0;
								scene05.img01.width = 82;
								scene05.img01.height = 61;
								t01.thumbSet.addChild(scene05.img01);
								imageFound[1] = "yes";
								scene05.img01.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img02":  	scene05.img02.x = 0;
								scene05.img02.y = 0;
								scene05.img02.width = 82;
								scene05.img02.height = 61;
								t02.thumbSet.addChild(scene05.img02);
								imageFound[2] = "yes";
								scene05.img02.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img03":  	scene05.img03.x = 0;
								scene05.img03.y = 0;
								scene05.img03.width = 82;
								scene05.img03.height = 61;
								t03.thumbSet.addChild(scene05.img03);
								imageFound[3] = "yes";
								scene05.img03.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img04":  	scene05.img04.x = 0;
								scene05.img04.y = 0;
								scene05.img04.width = 82;
								scene05.img04.height = 61;
								t04.thumbSet.addChild(scene05.img04);
								imageFound[4] = "yes";
								scene05.img04.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img05":  	scene02.img05.x = 0;
								scene02.img05.y = 0;
								scene02.img05.width = 82;
								scene02.img05.height = 61;
								t05.thumbSet.addChild(scene02.img05);
								imageFound[5] = "yes";
								scene02.img05.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img06":  	scene05.img06.x = 0;
								scene05.img06.y = 0;
								scene05.img06.width = 82;
								scene05.img06.height = 61;
								t06.thumbSet.addChild(scene05.img06);
								imageFound[6] = "yes";
								scene05.img06.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img07":  	scene04.img07.x = 0;
								scene04.img07.y = 0;
								scene04.img07.width = 82;
								scene04.img07.height = 61;
								t07.thumbSet.addChild(scene04.img07);
								imageFound[7] = "yes";
								scene04.img07.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img08":   scene03.img08.x = 0;
								scene03.img08.y = 0;
								scene03.img08.width = 82;
								scene03.img08.height = 61;
								t08.thumbSet.addChild(scene03.img08);
								imageFound[8] = "yes";
								scene03.img08.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img09":   scene02.img09.x = 0;
								scene02.img09.y = 0;
								scene02.img09.width = 82;
								scene02.img09.height = 61;
								t09.thumbSet.addChild(scene02.img09);
								imageFound[9] = "yes";
								scene02.img09.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img10":   scene02.img10.x = 0;
								scene02.img10.y = 0;
								scene02.img10.width = 82;
								scene02.img10.height = 61;
								t10.thumbSet.addChild(scene02.img10);
								imageFound[10] = "yes";
								scene02.img10.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img11":  	scene03.img11.x = 0;
								scene03.img11.y = 0;
								scene03.img11.width = 82;
								scene03.img11.height = 61;
								t11.thumbSet.addChild(scene03.img11);
								imageFound[11] = "yes";
								scene03.img11.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img12": 	scene01.img12.x = 0;
								scene01.img12.y = 0;
								scene01.img12.width = 82;
								scene01.img12.height = 61;
								t12.thumbSet.addChild(scene01.img12);
								imageFound[12] = "yes";
								scene01.img12.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img13":  	scene05.img13.x = 0;
								scene05.img13.y = 0;
								scene05.img13.width = 82;
								scene05.img13.height = 61;
								t13.thumbSet.addChild(scene05.img13);
								imageFound[13] = "yes";
								scene05.img13.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img14":  	scene05.img14.x = 0;
								scene05.img14.y = 0;
								scene05.img14.width = 82;
								scene05.img14.height = 61;
								t14.thumbSet.addChild(scene05.img14);
								imageFound[14] = "yes";
								scene05.img14.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img15":  	scene05.img15.x = 0;
								scene05.img15.y = 0;
								scene05.img15.width = 82;
								scene05.img15.height = 61;
								t15.thumbSet.addChild(scene05.img15);
								imageFound[15] = "yes";
								scene05.img15.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img16":  	scene05.img16.x = 0;
								scene05.img16.y = 0;
								scene05.img16.width = 82;
								scene05.img16.height = 61;
								t16.thumbSet.addChild(scene05.img16);
								imageFound[16] = "yes";
								scene05.img16.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img17": //t17.thumbSet.addChild(scene03.img17);
								break;
				default: trace("the image was lost, cannot place in the thumb");
			}
		}
		
		public function thumbSelection(item:String){
			t00.thumbSelected.visible = false;
			t01.thumbSelected.visible = false;
			t02.thumbSelected.visible = false;
			t03.thumbSelected.visible = false;
			t04.thumbSelected.visible = false;
			t05.thumbSelected.visible = false;
			t06.thumbSelected.visible = false;
			t07.thumbSelected.visible = false;
			t08.thumbSelected.visible = false;
			t09.thumbSelected.visible = false;
			t10.thumbSelected.visible = false;
			t11.thumbSelected.visible = false;
			t12.thumbSelected.visible = false;
			t13.thumbSelected.visible = false;
			t14.thumbSelected.visible = false;
			t15.thumbSelected.visible = false;
			t16.thumbSelected.visible = false;
			t17.thumbSelected.visible = false;
			switch(item){
				case "img00": t00.thumbSelected.visible = true;
								break;
				case "img01": t01.thumbSelected.visible = true;
								break;
				case "img02": t02.thumbSelected.visible = true;
								break;
				case "img03": t03.thumbSelected.visible = true;
								break;
				case "img04": t04.thumbSelected.visible = true;
								break;
				case "img05": t05.thumbSelected.visible = true;
								break;
				case "img06": t06.thumbSelected.visible = true;
								break;
				case "img07": t07.thumbSelected.visible = true;
								break;
				case "img08": t08.thumbSelected.visible = true;
								break;
				case "img09": t09.thumbSelected.visible = true;
								break;
				case "img10": t10.thumbSelected.visible = true;
								break;
				case "img11": t11.thumbSelected.visible = true;
								break;
				case "img12": t12.thumbSelected.visible = true;
								break;
				case "img13": t13.thumbSelected.visible = true;
								break;
				case "img14": t14.thumbSelected.visible = true;
								break;
				case "img15": t15.thumbSelected.visible = true;
								break;
				case "img16": t16.thumbSelected.visible = true;
								break;
				case "img17": t17.thumbSelected.visible = true;
								break;
				default: trace("image doesn't exist");
			}
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
							allThumbs.thumbMe.x = 0;
							allThumbs.thumbMe.y = 0;
							t00.thumbSet.addChild(allThumbs.thumbMe);
							scene03.c00.sparkle.gotoAndPlay(0);
							break;
				case "c01" : trace("c01 clicked");
							placeThumbs(t01);
							usedThumbs.push(t01);
							if(thumbCounter>8){
								autoShifting();
							}
							t01.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWho.x = 0;
							allThumbs.thumbWho.y = 0;
							t01.thumbSet.addChild(allThumbs.thumbWho);
							scene06.c01.sparkle.gotoAndPlay(0);
							break;
				case "c02" : trace("c02 clicked");
							placeThumbs(t02);
							usedThumbs.push(t02);
							if(thumbCounter>8){
								autoShifting();
							}
							t02.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbCopyMe.x = 0;
							allThumbs.thumbCopyMe.y = 0;
							t02.thumbSet.addChild(allThumbs.thumbCopyMe);
							scene04.c02.sparkle.gotoAndPlay(0);
							break;
				case "c03" : trace("c03 clicked");
							placeThumbs(t03);
							usedThumbs.push(t03);
							if(thumbCounter>8){
								autoShifting();
							}
							t03.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbName.x = 0;
							allThumbs.thumbName.y = 0;
							t03.thumbSet.addChild(allThumbs.thumbName);
							scene05.c03.sparkle.gotoAndPlay(0);
							break;
				case "c04" : trace("c04 clicked");
							placeThumbs(t04);
							usedThumbs.push(t04);
							if(thumbCounter>8){
								autoShifting();
							}
							t04.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbYou.x = 0;
							allThumbs.thumbYou.y = 0;
							t04.thumbSet.addChild(allThumbs.thumbYou);
							scene04.c04.sparkle.gotoAndPlay(0);
							break;
				case "c05" : trace("c05 clicked");
							placeThumbs(t05);
							usedThumbs.push(t05);
							if(thumbCounter>8){
								autoShifting();
							}
							t05.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWhat.x = 0;
							allThumbs.thumbWhat.y = 0;
							t05.thumbSet.addChild(allThumbs.thumbWhat);
							scene02.c05.sparkle.gotoAndPlay(0);
							break;
				case "c06" : trace("c06 clicked");
							placeThumbs(t06);
							usedThumbs.push(t06);
							if(thumbCounter>8){
								autoShifting();
							}
							t06.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbForget.x = 0;
							allThumbs.thumbForget.y = 0;
							t06.thumbSet.addChild(allThumbs.thumbForget);
							scene04.c06.sparkle.gotoAndPlay(0);
							break;
				case "c07" : trace("c07 clicked");
							placeThumbs(t07);
							usedThumbs.push(t07);
							if(thumbCounter>8){
								autoShifting();
							}
							t07.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbNiceMeet.x = 0;
							allThumbs.thumbNiceMeet.y = 0;
							t07.thumbSet.addChild(allThumbs.thumbNiceMeet);
							scene04.c07.sparkle.gotoAndPlay(0);
							break;
				case "c08" : trace("c08 clicked");
							placeThumbs(t08);
							usedThumbs.push(t08);
							if(thumbCounter>8){
								autoShifting();
							}
							t08.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbThere.x = 0;
							allThumbs.thumbThere.y = 0;
							t08.thumbSet.addChild(allThumbs.thumbThere);
							scene03.c08.sparkle.gotoAndPlay(0);
							break;
				case "c09" : trace("c09 clicked");
							placeThumbs(t09);
							usedThumbs.push(t09);
							if(thumbCounter>8){
								autoShifting();
							}
							t09.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWhere.x = 0;
							allThumbs.thumbWhere.y = 0;
							t09.thumbSet.addChild(allThumbs.thumbWhere);
							scene02.c09.sparkle.gotoAndPlay(0);
							break;
				case "c10" : trace("c10 clicked");
							placeThumbs(t10);
							usedThumbs.push(t10);
							if(thumbCounter>8){
								autoShifting();
							}
							t10.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbNotKnow.x = 0;
							allThumbs.thumbNotKnow.y = 0;
							t10.thumbSet.addChild(allThumbs.thumbNotKnow);
							scene02.c10.sparkle.gotoAndPlay(0);
							break;
				case "c11" : trace("c11 clicked");
							placeThumbs(t11);
							usedThumbs.push(t11);
							if(thumbCounter>8){
								autoShifting();
							}
							t11.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbSame.x = 0;
							allThumbs.thumbSame.y = 0;
							t11.thumbSet.addChild(allThumbs.thumbSame);
							scene03.c11.sparkle.gotoAndPlay(0);
							break;
				case "c12" : trace("c12 clicked");
							placeThumbs(t12); //positions the thumbnails on the top bar
							usedThumbs.push(t12);
							if(thumbCounter>8){
								autoShifting();
							}
							t12.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbGoTo.x = 0;
							allThumbs.thumbGoTo.y = 0;
							t12.thumbSet.addChild(allThumbs.thumbGoTo);
							scene01.c12.sparkle.gotoAndPlay(0);
							break;
				case "c13" : trace("c13 clicked");
							placeThumbs(t13);
							usedThumbs.push(t13);
							if(thumbCounter>8){
								autoShifting();
							}
							t13.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbDifferent.x = 0;
							allThumbs.thumbDifferent.y = 0;
							t13.thumbSet.addChild(allThumbs.thumbDifferent);
							scene03.c13.sparkle.gotoAndPlay(0);
							break;
				case "c14" : trace("c14 clicked");
							placeThumbs(t14);
							usedThumbs.push(t14);
							if(thumbCounter>8){
								autoShifting();
							}
							t14.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbWriteOn.x = 0;
							allThumbs.thumbWriteOn.y = 0;
							t14.thumbSet.addChild(allThumbs.thumbWriteOn);
							scene03.c14.sparkle.gotoAndPlay(0);
							break;
				case "c15" : trace("c15 clicked");
							placeThumbs(t15);
							usedThumbs.push(t15);
							if(thumbCounter>8){
								autoShifting();
							}
							t15.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbDraw.x = 0;
							allThumbs.thumbDraw.y = 0;
							t15.thumbSet.addChild(allThumbs.thumbDraw);
							scene05.c15.sparkle.gotoAndPlay(0);
							break;
				case "c16" : trace("c16 clicked");
							placeThumbs(t16);
							usedThumbs.push(t16);
							if(thumbCounter>8){
								autoShifting();
							}
							t16.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
							allThumbs.thumbPutDown.x = 0;
							allThumbs.thumbPutDown.y = 0;
							t16.thumbSet.addChild(allThumbs.thumbPutDown);
							scene05.c16.sparkle.gotoAndPlay(0);
							break;
				case "c17" : trace("c17 clicked");
							placeThumbs(t17);
							usedThumbs.push(t17);
							if(thumbCounter>8){
								autoShifting();
							}
							t17.addEventListener(MouseEvent.MOUSE_DOWN, thumbClicked);
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
							videoURL = "videos/Unit1/unit01_w01_me.flv"; trace(videoURL);
							g_curVid = "m00";
							currentMatchTarget = "img00";
							thumbSelection("img00");
							break;
				case "t01":
							videoURL = "videos/Unit1/unit01_w02_who.flv"; trace(videoURL);
							g_curVid = "m01";
							currentMatchTarget = "img01";
							thumbSelection("img01");
							break;
				case "t02":
							videoURL = "videos/Unit1/unit01_w03_copy-me.flv"; trace(videoURL);
							g_curVid = "m02";
							currentMatchTarget = "img02";
							thumbSelection("img02");
							break;
				case "t03":
							videoURL = "videos/Unit1/unit01_w04_name.flv"; trace(videoURL);
							g_curVid = "m03";
							currentMatchTarget = "img03";
							thumbSelection("img03");
							break;
				case "t04":
							videoURL = "videos/Unit1/unit01_w05_you.flv"; trace(videoURL);
							g_curVid = "m04";
							currentMatchTarget = "img04";
							thumbSelection("img04");
							break;
				case "t05":
							videoURL = "videos/Unit1/unit01_w06_what.flv"; trace(videoURL);
							g_curVid = "m05";
							currentMatchTarget = "img05";
							thumbSelection("img05");
							break;
				case "t06":
							videoURL = "videos/Unit1/unit01_w07_forget.flv"; trace(videoURL);
							g_curVid = "m06";
							currentMatchTarget = "img06";
							thumbSelection("img06");
							break;
				case "t07":
							videoURL = "videos/Unit1/unit01_w08_nice-meet-you.flv"; trace(videoURL);
							g_curVid = "m07";
							currentMatchTarget = "img07";
							thumbSelection("img07");
							break;
				case "t08":
							videoURL = "videos/Unit1/unit01_w09_IX(there).flv"; trace(videoURL);
							g_curVid = "m08";
							currentMatchTarget = "img08";
							thumbSelection("img08");
							break;
				case "t09":
							videoURL = "videos/Unit1/unit01_w10_where.flv"; trace(videoURL);
							g_curVid = "m09";
							currentMatchTarget = "img09";
							thumbSelection("img09");
							break;
				case "t10":
							videoURL = "videos/Unit1/unit01_w11_not-know.flv"; trace(videoURL);
							g_curVid = "m10";
							currentMatchTarget = "img10";
							thumbSelection("img10");
							break;
				case "t11":
							videoURL = "videos/Unit1/unit01_w12_same.flv"; trace(videoURL);
							g_curVid = "m11";
							currentMatchTarget = "img11";
							thumbSelection("img11");
							break;
				case "t12":
							videoURL = "videos/Unit1/unit01_w13_go-to.flv"; trace(videoURL);
							g_curVid = "m12";
							currentMatchTarget = "img12";
							thumbSelection("img12");
							break;
				case "t13":
							videoURL = "videos/Unit1/unit01_w14_different.flv"; trace(videoURL);
							g_curVid = "m13";
							currentMatchTarget = "img13";
							thumbSelection("img13");
							break;
				case "t14":
							videoURL = "videos/Unit1/unit01_w15_write-on.flv"; trace(videoURL);
							g_curVid = "m14";
							currentMatchTarget = "img14";
							thumbSelection("img14");
							break;
				case "t15":
							videoURL = "videos/Unit1/unit01_w16_draw.flv"; trace(videoURL);
							g_curVid = "m15";
							currentMatchTarget = "img15";
							thumbSelection("img15");
							break;
				case "t16":
							videoURL = "videos/Unit1/unit01_w17_put-down.flv"; trace(videoURL);
							g_curVid = "m16";
							currentMatchTarget = "img16";
							thumbSelection("img16");
							break;
				case "t17":
							videoURL = "videos/Unit1/unit01_w17_put-down.flv"; trace(videoURL);
							g_curVid = "m17";
							currentMatchTarget = "img17";
							thumbSelection("img17");
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
			thumbLeft.leftA.gotoAndStop(3);
		}
		
		public function RightThumbedOver(evt:MouseEvent):void{
			thumbRight.rightA.gotoAndStop(3);
		}
		
		public function LeftThumbedOut(evt:MouseEvent):void{
			//add something t oswitch between white and grey when other thumbs are off stage (white when this is clickable
			thumbLeft.leftA.gotoAndStop(2);
		}
		
		public function RightThumbedOut(evt:MouseEvent):void{
			thumbRight.rightA.gotoAndStop(2);
		}
		
		public function shiftThumbsRight(evt:MouseEvent):void{
			trace("Shifting Right"); //pop the thumb on the left into a different place and shift images to the left
			if(thumbCounter<9){
				//don't shift at all
			}else if(rightPointer<(usedThumbs.length-1)){
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
				//don't shift at all
			}else if(leftPointer>0){
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
		
		public function objectClicked(){ //film cases, will be an event
			//add a thumbnail to the strip on top
		}
		
		public function objectMatch(){ //pictures on the stage, will be an event
			//determine if the selected film matches the image clicked
		}
		
		public function roundDecimal(num:Number, precision:int):Number{ //decimal formating
			var decimal:Number = Math.pow(10, precision);
			trace(" The real number is: "+num);
			return Math.round(decimal* num) / decimal;
		}
		
	}
	
}
