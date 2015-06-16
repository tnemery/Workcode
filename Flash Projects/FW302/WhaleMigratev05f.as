/******************************************
Oregon State University Extended Campus 
-Designed and Written by: Warren Blyth, Thomas Emery
.created: March 23, 2011   ?? When did you make this
.approved: 
.delivered: 

- The non game version of a whale migration over 2 years.
- Displays 2 female whales, a calf, and a male whale.
- Displays the path each whale takes over the course of 2 years
- Larger map shows the whale positions and names of places they are passing
- Tabbed window shows states for each of the whales, can be clicked to draw arrow to the whale
- Slider allows the movement between the years to show whale positions

To Do:
- create data sets for second female, male, and calf
- label and create a better large map representation
*******************************************/






package{
import fl.motion.Animator;
import fl.motion.*;
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
	
//place stDotFemale1 and stDotCalf into movieclip, easily apply click handler to all of them?	
	
public class WhaleMigratev05f extends MovieClip{
	var xmlLoader:URLLoader = new URLLoader();
	var xmlData:XML;
	var calfPath:Animator; //used for various paths
	var firstFemalePath:Animator;
	var malePath:Animator;
	var allXML1:XML;
	var allXMLFromExcel:XML;
	
	var segmentX:Number;
	var segmentY:Number;
	var frameCount:int; //do not exceed a certain number of frames
	
	var playFlag:Boolean = false;
	var stopFlag:Boolean = false;
	var slowTimer:int = 0;
	var playIndex:int = 0;
	var videoPlaying:int = 0;
	
	var myrequest:URLRequest=new URLRequest ("9-N_Canb.swf"); //toss these into a function with a switch
	var myloader:Loader = new Loader();
	
	var myVideo:FLVPlayback = new FLVPlayback();
	var videoURL:String;
    var connection:NetConnection;
    var stream:NetStream;
	var video:Video = new Video();

	var infoFlag:Boolean = false;
	var Circle:MovieClip = new MovieClip();
	var Circle2:MovieClip = new MovieClip();
	var drawingLine:MovieClip = new MovieClip();
	var drawingLine2:MovieClip = new MovieClip();
	var calendarValue:int = 0;
	
	var allDataArray:Array = new Array(0, 16, 30, 44, 58, 72, 86, 100, 114, 128, 142, 156, 170, 184, 198, 212, 224, 238, 252,
										266, 280, 294, 308, 322, 336, 350, 364, 380, 392, 406, 420, 434, 448, 462,
										476, 490, 504, 518, 532, 546, 560, 574, 588, 602, 616, 630, 644, 658, 672,
										686, 700, 714, 734, 748, 762, 776, 790, 804, 818, 832, 846, 860, 874, 888,
										902, 916, 930, 944, 956, 970, 984, 998, 1012, 1026, 1040, 1054, 1068, 1082, 1096,
										1110, 1124, 1138, 1152, 1166, 1180, 1194, 1208, 1222, 1236, 1250, 1264, 1278, 1292, 1306,
										1320, 1334, 1348, 1362, 1376, 1390, 1404, 1418);
	
	public function WhaleMigratev05f(){
		//slider controls
		whaleFemale.visible = false;
		stSlider.setSize(430,10);
		stSlider.minimum = 1;// slider starts at 1
		stSlider.maximum = 102;//slider ends at 102
		stSlider.tickInterval = 430/102;
		stSlider.liveDragging = true;
		populateXML();
		
		LoadXML();
		stSlider.addEventListener(Event.ENTER_FRAME, updateStats);
		stSlider.addEventListener(Event.CHANGE, stopAll);
		stSlider.addEventListener(Event.CHANGE, stopInfo);
		instruBtn.addEventListener(MouseEvent.MOUSE_DOWN, startOver);
		stPlayButton.addEventListener(MouseEvent.MOUSE_DOWN, playAll);
		stStopButton.addEventListener(MouseEvent.MOUSE_DOWN, stopAll);
		stSlider.addEventListener(Event.ENTER_FRAME,bLine);

		Calendar.gotoAndStop(0);
		whaleFemale.gotoAndStop(0);
		IceFlow.gotoAndStop(0);
		whaleFemale.visible = true;
		
		Circle.graphics.beginFill(0xff0000); //drawing a circle
		Circle.graphics.drawCircle(0,0,5);
		Circle.graphics.endFill();
		Circle.x = 0;
		Circle.y = stSlider.value;
		Circle2.graphics.beginFill(0xff0000); //drawing a circle
		Circle2.graphics.drawCircle(0,0,5);
		Circle2.graphics.endFill();
		Circle2.x = 0;
		Circle2.y = stSlider.value;
		drawingLine.graphics.lineStyle(1, 0xDE26E0); //drawing the first line that will follow the circle
		drawingLine2.graphics.lineStyle(1, 0x55B754); //drawing the first line that will follow the circle
		Circle.visible = false;
		Circle2.visible = false;
		createGraph();
		//loader controls
		loadBar.visible = false;
		loadText.visible = false;
		border.visible = false;
		stExitVideo.visible = false;
		stVideoPlay.visible = false;
		stVideoStop.visible = false;
		stFullScreen.visible = false;
		stSeekBar.visible = false;
		stBlackOut.alpha = .5;
		stBlackOut.visible = false;
		stStopButton.visible = false;
		stVideoCaptions.visible = false;
		stPlayVideo.addEventListener(MouseEvent.MOUSE_DOWN, loading); 
		
		
		video01.addEventListener(MouseEvent.MOUSE_DOWN, loading); //att listeners to all of the videos
		video02.addEventListener(MouseEvent.MOUSE_DOWN, loading);
		video03.addEventListener(MouseEvent.MOUSE_DOWN, loading);
		video04.addEventListener(MouseEvent.MOUSE_DOWN, loading);
		video05.addEventListener(MouseEvent.MOUSE_DOWN, loading);
		video06.addEventListener(MouseEvent.MOUSE_DOWN, loading);
		
		
	} //end WhaleMigrate
	
	function startOver(e:Event):void{
		Calendar.gotoAndStop(0);
		whaleFemale.gotoAndStop(0);
		IceFlow.gotoAndStop(0);
		infoFlag = false;
		Calendar.infoBubble.visible = true;
		stopAll(e);
		stSlider.value = 1;
	}
	
	
	
	function stopInfo(evt:Event):void { //turns off the info
		infoFlag = true
	}
	
	
	function MovieShift(){
		if(stSlider.value >=36 && stSlider.value <= 37 || stSlider.value >=82 && stSlider.value <= 83){
			setMovie(1);
		}
		if(stSlider.value >= 38 && stSlider.value <= 45 || stSlider.value >=84 && stSlider.value <= 86){
			setMovie(2);
		}
		if(stSlider.value >= 70 && stSlider.value <=75){
			setMovie(3);
		}
		if(stSlider.value >= 10 && stSlider.value <= 13){
			setMovie(4);
		}
		if(stSlider.value >= 14 && stSlider.value <= 20){
			setMovie(6);
		}
		if(stSlider.value >= 65 && stSlider.value <= 69){
			setMovie(9);
		}
	}
	
	
	function setMovie(movieNumber:int){ //will be used to switch out movie clips
		switch(movieNumber){
			case 1: videoURL = "Videos/1-ChukchuFeeding_shortened.flv"; trace("video 1 loaded");
					stVideoCaptions.text = "Chukchu Feeding (Press Play)";
					break;
			case 2: videoURL = "Videos/2-summer_poop.flv"; trace("video 2 loaded");
					stVideoCaptions.text = "Summer Poop (Press Play)";
					break;
			case 3: videoURL = "Videos/3-CA_coast_sb.flv"; trace("video 3 loaded");
					stVideoCaptions.text = "CA Coast (Press Play)";
					break;
			case 4: videoURL = "Videos/4-winter_lagoon_neonate.flv"; trace("video 4 loaded");
					stVideoCaptions.text = "Winter Lagoon Neonate (Press play)";
					break;
			case 6: videoURL = "Videos/6-lagoon_tourists.flv"; trace("video 6 loaded");
					stVideoCaptions.text = "Lagoon Tourists (Press Play)";
					break;
			case 9: videoURL = "Videos/9-courting.flv";  trace("video 9 loaded");
					stVideoCaptions.text = "Courting (Press Play)";
					break;
			default:
					break;
		}
	}
	
	//place movie clips onto stage, use something to determine which movie is being loaded/played
	function loading(e:Event):void{ //need to fix the loader
		switch(e.currentTarget.name){
			case "video01": setMovie(1);
							break;
			case "video02": setMovie(2);
							break;
			case "video03": setMovie(3);
							break;
			case "video04": setMovie(4);
							break;
			case "video05": setMovie(6);
							break;
			case "video06": setMovie(9);
							break;
		}
		//MovieShift();
		stopAll(e); //stop the slider
		stBlackOut.visible = false;
		connection = new NetConnection();
        connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        connection.connect(null);
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
	
	private function connectStream():void {
		stVideoPlay.addEventListener(MouseEvent.MOUSE_DOWN, playVideo);
		stVideoStop.addEventListener(MouseEvent.MOUSE_DOWN, stopVideo);
		stFullScreen.addEventListener(MouseEvent.MOUSE_DOWN, fullScreenMode);
		stExitVideo.addEventListener(MouseEvent.MOUSE_DOWN, movieComplete);
		
		var stream:NetStream = new NetStream(connection);
		stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
		stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
		video.addEventListener(Event.ENTER_FRAME, progressLoader);
		video.attachNetStream(stream);
		addChild(video);
		//stream.play(videoURL);
		
		
		stBlackOut.visible = true; //video controls
		stExitVideo.visible = true;
		stVideoPlay.visible = true;
		stVideoStop.visible = true;
		stFullScreen.visible = true; 
		stVideoCaptions.visible = true
		video.x = 150;
		video.y = 125;
		
		function progressLoader(evt:Event):void{
			var total:Number = stream.bytesTotal;
			var loaded:Number = stream.bytesLoaded;
			loadBar.visible = true;
			loadText.visible = true;
			border.visible = true;
			loadBar.scaleX = loaded/total;
			loadText.text = Math.floor((loaded/total)*100)+"%";
			
			if (total == loaded){
				loadBar.visible = false;
				loadText.visible = false;
				border.visible = false;
				stream.play(videoURL);
				stream.pause();
				video.removeEventListener(Event.ENTER_FRAME, progressLoader);
			}
		}
		
		
		function playVideo(evt:Event):void{ //internal functions for the play and pause buttons
			stream.resume();
		}
		
		function stopVideo(evt:Event):void{
			stream.pause();
		}
		
		function fullScreenMode(evt:Event):void{
			var screenRectangle:Rectangle = new Rectangle(video.x, video.y, video.width, video.height); 
            stage.fullScreenSourceRect = screenRectangle; 
            stage.displayState = StageDisplayState.FULL_SCREEN; 
		}
	
		function onMetaData(infoObject:Object):void 
        { 
            // stub for callback function 
        }
		
		function movieComplete(evt:Event):void{ //closes the stream and exits the video
		//use a key or some way of exiting and closing the movies
		stBlackOut.visible = false;
		stExitVideo.visible = false;
		stVideoPlay.visible = false;
		stVideoStop.visible = false;
		stFullScreen.visible = false;
		stVideoCaptions.visible = false;
		video.clear();
		stream.close();
		SoundMixer.stopAll();
		//removeChild(video);
	}
		
	}

	private function securityErrorHandler(event:SecurityErrorEvent):void {
		trace("securityErrorHandler: " + event);
	}
	
	private function asyncErrorHandler(event:AsyncErrorEvent):void {
		// ignore AsyncErrorEvent events.
	}

	public function LoadXML():void{
		xmlData = allXML1;
	}	
	
	function stopAll(evt:Event){
		stopFlag = true; //creates the stop action
		stPlayButton.visible = true;
		stStopButton.visible = false;
	}	
	
	
	function togglePopUpVideo(){
		video01.alpha = .5;
		video02.alpha = .5;
		video03.alpha = .5;
		video04.alpha = .5;
		video05.alpha = .5;
		video06.alpha = .5;
		if(stSlider.value >=36 && stSlider.value <= 37){
			video01.alpha = .1;
		}
		if(stSlider.value >= 82 && stSlider.value <= 83){
			video01.alpha = .1;
		}
		if(stSlider.value >= 38 && stSlider.value <= 45){
			video02.alpha = .1;
		}
		if(stSlider.value >= 84 && stSlider.value <= 86){
			video02.alpha = .1;
		}
		if(stSlider.value >= 70 && stSlider.value <= 75){
			video03.alpha = .1;
		}
		if(stSlider.value >= 10 && stSlider.value <= 13){
			video04.alpha = .1;
		}
		if(stSlider.value >= 14 && stSlider.value <= 20){
			video05.alpha = .1;
		}
		if(stSlider.value >= 65 && stSlider.value <= 69){
			video06.alpha = .1
		}	
	}
	
	
	
	/*
		find start position = slidervalue to array
		increment the calender
		when the frame on the calendar = the next number in the array of data increment the slider
	*/
	
	function playAll(evt:Event){ //recursive solution to the auto play feature, stop added, do I need rewind ability?
		slowTimer++;
		stPlayButton.visible = false;
		stStopButton.visible = true;
		if(playFlag == false){ //makes the event start if this is the first time the function is called after play is hit
			Calendar.gotoAndStop(allDataArray[stSlider.value-1]);
			femaleWhale.gotoAndStop(allDataArray[stSlider.value-1]);
			maleWhale.gotoAndStop(allDataArray[stSlider.value-1]);
			WhaleCalf.gotoAndStop(allDataArray[stSlider.value-1]);
			IceFlow.gotoAndStop(allDataArray[stSlider.value-1]);
			playIndex = allDataArray[stSlider.value-1]; 
			addEventListener(Event.ENTER_FRAME, playAll);
			playFlag = true;
			stopFlag = false;
		}
		//if(slowTimer%2 ==0){ //adjust this to speed-up/slow-down the speed of play  *note: use this for toggle button
			playIndex++;
			Calendar.gotoAndStop(playIndex);
			femaleWhale.gotoAndStop(playIndex);
			maleWhale.gotoAndStop(playIndex);
			WhaleCalf.gotoAndStop(playIndex);
			IceFlow.gotoAndStop(playIndex);
		//}
		if(stopFlag == true) //makes the function stop if the stop button is hit while playing
		{
			removeEventListener(Event.ENTER_FRAME,playAll);
			playFlag = false;
			stStopButton.visible = false;
			stPlayButton.visible = true;
		}
		if(stSlider.value < stSlider.maximum && playIndex == allDataArray[stSlider.value]) //increments the slider and moves the whales
		{
			stSlider.value+=1;
			//whaleMoved(evt);
		}
		else if(stSlider.value == stSlider.maximum){ //stops the event when it reaches the end of the slider
			removeEventListener(Event.ENTER_FRAME,playAll);
			playFlag = false;
			slowTimer = 0; //resets the timer so that it isn't counting forever to speed up processing time
		}
	}

	
	public function RandomNumber(low:Number=NaN, high:Number=NaN):Number{ //returns random number in between
	 var low:Number = low;
	 var high:Number = high;
	  if(isNaN(low)) // if "is Not a Number"
	  {	throw new Error("low must be defined");
	  }
	  if(isNaN(high))
	  {	throw new Error("high must be defined");
	  }
	  return Math.round(Math.random() * (high - low)) + low;
	}
	
	//* future graph details/functions:
	
	//taken functions from st201 coin flip, will edit for appropriate use of whales graph
	public function bLine(event){//makes the blue line follow the slider position
		blueLine.x = stSlider.x;
		if(stSlider.value > 1){
			blueLine.x = stSlider.x + stSlider.value*(430/102);
		}
		traceGraph();
	}
	
	
	function createGraph(){ //draw the graph first trace it during run, prevents missed points
		for(var index:int =0;index<102;index++){
			if(stSlider.value == 1){ //set the start position of the whale girth
				drawingLine.graphics.moveTo(stSlider.value*(430/102),allXMLFromExcel.Whaledata[stSlider.value-1].bodyG * (-100) -30);
			}
			drawingLine.graphics.lineTo((stSlider.value*(430/102)), allXMLFromExcel.Whaledata[stSlider.value-1].bodyG * (-100) -30);
			if(stSlider.value == 10){ //starting place for the calf graph based off mass data
				drawingLine2.graphics.moveTo(stSlider.value*(430/102),((945/100)*2)*(-1));
			}
			if(stSlider.value >= 10 && stSlider.value <=36){
				drawingLine2.graphics.lineTo(stSlider.value*(430/102), (allXMLFromExcel.Whaledata[stSlider.value-1].cmass/100*2)*(-1));
			}
			stSlider.value++;
		}
		stSlider.value = 1;
		stInnerGraph.addChild(Circle);
		stInnerGraph.addChild(drawingLine);
		stInnerGraph.addChild(Circle2);
		stInnerGraph.addChild(drawingLine2);
		Circle.visible = false;
	}
	
	public function traceGraph() { //traces the graph with the circles and shows the data
		stInnerGraph.stTextGirth.x = Circle.x+5;
		stInnerGraph.stTextGirth.y = Circle.y-20;
		Circle.x = blueLine.x-stSlider.x;
		Circle.y = allXMLFromExcel.Whaledata[stSlider.value-1].bodyG * (-100) -30;
		Circle.visible = true;
		
		if(stSlider.value <10){ //don't show the data if the scrubby is below the calfs birth
			Circle2.visible = false;
			stInnerGraph.stTextMass.visible = false;
		}
		if(stSlider.value >= 10 && stSlider.value <=36){ //calf
			Circle2.visible = true;
			stInnerGraph.stTextMass.visible = true;
			stInnerGraph.stTextMass.x = Circle2.x-39;
			stInnerGraph.stTextMass.y = Circle2.y-15;
			Circle2.x = blueLine.x-stSlider.x;
			Circle2.y = (allXMLFromExcel.Whaledata[stSlider.value-1].cmass/100*2)*(-1);
		}
		//trace(Circle2.x);
		if(stSlider.value >36){ //if scrubby is moved too fast jump to end data
			Circle2.visible = true;
			stInnerGraph.stTextMass.visible = true;
			Circle2.x = 151.75;
			Circle2.y = -92.7;
			stInnerGraph.stTextMass.x = 112.75;
			stInnerGraph.stTextMass.y = -107.7;
			stInnerGraph.stTextMass.Mass.text = "4635"
		}
	}
	
	
	public function updateStats(evt:Event):void{ //loads the XML data to be displayed on the screen
		togglePopUpVideo();
		if(stSlider.value == 1){
			if(Calendar.infoBubble.visible == true && infoFlag == true){
				Calendar.infoBubble.visible = false;
			}
			else{
				//ignore
			}
		}
		if(playFlag == false){
			Calendar.gotoAndStop(allDataArray[stSlider.value-1]);
			femaleWhale.gotoAndStop(allDataArray[stSlider.value-1]);
			maleWhale.gotoAndStop(allDataArray[stSlider.value-1]);
			WhaleCalf.gotoAndStop(allDataArray[stSlider.value-1]); // calf dot
			IceFlow.gotoAndStop(allDataArray[stSlider.value-1]);
		}
		var femaleFrame:int = allXMLFromExcel.Whaledata[stSlider.value-1].bodyG*100; //for showing the girth of the female whale
		//sliderDate.x = 53+stSlider.value*(302/102); //lines up the date box with the slider
		sliderDate.text = allXMLFromExcel.Whaledata[stSlider.value-1].Date;
		stInnerGraph.stTextGirth.Girth.text = allXMLFromExcel.Whaledata[stSlider.value-1].bodyG;
		whaleFemale.gotoAndStop(femaleFrame); //female picture
		if(stSlider.value>= 10 && stSlider.value <= 36) //calf data while it is with the mother, only appears duting these frames
		{
			femaleWhale.newBorn.gotoAndStop(allDataArray[stSlider.value-1]);
			stInnerGraph.stTextMass.Mass.text = allXMLFromExcel.Whaledata[stSlider.value-1].cmass;
		}
	}

//end of programs data

	
	// all XML code below animation paths and spreadsheet data
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function populateXML(){ //Data for all movement paths and whale information generated through xml and pathing codes elsewhere
		
	
	
	
	allXMLFromExcel = <Root>
	<Whaledata>
		<Date>11/15</Date> //319
		<Lat>55</Lat>
		<bodyG>0.700</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>11/22</Date> //326
		<Lat>60</Lat>
		<bodyG>0.694</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>11/29</Date> //333
		<Lat>54</Lat>
		<bodyG>0.688</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/06</Date>//340
		<Lat>53</Lat>
		<bodyG>0.681</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/13</Date>//347
		<Lat>49</Lat>
		<bodyG>0.675</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/20</Date>//354
		<Lat>46</Lat>
		<bodyG>0.669</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/27</Date>//361
		<Lat>43</Lat>
		<bodyG>0.663</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/03</Date>//2
		<Lat>40</Lat>
		<bodyG>0.656</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/10</Date>//9
		<Lat>35</Lat>
		<bodyG>0.650</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/17</Date>//6
		<Lat>35</Lat>
		<bodyG>0.644</bodyG>
		<cmass>945</cmass> //begin cmass data
	</Whaledata>
	<Whaledata>
		<Date>01/24</Date>//13
		<Lat>30</Lat>
		<bodyG>0.584</bodyG>
		<cmass>1233</cmass>
	</Whaledata>
	<Whaledata>
		<Date>01/31</Date>//20
		<Lat>27</Lat>
		<bodyG>0.578</bodyG>
		<cmass>1548</cmass>
	</Whaledata>
	<Whaledata>
		<Date>02/7</Date>//27
		<Lat>27</Lat>
		<bodyG>0.572</bodyG>
		<cmass>1798</cmass>
	</Whaledata>
	<Whaledata>
		<Date>02/14</Date>//34
		<Lat>27</Lat>
		<bodyG>0.566</bodyG>
		<cmass>2011</cmass>
	</Whaledata>
	<Whaledata>
		<Date>02/21</Date>//41
		<Lat>27</Lat>
		<bodyG>0.560</bodyG>
		<cmass>2200</cmass>
	</Whaledata>
	<Whaledata>
		<Date>02/28</Date>//48
		<Lat>30</Lat>
		<bodyG>0.554</bodyG>
		<cmass>2373</cmass>
	</Whaledata>
	<Whaledata>
		<Date>03/06</Date>//55
		<Lat>35</Lat>
		<bodyG>0.548</bodyG>
		<cmass>2532</cmass>
	</Whaledata>
	<Whaledata>
		<Date>03/13</Date>//62
		<Lat>40</Lat>
		<bodyG>0.542</bodyG>
		<cmass>2680</cmass>
	</Whaledata>
	<Whaledata>
		<Date>03/20</Date>//69
		<Lat>44</Lat>
		<bodyG>0.536</bodyG>
		<cmass>2821</cmass>
	</Whaledata>
	<Whaledata>
		<Date>03/27</Date>//76
		<Lat>48</Lat>
		<bodyG>0.530</bodyG>
		<cmass>2955</cmass>
	</Whaledata>
	<Whaledata>
		<Date>04/03</Date>//83
		<Lat>50</Lat>
		<bodyG>0.524</bodyG>
		<cmass>3082</cmass>
	</Whaledata>
	<Whaledata>
		<Date>04/10</Date>//90
		<Lat>51.5</Lat>
		<bodyG>0.518</bodyG>
		<cmass>3205</cmass>
	</Whaledata>
	<Whaledata>
		<Date>04/17</Date>//97
		<Lat>53</Lat>
		<bodyG>0.512</bodyG>
		<cmass>3324</cmass>
	</Whaledata>
	<Whaledata>
		<Date>04/24</Date>//104
		<Lat>54.5</Lat>
		<bodyG>0.506</bodyG>
		<cmass>3439</cmass>
	</Whaledata>
	<Whaledata>
		<Date>05/01</Date>//111
		<Lat>56</Lat>
		<bodyG>0.500</bodyG>
		<cmass>3550</cmass>
	</Whaledata>
	<Whaledata>
		<Date>05/08</Date>//118
		<Lat>58</Lat>
		<bodyG>0.492</bodyG>
		<cmass>3659</cmass>
	</Whaledata>
	<Whaledata>
		<Date>05/15</Date>//125
		<Lat>55</Lat>
		<bodyG>0.484</bodyG>
		<cmass>3765</cmass>
	</Whaledata>
	<Whaledata>
		<Date>05/22</Date>//132
		<Lat>57.5</Lat>
		<bodyG>0.475</bodyG>
		<cmass>3869</cmass>
	</Whaledata>
	<Whaledata>
		<Date>05/29</Date>//139
		<Lat>60-70</Lat>
		<bodyG>0.467</bodyG>
		<cmass>3970</cmass>
	</Whaledata>
	<Whaledata>
		<Date>06/05</Date>//146
		<Lat>60-70</Lat>
		<bodyG>0.459</bodyG>
		<cmass>4070</cmass>
	</Whaledata>
	<Whaledata>
		<Date>06/12</Date>//153
		<Lat>60-70</Lat>
		<bodyG>0.451</bodyG>
		<cmass>4168</cmass>
	</Whaledata>
	<Whaledata>
		<Date>06/19</Date>//160
		<Lat>60-70</Lat>
		<bodyG>0.450</bodyG>
		<cmass>4264</cmass>
	</Whaledata>
	<Whaledata>
		<Date>06/26</Date>//167
		<Lat>60-70</Lat>
		<bodyG>0.450</bodyG>
		<cmass>4358</cmass>
	</Whaledata>
	<Whaledata>
		<Date>07/03</Date>//174
		<Lat>60-70</Lat>
		<bodyG>0.450</bodyG>
		<cmass>4452</cmass>
	</Whaledata>
	<Whaledata>
		<Date>07/10</Date>//181
		<Lat>60-70</Lat>
		<bodyG>0.458</bodyG>
		<cmass>4544</cmass>
	</Whaledata>
	<Whaledata>
		<Date>07/17</Date>//189
		<Lat>60-70</Lat>
		<bodyG>0.467</bodyG>
		<cmass>4635</cmass> //end cmass data
	</Whaledata>
	<Whaledata>
		<Date>07/24</Date>//196
		<Lat>60</Lat>
		<bodyG>0.475</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>07/31</Date>//203
		<Lat>60</Lat>
		<bodyG>0.483</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/07</Date>//210
		<Lat>60</Lat>
		<bodyG>0.492</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/14</Date>//217
		<Lat>60</Lat>
		<bodyG>0.500</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/21</Date>//224
		<Lat>60</Lat>
		<bodyG>0.508</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/28</Date>//231
		<Lat>60</Lat>
		<bodyG>0.516</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/04</Date>//238
		<Lat>60</Lat>
		<bodyG>0.525</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/11</Date>//245
		<Lat>60</Lat>
		<bodyG>0.533</bodyG>
	</Whaledata>

	<Whaledata>
		<Date>09/18</Date>//252
		<Lat>60</Lat>
		<bodyG>0.541</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/25</Date>//259
		<Lat>60</Lat>
		<bodyG>0.550</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/02</Date>//266
		<Lat>60</Lat>
		<bodyG>0.558</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/09</Date>//273
		<Lat>60</Lat>
		<bodyG>0.566</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/16</Date>//280
		<Lat>60</Lat>
		<bodyG>0.575</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/23</Date>//287
		<Lat>60</Lat>
		<bodyG>0.583</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/30</Date>//294
		<Lat>60</Lat>
		<bodyG>0.591</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>11/06</Date>//301
		<Lat>60</Lat>
		<bodyG>0.599</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>11/15</Date>//308
		<Lat>57</Lat>
		<bodyG>0.600</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>11/22</Date>//315
		<Lat>55</Lat>
		<bodyG>0.594</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>11/29</Date>//322
		<Lat>60</Lat>
		<bodyG>0.589</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/06</Date>//329
		<Lat>54</Lat>
		<bodyG>0.583</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/13</Date>//336
		<Lat>53</Lat>
		<bodyG>0.578</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/20</Date>//343
		<Lat>49</Lat>
		<bodyG>0.572</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>12/27</Date>//350
		<Lat>46</Lat>
		<bodyG>0.567</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/03</Date>
		<Lat>43</Lat>
		<bodyG>0.561</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/10</Date>
		<Lat>40</Lat>
		<bodyG>0.556</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/17</Date>
		<Lat>35</Lat>
		<bodyG>0.550</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/24</Date>
		<Lat>30</Lat>
		<bodyG>0.546</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>01/31</Date>
		<Lat>27</Lat>
		<bodyG>0.541</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>02/07</Date>
		<Lat>27</Lat>
		<bodyG>0.537</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>02/14</Date>
		<Lat>27</Lat>
		<bodyG>0.533</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>02/21</Date>
		<Lat>27</Lat>
		<bodyG>0.528</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>02/28</Date>
		<Lat>30</Lat>
		<bodyG>0.524</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>03/06</Date>
		<Lat>35</Lat>
		<bodyG>0.520</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>03/13</Date>
		<Lat>40</Lat>
		<bodyG>0.514</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>03/20</Date>
		<Lat>44</Lat>
		<bodyG>0.508</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>03/27</Date>
		<Lat>48</Lat>
		<bodyG>0.503</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>04/03</Date>
		<Lat>50</Lat>
		<bodyG>0.497</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>04/10</Date>
		<Lat>51.5</Lat>
		<bodyG>0.491</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>04/17</Date>
		<Lat>53</Lat>
		<bodyG>0.486</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>04/24</Date>
		<Lat>54.5</Lat>
		<bodyG>0.480</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>05/01</Date>
		<Lat>56</Lat>
		<bodyG>0.488</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>05/08</Date>
		<Lat>58</Lat>
		<bodyG>0.496</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>05/15</Date>
		<Lat>55</Lat>
		<bodyG>0.503</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>05/22</Date>
		<Lat>57.5</Lat>
		<bodyG>0.511</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>05/29</Date>
		<Lat>60-70</Lat>
		<bodyG>0.519</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>06/05</Date>
		<Lat>60-70</Lat>
		<bodyG>0.527</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>06/12</Date>
		<Lat>60-70</Lat>
		<bodyG>0.535</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>06/19</Date>
		<Lat>60-70</Lat>
		<bodyG>0.543</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>06/26</Date>
		<Lat>60-70</Lat>
		<bodyG>0.551</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>07/03</Date>
		<Lat>60-70</Lat>
		<bodyG>0.558</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>07/10</Date>
		<Lat>60-70</Lat>
		<bodyG>0.566</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>07/17</Date>
		<Lat>60-70</Lat>
		<bodyG>0.574</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>07/24</Date>
		<Lat>60-70</Lat>
		<bodyG>0.582</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>07/31</Date>
		<Lat>60-70</Lat>
		<bodyG>0.590</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/07</Date>
		<Lat>60-70</Lat>
		<bodyG>0.598</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/14</Date>
		<Lat>60-70</Lat>
		<bodyG>0.606</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/21</Date>
		<Lat>60-70</Lat>
		<bodyG>0.614</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>08/28</Date>
		<Lat>60-70</Lat>
		<bodyG>0.621</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/04</Date>
		<Lat>60-70</Lat>
		<bodyG>0.629</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/11</Date>
		<Lat>60-70</Lat>
		<bodyG>0.637</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/18</Date>
		<Lat>60-70</Lat>
		<bodyG>0.645</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>09/25</Date>
		<Lat>60-70</Lat>
		<bodyG>0.653</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/02</Date>
		<Lat>60-70</Lat>
		<bodyG>0.661</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/09</Date>
		<Lat>60-70</Lat>
		<bodyG>0.669</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/16</Date>
		<Lat>60-70</Lat>
		<bodyG>0.676</bodyG>
	</Whaledata>
	<Whaledata>
		<Date>10/23</Date>
		<Lat>60-70</Lat>
		<bodyG>0.684</bodyG>
	</Whaledata>
</Root>;

	}
	
	
}//end class
}//end package