///////////////////  HOW TO ADD BIRDS AND NEW FAMILIES TO THIS FLASH //////////////////////////////////////////////////////
///																														///
/// STEP 1: in the fla you will need to locate these three movieclips, Deck, Deck2, restoreDeck 							///
/// STEP 2: a) Start in Deck, if your birds family already exists then locate that family name within Deck 				///
///			b) Once you have found it, double clip on that family to access the members of it. 							///
///			c) Add you bird(s) to it now, change the size so that the height and width are linked and make a 			///
///				width of 105 px.																						///
///			d) Convert the bird(s) to symbols and give them a that looks like this fami_00, no capital letters,			///
///				match the style of the previous birds if you need a reference for which number it should be. 			///
///			e) Now open the moveclip and view the timeline 																///
///			f) Create a new keyframe (F6) right next to the first so there are 2. 										///
/// STEP 3: a) If you need to add a new family, repeat parts c and d of STEP 2 inside the Deck 							///
///			b) Select all the new birds and make a new symbol															///
///			c) Name this symbol the name of the bird family, all in lower case and make sure it also has the name		///
/// 			on the movieclip afterwords																				///
///			d) repeat parts e and f of STEP 2																			///
/// STEP 4:	a) Repeat STEP 2 and STEP 3 for the two remaining movieclips Deck2 and restoreDeck							///
///			b) Deck2 and restoreDeck should contain copies of the birds and not the original							///
///			c) Once the birds are updated within these decks make sure you swap the symbol with a new copy				///
///				for all birds and families that were updated, you can see the format on other birds and families		///
///				within these decks for reference																		///
/// STEP 5: In the code locate the array: family_names at the top and add any new families that you added to the deck	///
///			in lowercase, same format as they are already																///
/// STEP 6: Test the game and see if they were all added by clicking [ reference ] when you start it up					///
/// 																													///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Current version run through of the game:
	main function sets various displays to not be shown. sets globals for total birds and number of birds already on stage
		-calls ScoreText()
		-calls createFamilies()
		-calls randomize()
		-calls addEvents()
		-calls bigList()
		
		game is initialized after these calls
		
	ScoreText sets the score display to equal the totalScore
	
	createFamilies randomly chooses 6 families to use for the game and sets the zonenames that are visible on the stage to be the name of the families chosen
	
	randomize first searches thwe deck for the family names that were chosen and then adds all of the birds from those
				families to an array birds_on_stage it then calls a seperate function RandomTheBirds() after which
				it updates the totalBirds Display to be the total number of birds in that array and sets currentBird
				display to 1.
				
	RandomTheBirds creates a temp array which is an exact copy of the birds_on_stage array and then completely
					deletes the birds_on_stage array and copies the temp array back to it in a random order.  It
					then chooses between 0 and 5 birds to randomly remove from the birds_on_stage array giving
					it a more unique feel.
					
	addEvents is adding all the initial event listeners for the instructions, start button, and family zones
	
	bigList creates a copy of the deck and adds the families to a scrolling window where the user can see a 
			list of the birds and there families.
			
	startGame this function is called from the instructions screen start button which is open automatically on the 
				first run and this is what starts the game loop by calling showRound()
				
	showRound checks to see which round you are currently on and flashes a screen tell you how much time you have
				to view birds on the next round and starts a timer: myTimer2 for how long this message should be visible
				
	roundTimer called from myTimer2 running checks to see how long the timer has been running and when it has
				been running long enough turns off the round message and calls showBird()
				
	intermediateTimer called from roundTimer, shows the round message for all the rounds after the first one.
	
	clickToContinue called between rounds from the message displaying how many birds you got correct, waits for
					the user to click the screen before continuing to the round message.
					
	showBird flashes the next bird in the array birds_on_stage for the alloted time myTimer(value): right now set to
				500 ms for the counts denoted by timeToFlashBird in timerRunning which is started from myTimer
				
	timerRunning will turn off the flashed bird showing the main screen
	
	thisZone on the main screen the user is now able to click a zone they think the bird belonged to. this function
			will figure out which zone they clicked and if the family name assigned to that zone matches the
			family name assigned to the bird that was shown.  if it does it will remove the bird from the
			birds_on_stage array and add points to the score by calling Score(number) function and show a green
			circle, if its wrong it will show a red incorrect circle and start myTimer3 which calls showRightWrong()
			
	showRightWrong displays the right wrong circle and determines which stage the game is on restarts the loop by
					calling showBird() if there are more birds in the current round, restarts from round loop by
					calling showRound() if the max number of birds for the current round has been reached and ends
					the game by showing the end game screen if there are no more birds to show or there are no
					more rounds left.
					
	
	
				

*/

