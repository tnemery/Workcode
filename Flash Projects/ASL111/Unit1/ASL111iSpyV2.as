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
import com.greensock.plugins.TweenPlugin;
import com.greensock.TweenMax;
import com.greensock.plugins.ShakeEffect;

	public class ASL111iSpyV2 extends MovieClip{
		
		var videoURL:String;
		var g_curVid:String;
		var connection:NetConnection;
		var stream:NetStream;
		var video:Video = new Video();
		var usedThumbs:Array = new Array(0);
		var firstContainerFlag:Boolean = true; //is this the first object clicked
		var thumbCounter:Number = 0; //count the number of thumbs currently on the stage, needed for shifting
		var leftPointer:Number = 0; //keeps track of the thumb currently on the left side
		var rightPointer:Number = 0; //keeps track of the thumb currently on the right side
		var currentMatchTarget:String = ""; //keeps track of the currently selected item to find
		var myGlow:GlowFilter = new GlowFilter(0x00FF00,1,6,6,10,1); //add a glow for objects
		var thumbGlow:GlowFilter = new GlowFilter(0xFFFF00,1,6,6,2,15,false,false); //add a glow for Thumbs
		var thumbGlowWrong:GlowFilter = new GlowFilter(0xFF0000,1,6,6,2,15,false,false); //add a glow for Thumbs
		var imageFound:Array = new Array("no","no","no","no","no","no","no","no","no",
										 "no","no","no","no","no","no","no","no");
		var thumbTypedWords:Array = new Array("","","","","","","","","","","","","",
											  "","","","");											  
		var realWordList:Array = new Array("me","who","copy me","name","you","what","forget","nice to meet you","IX(there)","where","not know","same","go to",
											  "different","write on","draw","put down");
		var currentPercent:Number;
		var myTimer:Timer = new Timer(1000);
		var rockWallBreakFlag:Boolean = true;
		var labWallBreakFlag:Boolean = true;

		public function ASL111iSpyV2() {
			// constructor code
			scene03.rubble01.visible = false;
			scene03.rubble02.visible = false;
			scene03.rubble03.visible = false;
			scene03.rubble04.visible = false;
			scene03.rubble05.visible = false;
			scene03.rubble06.visible = false;
			scene03.rubble07.visible = false;
			scene03.rubble08.visible = false;
			scene03.rubble09.visible = false;
			scene03.rubble10.visible = false;
			scene03.rubble11.visible = false;
			//startGame.blackFade.visible = false;
			instructions.visible = false // default instructions are off
			playMovies.visible = false;
			gameOver.visible = false;
			thumbLeft.leftA.gotoAndStop(1);
			thumbRight.rightA.gotoAndStop(1);
			scene02.visible = false;
			scene03.visible = false;
			scene04.visible = false;
			scene05.visible = false;
			scene06.visible = false;
			TweenPlugin.activate([ShakeEffect]); //activate the shake effect
			addEvents(); //adds all the listeners
			
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
			startGame.blackFade.gotoAndPlay(2);
			startGame.blackFade.gotoAndPlay(2);
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
				scene03.rubble04.visible = true;
				scene03.rubble05.visible = true;
				scene03.rubble06.visible = true;
				scene03.rubble07.visible = true;
				scene03.rubble08.visible = true;
				scene03.rubble09.visible = true;
				scene03.rubble10.visible = true;
				scene03.rubble11.visible = true;
				scene03.rubble01.gotoAndPlay(0);
				scene03.rubble02.gotoAndPlay(0);
				scene03.rubble03.gotoAndPlay(0);
				scene03.rubble04.gotoAndPlay(0);
				scene03.rubble05.gotoAndPlay(0);
				scene03.rubble06.gotoAndPlay(0);
				scene03.rubble07.gotoAndPlay(0);
				scene03.rubble08.gotoAndPlay(0);
				scene03.rubble09.gotoAndPlay(0);
				scene03.rubble10.gotoAndPlay(0);
				scene03.rubble11.gotoAndPlay(0);
				rockWallBreakFlag = false;
				TweenMax.to(scene03, 1, {shake:{x:25, y:0, numShakes:15} });
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
			//trace(myTimer.currentCount+" seconds");
			currentPercent = 0;
			currentPercent+= (thumbCounter*2.94);
			for(var imageCheck:int=0;imageCheck<imageFound.length;imageCheck++){
				if(imageFound[imageCheck] == "yes"){
					currentPercent += 2.94;
					trace("image check True");
				}
			}
			currentPercent = roundDecimal(currentPercent,2);
			if(currentPercent >= 99.9){
				currentPercent = 100;
			}//Time bonus, if you finish in 4 minutes or less your score does not change
			trace("currentCount is: "+ myTimer.currentCount);
			if(myTimer.currentCount >= 301 && myTimer.currentCount <= 360){
				currentPercent -= 10; 
				
			}else if(myTimer.currentCount >= 361 && myTimer.currentCount <= 420){
				currentPercent -= 20;
			}else if(myTimer.currentCount >= 421 && myTimer.currentCount <= 480){
				currentPercent -= 30;
			}else if(myTimer.currentCount >= 481 && myTimer.currentCount <= 540){
				currentPercent -= 40;
			}else if(myTimer.currentCount >= 541){
				currentPercent -= 50;
			}
			gameOver.blackFade.gameOver.timeLoss.text = convertTime();
			gameOver.blackFade.gameOver.score.text = String(Math.round(currentPercent*100)/100);
			gameOver.blackFade.gameOver.wordList.addColumn("Your Word");
			gameOver.blackFade.gameOver.wordList.addColumn("Actual Word");
			gameOver.blackFade.gameOver.wordList.addColumn("Object Matched");
			gameOver.blackFade.gameOver.disksFound.text = String(thumbCounter)+"/17";
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[0],"Actual Word":"me","Object Matched":imageFound[0]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[1],"Actual Word":"who","Object Matched":imageFound[1]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[2],"Actual Word":"copy me","Object Matched":imageFound[2]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[3],"Actual Word":"name","Object Matched":imageFound[3]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[4],"Actual Word":"you","Object Matched":imageFound[4]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[5],"Actual Word":"what","Object Matched":imageFound[5]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[6],"Actual Word":"forget","Object Matched":imageFound[6]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[7],"Actual Word":"nice to meet you","Object Matched":imageFound[7]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[8],"Actual Word":"IX(there)","Object Matched":imageFound[8]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[9],"Actual Word":"where","Object Matched":imageFound[9]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[10],"Actual Word":"not know","Object Matched":imageFound[10]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[11],"Actual Word":"same","Object Matched":imageFound[11]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[12],"Actual Word":"go to","Object Matched":imageFound[12]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[13],"Actual Word":"different","Object Matched":imageFound[13]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[14],"Actual Word":"write on","Object Matched":imageFound[14]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[15],"Actual Word":"draw","Object Matched":imageFound[15]});
			gameOver.blackFade.gameOver.wordList.addItem({"Your Word":thumbTypedWords[16],"Actual Word":"put down","Object Matched":imageFound[16]});
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
				case "scene04" :
								scene04.visible = false;
								scene05.visible = true;
								break;
				case "scene05" :
								scene05.visible = false;
								scene06.visible = true;
								break;
				case "scene06" :
								gameOver.visible = true; //goes to the game over screen with a fade in/out
								gameOver.blackFade.gotoAndPlay(0);
								setupGameOver();
								break;
				default:
						trace("scene does not exist");
			}
		}
		
		public function breakLabWall(evt:MouseEvent):void{
			if(labWallBreakFlag){
				labWallBreakFlag = false;
				TweenMax.to(scene05, 1, {shake:{x:25, y:0, numShakes:15} });
				TweenMax.to(scene05.labWall, 1, {shake:{x:0, y:-25, numShakes:15} });
			}
			scene05.labWall.visible = false;
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
								scene03.rubble01.visible = false;
								scene03.rubble02.visible = false;
								scene03.rubble03.visible = false;
								scene03.rubble04.visible = false;
								scene03.rubble05.visible = false;
								scene03.rubble06.visible = false;
								scene03.rubble07.visible = false;
								scene03.rubble08.visible = false;
								scene03.rubble09.visible = false;
								scene03.rubble10.visible = false;
								scene03.rubble11.visible = false;
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
			if(playMovies.nameVideo.submitTitle.text == "Click Me"){
				playMovies.nameVideo.submitTitle.text = "";
			}
		}
		
		public function checkImage(evt:MouseEvent){
			if(evt.currentTarget.name == currentMatchTarget){
				trace(evt.currentTarget.name);
				setImage(evt.currentTarget);
			}else{
				evt.currentTarget.filters = [thumbGlowWrong];
			}
		}
		
		public function setImage(correctImage:Object){
			switch(correctImage.name){
				case "img00":  	scene03.img00.visible = false;
								t00.img00.visible = true;
								imageFound[0] = "yes";
								t00.filters = [];
								scene03.img00.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img01":  scene05.img01.visible = false;
								t01.img01.visible = true;
								imageFound[1] = "yes";
								t01.filters = [];
								scene05.img01.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img02":  scene05.img02.visible = false;
								t02.img02.visible = true;
								imageFound[2] = "yes";
								t02.filters = [];
								scene05.img02.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img03":  	scene05.img03.visible = false;
								t03.img03.visible = true;
								imageFound[3] = "yes";
								t03.filters = [];
								scene05.img03.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img04":   scene05.img04.visible = false;
								t04.img04.visible = true;
								imageFound[4] = "yes";
								t04.filters = [];
								scene05.img04.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img05":  scene02.img05.visible = false;
								t05.img05.visible = true;
								imageFound[5] = "yes";
								t05.filters = [];
								scene02.img05.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img06":   scene05.img06.visible = false;
								t06.img06.visible = true;
								imageFound[6] = "yes";
								t06.filters = [];
								scene05.img06.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img07":  	scene04.img07.visible = false;
								t07.img07.visible = true;
								imageFound[7] = "yes";
								t07.filters = [];
								scene04.img07.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img08":   scene03.img08.visible = false;
								t08.img08.visible = true;
								imageFound[8] = "yes";
								t08.filters = [];
								scene03.img08.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img09":   scene02.img09.visible = false;
								t09.img09.visible = true;
								imageFound[9] = "yes";
								t09.filters = [];
								scene02.img09.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img10":   scene02.img10.visible = false;
								t10.img10.visible = true;
								imageFound[10] = "yes";
								t10.filters = [];
								scene02.img10.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img11":  	scene03.img11.visible = false;
								t11.img11.visible = true;
								imageFound[11] = "yes";
								t11.filters = [];
								scene03.img11.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img12": 	scene01.img12.visible = false;
								t12.img12.visible = true;
								imageFound[12] = "yes";
								t12.filters = []; //remove the glow since the img is correct
								scene01.img12.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img13":  	scene05.img13.visible = false;
								t13.img13.visible = true;
								imageFound[13] = "yes";
								t13.filters = [];
								scene05.img13.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img14":  	scene05.img14.visible = false;
								t14.img14.visible = true;
								imageFound[14] = "yes";
								t14.filters = [];
								scene05.img14.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img15":  	scene05.img15.visible = false;
								t15.img15.visible = true;
								imageFound[15] = "yes";
								t15.filters = [];
								scene05.img15.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img16":  	scene05.img16.visible = false;
								t16.img16.visible = true;
								imageFound[16] = "yes";
								t16.filters = [];
								scene05.img16.removeEventListener(MouseEvent.MOUSE_OVER, imageOver);
								break;
				case "img17": //t17.thumbSet.addChild(scene03.img17);
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
				case "img17": 
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
							scene03.c00.realDisk.visible = false;
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
							scene06.c01.realDisk.visible = false;
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
							scene04.c02.realDisk.visible = false;
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
							scene05.c03.realDisk.visible = false;
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
							scene04.c04.realDisk.visible = false;
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
							scene02.c05.realDisk.visible = false;
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
							scene04.c06.realDisk.visible = false;
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
							scene04.c07.realDisk.visible = false;
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
							scene03.c08.realDisk.visible = false;
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
							scene02.c09.realDisk.visible = false;
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
							scene02.c10.realDisk.visible = false;
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
							scene03.c11.realDisk.visible = false;
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
							scene01.c12.realDisk.visible = false;
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
							scene03.c13.realDisk.visible = false;
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
							scene03.c14.realDisk.visible = false;
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
							scene05.c15.realDisk.visible = false;
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
							scene05.c16.realDisk.visible = false;
							scene05.c16.sparkle.gotoAndPlay(0);
							break;
				case "c17" : break;
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
		
		public function addEvents(){
			thumbLeft.addEventListener(MouseEvent.CLICK, shiftThumbsLeft);
			thumbLeft.addEventListener(MouseEvent.MOUSE_OVER, LeftThumbedOver);
			thumbLeft.addEventListener(MouseEvent.MOUSE_OUT, LeftThumbedOut);
			thumbRight.addEventListener(MouseEvent.CLICK, shiftThumbsRight);
			thumbRight.addEventListener(MouseEvent.MOUSE_OVER, RightThumbedOver);
			thumbRight.addEventListener(MouseEvent.MOUSE_OUT, RightThumbedOut); 
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
			scene05.c03.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.c15.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.c16.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img01.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img02.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img03.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img04.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img06.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img13.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img14.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img15.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			scene05.img16.addEventListener(MouseEvent.MOUSE_DOWN, breakLabWall);
			
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
			
			startGame.blackFade.goToCave.addEventListener(MouseEvent.MOUSE_DOWN, beginGame);
			startGame.blackFade.goToCave.addEventListener(MouseEvent.MOUSE_OVER, scaleBtnUp);
			startGame.blackFade.goToCave.addEventListener(MouseEvent.MOUSE_OUT, scaleBtnDown);
			instructions.instructOff.addEventListener(MouseEvent.MOUSE_DOWN, instructionsOff);	
		}
		
		public function roundDecimal(num:Number, precision:int):Number{ //decimal formating
			var decimal:Number = Math.pow(10, precision);
			trace(" The real number is: "+num);
			return Math.round(decimal* num) / decimal;
		}
		
	}
	
}