package  {
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.text.Font;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.net.*;
	import fl.events.ScrollEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FW312BirdSilhouette extends MovieClip{
		var ROUND2 : int = 2; //set time for each round, time will be this number divided by 2, 2 = 1 second
		var ROUND3 : int = 3;
		var ROUND4 : int = 0; // 0 = infinite
		var totalScore : int = 0; //total score used to display
		var birds_on_stage : Array  = new Array(); //array of remaining birds to identify on the stage
		//an array that holds all the families that can be chosen
		var family_names : Array = new Array("Cathartidae", "Accipitridae", "Falconidae", "Phasianidae", "Trochilidae", "Columbidae", "Picidae",
											  "Mimidae", "Troglodytidae", "Cuculidae", "Emberizidae", "Fringillidae", 
											 "Passeridae", "Ramphastidae", "Spheniscidae", "Anatidae", "Psittacidae", "Threskiornithidae",
											 "Pelecanidae", "Gruidae", "Struthionidae", "Phalacrocoracidae", "Laridae", "Ardeidae",
											 "Sturnidae", "Cardinalidae", "Tyrannidae", "Gaviidae", "Podicipedidae", "Parulidae",
											 "Alcedinidae","Alcidae","Apodidae","Apterygidae","Casuariidae","Charadriidae","Dromaiidae",
											 "Haematopodidae","Momotidae","Odontophoridae","Pandionidae", "Rallidae","Recurvirostridae",
											 "Rheidae","Scolopacidae","Trogonidae","Corvidae","Hirundinidae","Regulidae","Turdidae","Vireonidae",
											 "Sulidae","Tinamidae","Cracidae","Diomedeidae","Procellariidae","Hydrobatidae","Ciconiidae",
											 "Tytonidae","Strigidae","Caprimulgidae","Laniidae","Alaudidae","Paridae","Aegithalidae","Sittidae",
											 "Certhiidae","Cinclidae","Sylviidae","Motacillidae","Bombycillidae","Calcariidae","Icteridae");
											
		var family_zones : Array = new Array(6); //an array that will have 6 families chosen at random from the list in family_names
		
		var myTimer : Timer = new Timer(500,0);//w: trying to double the speed - timer to flash the birds for certain time period
		var myTimer2 : Timer = new Timer(500,0); //timer to display the nextRound message for certain time period
		var myTimer3:Timer = new Timer(1000,0); //timer used after clicking a zone so user can see the correct/incorrect mark for certain number of time
		
		var birdPlace : Number = 0; //global counter used to track which bird is currently the one the user is identifying
		var timeToFlashBird : Number = 1; //global var for the rounds/determines how much time the user has to look at the bird --- number/2
		var removeThis:Boolean = false; //flag for if the user got a bird correct then remove it from the stage array else do nothing

		var firstTimeFlag:Boolean = true;//used to control listener behaviour on the start button
		
		//these variables only used for generating the viewable bird list
		var MCheight:Number = 60;  //spacing variable for how much vertical space between movieclips will appear
		var MCSpacing:Number = 350; //horizontal spacing between movieclip and text family name
		var myTextStyle : TextFormat = new TextFormat ("Times New Roman",20); //used to set the style of the text for the viewable bird list
		var myDeck : MovieClip = new Deck(); //copy of the deck needed in order to not tamper with the existing deck for gameplay
		var myBirdDeck : MovieClip = new Deck(); //second copy needed in order to grab proper names in the order the first deck is added
		var nameArray : Array = new Array(myDeck.length); //seems redundant might want to remove later to clean a function - adds names to an array in order to place in the movieclips next to the families
		var tempName:String; //tempName used for checking the family vrs the birds

		

		public function FW312BirdSilhouette() {
			instruct_btn.visible = false; //initialize the instruct button to not show yet
			instructions.paused_txt.visible = false; //turn this off at the beginning because the game isn't being paused yet
			moveNextScreen.numRight.text = "0"; //default number of correct birds for this screen to 0
			ScoreText(); //init score display to 0
			createFamilies(); //init 6 families for the game
			randomize(); //get and randomize the birds for the families
			addEvents(); //add initial events for the game
			bigList(); //init the viewable list of birds and their families
		}
		
		
		/*
		This function creates new decks of bird families and stores them in a scrollable list that the user 
		may then view at any time by clicking on the [ reference ] link at the top of the swf.
		*/
		private function bigList(){
			myDeck = new Deck(); //reinit the deck - useful for resets
			myBirdDeck = new Deck(); //reinit second state of the deck might not be needed? -using numChildren for for loops this why I use 2 decks, not a smart way to run the for loop though
			var MaxDeck:Number = myDeck.numChildren;
			//myDeck.sort(Array.UNIQUESORT);
			for(var i:Number = 0;i<MaxDeck;i++){ 
				tempName = MovieClip(myBirdDeck.getChildAt(i)).name; //get the name of the current child
				nameArray[i] = tempName; //add the name of the child to a new array
				//AllSets.MCLayer.addChild(MovieClip(myBirdDeck.getChildAt(0))); //add the child to the scroll list
				//AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).x = 0+150;  //change the x position, static
				//AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).y = MCheight+50; //change the yoffset so images aren't stacked
				//AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).gotoAndStop(2); //play the clearest frame, no longer necessary
				//MCheight += MCSpacing; //change vertical offset for next image
			}
			nameArray.sort(Array.CASEINSENSITIVE);
			//trace(nameArray);
			for(var j:Number = 0;j<MaxDeck;j++){ 
				//tempName = MovieClip(myBirdDeck.getChildAt(0)).name; //get the name of the current child
				//nameArray[i] = tempName; //add the name of the child to a new array
				//trace(myDeck.numChildren);
				//trace(myDeck.getChildByName(nameArray[j]).name);
				AllSets.MCLayer.addChild(MovieClip(myDeck.getChildByName(nameArray[j]))); //add the child to the scroll list
				AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).x = 0+150;  //change the x position, static
				AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).y = MCheight+50; //change the yoffset so images aren't stacked
				//AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).gotoAndStop(2); //play the clearest frame, no longer necessary
				MCheight += 350; //change vertical offset for next image
			}
			MCheight = 60; //set hieght back to original to prepare for family name column
			for(var a:Number = 0;a<MaxDeck;a++){
				tempName = nameArray[a]; //get the name of the first bird family
				var myFamilyBox : TextField = new TextField; //create a textfield for the family
				myFamilyBox.defaultTextFormat = myTextStyle; //set formatting
				myFamilyBox.width = 200;
				myFamilyBox.text = tempName; //assign the family name to the textbox
				AllSets.MCLayer.addChild(myFamilyBox); //add the text field to the scrollable list
				AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).x = 150+MCSpacing;  //set the xoffset
				AllSets.MCLayer.getChildAt(AllSets.MCLayer.numChildren-1).y = MCheight+50; //set the yoffset
				MCheight += 350; //increment the vertical offsets to match the movieclips
			}
			AllSets.scrollMC.setScrollProperties(2000,10,AllSets.MCLayer.height-450); //setup the scrollbar to match the length of the pane that was just created
			AllSets.scrollMC.addEventListener(ScrollEvent.SCROLL, mcScrolled);
			AllSets.visible = false; //this list is not visible by default
			AllSets.btn_close.addEventListener(MouseEvent.CLICK, viewSets); //add event to slose the view pane when user clicks close
			btn_view.addEventListener(MouseEvent.CLICK, viewSets); //same as above, toggles the screen
		}
		
		//function mcScrolled
		/*
			scrolls the view sets pane 
		*/
		public function mcScrolled(evt:ScrollEvent){
			AllSets.MCLayer.y = (-evt.position)+40;
		}

		//function viewSets
		/*
			toggles the view sets pane to be visible or not visible
		*/
		public function viewSets(evt:Event):void{
			AllSets.visible = !AllSets.visible;
		}
		
		/*
			this function uses a tempory deck and destroys the current deck to repopulate it with a copy of a new one
			and then restarts the game from scratch
		*/
		private function resetGame(evt:MouseEvent):void{
			trace("get vars");
			var tempDeck : MovieClip = new restoreDeck(); //create a temporary deck, needed so that we have a complete fresh deck to work with
			var tempNum : int = allBirds.numChildren; //used to evaluate forloops to correct number
			var tempNum2 : int = birds_on_stage.length;
			trace("num: "+allBirds.numChildren);
			trace("num: "+tempDeck.numChildren);
			endScreen.visible = false; //no longer displaying the end of the game
			for(var jj:int = 0; jj< tempNum;jj++){ //remove everything from the current deck
				allBirds.removeChildAt(0);
			}
			trace("for loop 1");
			for(var dd:int = 0; dd < tempNum;dd++){ //replace current deck with a fresh deck of birds
				allBirds.addChild(tempDeck.getChildAt(0));
			}
			trace("for loop 2");
			for(var hh:int = 0; hh< tempNum2;hh++){ //remove everything from the current deck
				birds_on_stage.pop();
			}
			//trace("center zone remaining: "+center_zone.getChildAt(1).name);
			
			if(center_zone.numChildren > 1){
				center_zone.removeChildAt(1);
			}
			totalScore = 0; //reset score to 0
			timeToFlashBird = 1; //reset flash time for birdflash to half a second
			birdPlace = 0;
			theRounds.text = (3).toString(); //reset rounds to 3 remaining
			moveNextScreen.numRight.text = "0"; //reset number of correct birds to 0
			ScoreText(); //reset the visible score to 0
			createFamilies(); //choose 6 new families
			randomize(); //rerandomize the birds
			showRound(); //start from the round screen instead of the intro screen
		}	
		
		/*
			startGame is called from the instructions start game button and is used to start the game loop by
			turning off the instructions display and starting the round or resuming the game.
		*/
		public function startGame(evt:MouseEvent):void{
			instructions.visible = false; //turns off instructions screen
			instruct_btn.visible = true; //allows the resume game button to be accessable from the instructions menu
			if(firstTimeFlag){ //trick to avoid calling this everytime they exit the instructions.
				firstTimeFlag = false;
				showRound();
			}
			trace("center zone remaining: "+center_zone.numChildren);
		}
		
		/*
			this function is used to update the totalscore
		*/
		public function Score(myScore : Number){
			totalScore += myScore; //adds the number that was send in to the totalScore
			ScoreText(); //changes the score display
		}
		
		/*
			3d text score display, just changes the display on the stage
		*/
		public function ScoreText(){
			score_board.score.htmlText = String("<b>"+totalScore+"</b>");
			score_board.score2.htmlText = String("<b>"+totalScore+"</b>");
			score_board.score3.htmlText = String("<b>"+totalScore+"</b>");
		}
		
		/*
			This function picks 6 families at random and places the names into a zone on the stage
		*/
		private function createFamilies(){
			for(var ic :Number = 0;ic<family_zones.length;ic++){
				family_zones[ic] = family_names[RandomNumber(0,family_names.length-1)]; //pick a family
				for(var id:Number = 0;id<ic;id++){
					if(family_zones[ic] == family_zones[id]){ //check if you already picked this family
						family_zones[ic] = family_names[RandomNumber(0,family_names.length-1)]; //if you picked the family pick a new one
						ic--; //reduce the count until the family is unique
					}
				}
			}
			//place the 6 families into the 6 zones on the stage
			allZones.fam_zone00.NAME.fam_text.text = family_zones[0];
			allZones.fam_zone01.NAME.fam_text.text = family_zones[1];
			allZones.fam_zone02.NAME.fam_text.text = family_zones[2];
			allZones.fam_zone03.NAME.fam_text.text = family_zones[3];
			allZones.fam_zone04.NAME.fam_text.text = family_zones[4];
			allZones.fam_zone05.NAME.fam_text.text = family_zones[5];
		}
		
		/*
			Decides how many birds to place on the stage, range undecided yet
			Calls a placement function and gives it the number of birds to place
		*/
		private function randomize(){
			var famstr : String;
			var check_length : Number = 0;
			var total_birds_in_families : Number = 0;
			
			trace("birds on stage: "+birds_on_stage.length);
			//grab all the birds from each family that was chosen
			for(var t:Number = 0;t<MovieClip(allBirds.getChildByName(family_zones[0])).numChildren;t++){
				birds_on_stage.push(MovieClip(allBirds.getChildByName(family_zones[0])).getChildAt(t));
			}
			for(var aa:Number = 0;aa<MovieClip(allBirds.getChildByName(family_zones[1])).numChildren;aa++){
				birds_on_stage.push(MovieClip(allBirds.getChildByName(family_zones[1])).getChildAt(aa));
			}
			for(var bb:Number = 0;bb<MovieClip(allBirds.getChildByName(family_zones[2])).numChildren;bb++){
				birds_on_stage.push(MovieClip(allBirds.getChildByName(family_zones[2])).getChildAt(bb));
			}
			for(var cc:Number = 0;cc<MovieClip(allBirds.getChildByName(family_zones[3])).numChildren;cc++){
				birds_on_stage.push(MovieClip(allBirds.getChildByName(family_zones[3])).getChildAt(cc));
			}
			for(var dd:Number = 0;dd<MovieClip(allBirds.getChildByName(family_zones[4])).numChildren;dd++){
				birds_on_stage.push(MovieClip(allBirds.getChildByName(family_zones[4])).getChildAt(dd));
			}
			for(var ee:Number = 0;ee<MovieClip(allBirds.getChildByName(family_zones[5])).numChildren;ee++){
				birds_on_stage.push(MovieClip(allBirds.getChildByName(family_zones[5])).getChildAt(ee));
			}
			trace("family zone?: "+ allBirds.getChildByName(family_zones[0]).name+" "+ allBirds.getChildByName(family_zones[1]).name+ " "+allBirds.getChildByName(family_zones[2]).name+ " "+allBirds.getChildByName(family_zones[3]).name+ " "+allBirds.getChildByName(family_zones[4]).name+" "+ allBirds.getChildByName(family_zones[5]).name);
			trace("birds on stage: "+birds_on_stage.length);
			RandomTheBirds(); //randomize the birds
			trace("birds on stage: "+birds_on_stage.length);
			remainingBirds.text = (birds_on_stage.length).toString(); //number of all the birds for this session
			currentBirdDisp.text = "1"; //start on bird 1
		}
		
		/*
			this function takes the original array of birds and randomly reorders them and then removes a certain
			number of the birds so that it is never the same.
		*/
		public function RandomTheBirds(){ //reorders the list of birds
			var tempArray : Array = new Array(); //creates a copy of all the birds chosen
			var loopNumber:Number = birds_on_stage.length; //used to get correct number of birds for a for loop
			var popNum:Number; //random bird removed from the birds_on_stage array to be added to the tempArray
			
			var takeOut:int = RandomNumber(0,5); //random number of birds to remove at the end
			for(var n:int = 0; n<loopNumber;n++){ //reorder the bird array
				popNum = RandomNumber(0,birds_on_stage.length-1); //get bird
				tempArray.push(MovieClip(birds_on_stage[popNum])); //add bird
				birds_on_stage.splice(popNum,1); //remove bird
			}
			for(var t:int = 0; t<loopNumber;t++){ //readd birds in new order
				birds_on_stage.push(MovieClip(tempArray[t])); //bird from tempArray to be added back to the original array
			}
			
			for(var tt:int = 0; tt<takeOut; tt++){
				popNum = RandomNumber(0,birds_on_stage.length-1); //pick a random bird
				birds_on_stage.splice(popNum,1); //and remove it
			}
		}
		
		/*
			this function will display the next round text
		*/
		public function showRound(){
			rightCircle.visible = false; //ensure this is not visible
			wrongCircle.visible = false; //ensure this is not visible
			screenCover.visible = true; //temp background so you don't see the main screen
			if(Number(theRounds.text) == 3){ //if you still have 3 rounds remaining then this is after the start game
				nextRound.visible = true; //show the nextRound text 
				nextRound.roundCounter.text = "1"; //set it to round 1
				nextRound.timeForRound.text = (timeToFlashBird/2); //show them how much time they can view the bird flash
				myTimer2.start(); //start the time for round display
				myTimer2.addEventListener(TimerEvent.TIMER, roundTimer);
			}else{ //if you are not in the first round then display a score screen for how many birds they got right
				moveNextScreen.visible = true; //show score screen and wait for user to click
				moveNextScreen.addEventListener(MouseEvent.MOUSE_DOWN, clickToContinue);
			}
			
		}
		
		/*
			intermediate step that waits for the user to click the mouse to move on to the next round, 
			shows how many birds they got correct
		*/
		public function clickToContinue(evt:MouseEvent):void{
			moveNextScreen.visible = false; //no longer viewing score so make it not visible
			myTimer2.start(); //start the timer for round display
			myTimer2.addEventListener(TimerEvent.TIMER, intermediateRound);
		}
		
		/*
			This function is used as a display for the round text after the first round has been done
			since it behaves differently as it waits for a mouse click from the bird correct screen
		*/ 
		public function intermediateRound(evt:TimerEvent):void{
			moveNextScreen.numRight.text = "0";
			if(Number(theRounds.text) == 2){ //if 2 rounds remain
				nextRound.visible = true; //show next round 
				nextRound.roundCounter.text = "2"; //set the round to 2
				nextRound.timeForRound.text = (timeToFlashBird/2); //show new time to flash birds
			}
			if(Number(theRounds.text) == 1){ //if 1 round remains
				nextRound.visible = true; //show next round
				nextRound.roundCounter.text = "3"; //set the round to 3
				nextRound.timeForRound.text = (timeToFlashBird/2);  //show the nex time that a bird will be visible to the user
			}
			if(Number(theRounds.text) == 0){ //if no rounds remain
				nextRound.visible = true; //show next round
				nextRound.roundCounter.text = "4"; //show the current round is 4
				nextRound.timeForRound.htmlText = "(endless)"; //show that the user can continue to view the bird even after the flash of it
			}
			if(myTimer2.currentCount >= 5){ //myTimer2 is on a 500 ms delay so checking if it is at a count of 5 shows the next round message for 2.5seconds
				nextRound.visible = false;
				myTimer2.stop();
				myTimer2.reset();
				showBird(); //move to the next function in the game loop
				myTimer2.removeEventListener(TimerEvent.TIMER, intermediateRound); //end the current timer event
			}
		}
		
		
		/*
			This function is activated from a running timer, its job is to kill the next round message after a certain number
			of seconds has gone by and start the game loop
		*/
		public function roundTimer(evt:TimerEvent):void{
			if(myTimer2.currentCount >=5){ //after 2.5 seconds kill the next round message and start the game loop
				myTimer2.stop();
				myTimer2.reset();
				nextRound.visible = false;
				moveNextScreen.numRight.text = (0).toString(); //redundant, can just say 0 
				myTimer2.removeEventListener(TimerEvent.TIMER, roundTimer); //kill the current timer
				showBird(); //start the game loop
			}
		}
		
		/*
			This function will briefly display a bird silhouette on the screen.
		*/
		public function showBird(){
			rightCircle.visible = false; //kill both the correct and incorrect circles if they are on the screen
			wrongCircle.visible = false;
			birdFlash.visible = true; //show the screen for flashing the bird, hides the main screen
			birdFlash.birdInFlash.addChild(birds_on_stage[birdPlace]); //add the current bird to the flasher
			//MovieClip(birdFlash.birdInFlash.getChildAt(0)).gotoAndStop(2); //no longer needed but stop the bird on the clear frame, eventually taking the blob out of the movieclips so I can kill this line of code
			birdFlash.birdInFlash.getChildByName(MovieClip(birds_on_stage[birdPlace]).name).x = 0; //center the bird inside the flasher
			birdFlash.birdInFlash.getChildByName(MovieClip(birds_on_stage[birdPlace]).name).y = 0;
			myTimer.start(); //start the timer to show the bird for a certain number of seconds
			myTimer.addEventListener(TimerEvent.TIMER, timerRunning);
			allZones.fam_zone00.addEventListener(MouseEvent.MOUSE_DOWN, thisZone); //allow the user to now click the zones
			allZones.fam_zone01.addEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone02.addEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone03.addEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone04.addEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone05.addEventListener(MouseEvent.MOUSE_DOWN, thisZone);
		}
		
		/*
			This is the timer that is run from the showBird function it will kill the flasher screen after a certain number of 
			seconds which is denoted by timeToFlashBird divided by 2.
		*/
		public function timerRunning(evt:TimerEvent):void{ //w: time runs, and each tick calls this func. which checks to se if limit is reached.
			
			if(myTimer.currentCount >= timeToFlashBird){ //when the counter reaches a certain number kill the flasher
				myTimer.stop();
				myTimer.reset();
				birdFlash.birdInFlash.removeChild(birds_on_stage[birdPlace]); //remove the bird from the center flasher to avoid stacking
				birdFlash.visible = false; //stop showing the flasher
				center_zone.addChild(MovieClip(birds_on_stage[birdPlace])); //add the bird to the center
				//trace("flash bird on stage should not be 0: "+timeToFlashBird);
				if(timeToFlashBird == 0){ //if the final round show the bird on the stage else don't show it
					MovieClip(center_zone.getChildAt(1)).visible = true;
					center_zone.visible = true; 
				}else{
					center_zone.visible = false;
					MovieClip(center_zone.getChildAt(1)).visible = false;
				}
				screenCover.visible = false; //white backdrop to hide the main screen, turn this off so user can select a zone
				center_zone.getChildByName(MovieClip(birds_on_stage[birdPlace]).name).x = RandomNumber(100,200); //randomly place the bird somewhere in the middle
				center_zone.getChildByName(MovieClip(birds_on_stage[birdPlace]).name).y = RandomNumber(100,200);
				//trace(MovieClip(center_zone.getChildAt(1)).visible);
			}
		}
		
		/*
			This function determines which zone the user selected and tries to match the name of that zone to the name of the
			bird, if they match then it makes it as correct and removes the bird from the array of possible bird choices, if it
			is not correct then it marks it incorrect and keeps it in the array.
		*/
		public function thisZone(evt:MouseEvent):void{
			switch(evt.currentTarget.name){
				case "fam_zone00": //zone 0 selected
					if(String(family_zones[0]).substr(0,5).toLowerCase() == MovieClip(birds_on_stage[birdPlace]).name.substr(0,5).toLowerCase()){ //find the name of the zone and the name of the current bird and if the match do this
						removeThis = true; //set remove flag to true, used to remove the bird from the array
						rightCircle.visible = true; //show that they got it correct visually
						moveNextScreen.numRight.text = (Number(moveNextScreen.numRight.text)+1).toString(); //increment number of birds correct on the round end screen
						Score(Number(theRounds.text)*15); //add a score equal to the rounds remaining times 15
					}else{ //if the zone and bird names dont match show they got it wrong visually
						wrongCircle.visible = true;
					}
					break;
				case "fam_zone01": //same as above for zone 1, see zone 0
					if(String(family_zones[1]).substr(0,5).toLowerCase() == MovieClip(birds_on_stage[birdPlace]).name.substr(0,5).toLowerCase()){
						removeThis = true; 
						rightCircle.visible = true;
						moveNextScreen.numRight.text = (Number(moveNextScreen.numRight.text)+1).toString();
						Score(Number(theRounds.text)*15);
					}else{
						wrongCircle.visible = true;
					}
					break;
				case "fam_zone02": //same as above for zone 2, see zone 0
					if(String(family_zones[2]).substr(0,5).toLowerCase() == MovieClip(birds_on_stage[birdPlace]).name.substr(0,5).toLowerCase()){
						removeThis = true; 
						rightCircle.visible = true;
						moveNextScreen.numRight.text = (Number(moveNextScreen.numRight.text)+1).toString();
						Score(Number(theRounds.text)*15);
					}else{
						wrongCircle.visible = true;
					}
					break;
				case "fam_zone03":  //same as above for zone 3, see zone 0
					if(String(family_zones[3]).substr(0,5).toLowerCase() == MovieClip(birds_on_stage[birdPlace]).name.substr(0,5).toLowerCase()){
						removeThis = true;
						rightCircle.visible = true;
						moveNextScreen.numRight.text = (Number(moveNextScreen.numRight.text)+1).toString();
						Score(Number(theRounds.text)*15);
					}else{
						wrongCircle.visible = true;
					}
					break;
				case "fam_zone04": //same as above for zone 4, see zone 0
					if(String(family_zones[4]).substr(0,5).toLowerCase() == MovieClip(birds_on_stage[birdPlace]).name.substr(0,5).toLowerCase()){
						removeThis = true; 
						rightCircle.visible = true;
						moveNextScreen.numRight.text = (Number(moveNextScreen.numRight.text)+1).toString();
						Score(Number(theRounds.text)*15);
					}else{
						wrongCircle.visible = true;
					}
					break;
				case "fam_zone05"://same as above for zone 5, see zone 0
					if(String(family_zones[5]).substr(0,5).toLowerCase() == MovieClip(birds_on_stage[birdPlace]).name.substr(0,5).toLowerCase()){
						removeThis = true;  
						rightCircle.visible = true;
						moveNextScreen.numRight.text = (Number(moveNextScreen.numRight.text)+1).toString();
						Score(Number(theRounds.text)*15);
					}else{
						wrongCircle.visible = true;
					}
					break;
				default:
					trace("somehow we clicked a non existent zone");
					break;
				
			}
			
			removeMouseEvents(); //call this function to remove the event listeners from the zones, prevents posiblitiy of clicking a zone when you have no birds availalbe to check
			
			myTimer3.start(); //start timer for showing the right/wrong circles
			myTimer3.addEventListener(TimerEvent.TIMER, showRightWrong);
		}
		
		
		/*
			The purpose of this function is to show the right or wrong circles for a given length of time (1 second) before moving to the 
			next bird or round
		*/
		public function showRightWrong(evt:TimerEvent):void{
					MovieClip(center_zone.getChildAt(1)).visible = true; //this is the location of right/wrong circles
			trace(birds_on_stage.length+" <left on stage | cur bird >> "+birdPlace);
			if(myTimer3.currentCount >=1){ //when timer reaches 1 second do the following
				currentBirdDisp.text = (Number(currentBirdDisp.text)+1).toString(); //increment the current bird by 1 to show that you are on the next bird
				if((birdPlace+1)==birds_on_stage.length){ //if we are on the last bird already then start a new round
					if(Number(theRounds.text) > 0){ //if we are not on the last round
						center_zone.removeChild(birds_on_stage[birdPlace]); //remove the previous bird from the center zone
						if(removeThis){ //if this flag was set
							birds_on_stage.splice(birdPlace,1); //remove this bird from the array
							removeThis = false; //and reset the flag
						}
						remainingBirds.text = (birds_on_stage.length).toString(); //change the display for remaining birds to match the number of birds remaining in the array
						currentBirdDisp.text = "1"; //change the current bird to be back to the first in the series
						theRounds.text = (Number(theRounds.text)-1).toString(); //decrement remaining rounds
						birdPlace = 0; //start over from the first bird in the array
						if(birds_on_stage.length == 0){ //if you don't have any more birds in your array
							endGame(); //then we can end the game without going through the rest of the rounds
						}else{ //if you do have birds left in your array
							
							if(Number(theRounds.text) == 2){ //if still 2 rounds to go, set bird flash to 1 second
								whatWasThat.gotoAndStop(1);
								timeToFlashBird = ROUND2;
							}
							if(Number(theRounds.text) == 1){ //if still 1 round to go, set bird flash to 1.5 seconds
								timeToFlashBird = ROUND3;
							}
							if(Number(theRounds.text) == 0){ //if no rounds left set bird flash to infinite
								timeToFlashBird = ROUND4;
								whatWasThat.gotoAndStop(2);
							}
							showRound(); //show the next round screen with the updated information
						}
					}else{ //if we are on the last round
						endGame(); //sorry end the game
						timeToFlashBird = 1;
					}
				}else{ //if we are not on the last bird of the round
					center_zone.removeChild(birds_on_stage[birdPlace]); //remove the current bird from the center
					if(removeThis){ //if this flag was set
						birds_on_stage.splice(birdPlace,1); //remove the bird from the array of birds
						birdPlace--; //and decrement the birdPlace so that we are back in the proper place of the array
						removeThis = false; //reset this flag
					}
//W: WHERE ARE WHEN THIS STUFF IS HAPPENING? WHAT STATE OF THE GAME DOES THIS REPRESENT? -this is where you end up when you still have birds left to go through for the current round
					birdPlace++; //now increment so you are on the next bird in the array
					showBird(); //this restarts the loop? -yes, shows the next bird
				}
				myTimer3.stop(); //stop this timer and kill the timer event
				myTimer3.reset();
				myTimer3.removeEventListener(TimerEvent.TIMER, showRightWrong);
			}
		}
		
		
		/*
			This function is here to remove the stage events while other parts of the game are going on to prevent accidental
			errors, in this case removing the ability to click zones while screens are being shown.
		*/
		public function removeMouseEvents(){
			allZones.fam_zone00.removeEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone01.removeEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone02.removeEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone03.removeEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone04.removeEventListener(MouseEvent.MOUSE_DOWN, thisZone);
			allZones.fam_zone05.removeEventListener(MouseEvent.MOUSE_DOWN, thisZone);
		}
		
		/*
			This function just shows the end game screen, it was planned that this would do a stats screen as well
			but was never implemented
		*/
		public function endGame(){ //
			endScreen.visible = true;
			//firstTimeFlag = false; //w: resetting this... in case the game resets to instructions screen -Not needed anymore reseting the game ina different way
		}
		
		/*
			all of the event listeners for this program are generated in this function
		*/
		private function addEvents(){
			instructions.start_btn.addEventListener(MouseEvent.MOUSE_DOWN, startGame);
			instruct_btn.addEventListener(MouseEvent.MOUSE_DOWN, instructOpen);
			endScreen.btn_reset.addEventListener(MouseEvent.MOUSE_DOWN, resetGame);
			
			allZones.fam_zone00.addEventListener(MouseEvent.MOUSE_OVER, zoneOver);
			allZones.fam_zone01.addEventListener(MouseEvent.MOUSE_OVER, zoneOver);
			allZones.fam_zone02.addEventListener(MouseEvent.MOUSE_OVER, zoneOver);
			allZones.fam_zone03.addEventListener(MouseEvent.MOUSE_OVER, zoneOver);
			allZones.fam_zone04.addEventListener(MouseEvent.MOUSE_OVER, zoneOver);
			allZones.fam_zone05.addEventListener(MouseEvent.MOUSE_OVER, zoneOver);
			allZones.fam_zone00.addEventListener(MouseEvent.MOUSE_OUT, zoneOut);
			allZones.fam_zone01.addEventListener(MouseEvent.MOUSE_OUT, zoneOut);
			allZones.fam_zone02.addEventListener(MouseEvent.MOUSE_OUT, zoneOut);
			allZones.fam_zone03.addEventListener(MouseEvent.MOUSE_OUT, zoneOut);
			allZones.fam_zone04.addEventListener(MouseEvent.MOUSE_OUT, zoneOut);
			allZones.fam_zone05.addEventListener(MouseEvent.MOUSE_OUT, zoneOut);
			
			//not really and event but stops the zones in a mouse_out state
			allZones.fam_zone00.gotoAndStop(1);
			allZones.fam_zone01.gotoAndStop(1);
			allZones.fam_zone02.gotoAndStop(1);
			allZones.fam_zone03.gotoAndStop(1);
			allZones.fam_zone04.gotoAndStop(1);
			allZones.fam_zone05.gotoAndStop(1);
		}
		
		/*
			if a family zone is moused over this event is called to make the zone appear larger
		*/
		public function zoneOver(evt:MouseEvent):void{
			evt.currentTarget.gotoAndStop(2);
		}
		
		/*
			when a family zone is no longer moused over it changes back to its mouse_out state
		*/
		public function zoneOut(evt:MouseEvent):void{
			evt.currentTarget.gotoAndStop(1);
		}
		
		/*
			This function is called from the instructions button and toggles the instruction screen, changes the start game button
			label to be "Resume Game" since this function can only be called during gameplay.
		*/
		public function instructOpen(evt:MouseEvent):void{
			instructions.visible = !instructions.visible;
			instructions.start_btn.label = "Resume Game";
			instructions.paused_txt.visible = true;
		}
		
		/*
			General use function for generating random numbers
		*/
		public function RandomNumber(low:Number=NaN, high:Number=NaN):Number{ //returns random number in between
			 var low:Number = low;
			 var high:Number = high;
	 		 if(isNaN(low)){	
			 	throw new Error("low must be defined");
	 		 }
	  		if(isNaN(high)) {	
				throw new Error("high must be defined");
	  		}
	  		return Math.round(Math.random() * (high - low)) + low;
		}

	}
	
}

