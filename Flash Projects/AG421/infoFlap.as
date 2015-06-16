/******************************************
Oregon State University Extended Campus 
-Designed and Written by: Thomas Emery and Warren Blyth
.created: February 10, 2010
.approved: 
.delivered: 
.edited: February 24, 2010 - warren
.edited: March 04, 2010 - Thomas
*******************************************/

package {
import flash.display.*;
import flash.events.*;	
import flash.utils.*; 		// for timer
import flash.media.*; 		// for sound
import flash.text.*; 		// for text field
import flash.net.*;

public class infoFlap extends MovieClip {
	static var emptyClip:MovieClip = new MovieClip(); // this stores all the objects used to create the info popup
	static var infoDisplay:MovieClip = new MovieClip();
	static var backGround:MovieClip = new MovieClip(); // will hold a giant rectangle that cover's all page content. added into emptyClip
	static var allInfoContent:MovieClip = new AllInfoExport();// creat instance of all the info, which we know is exported from .fla lib. added into emptyClip
	static var ecampusSite:URLRequest = new URLRequest("http://www.ecampus.oregonstate.edu");
	static var infoButton:MovieClip = new infoTab();

	public function infoFlap(){  	//initializer. Add invisible container to stage, and event listeners to visible "flap" button
		//this function is useless for calling
		}
	
	static function createInfo(STAGEH:Number,STAGEW:Number,INFOX:Number,INFOY:Number) { //prepares content that will be displayed when flap is clicked
		//draws white rectangle the size of the stage, then adds the allInfo movieclip from .fla library, then adds URL text
	//step1
		infoButton.x = INFOX; // gets the x position of the infoFlap
		infoButton.y = INFOY; // geta the y position fo the infoFlap
		infoButton.infoShown.visible = false;
		infoButton.showHide2.addEventListener(MouseEvent.MOUSE_OVER, littleHoverOn); //reveals orange "info" square, when infoTab is touched
		infoButton.infoText.addEventListener(MouseEvent.MOUSE_OVER,littleHoverOn);
		infoButton.infoShown.addEventListener(MouseEvent.MOUSE_OUT, littleHoverOff); //hides orange "info" square
		infoButton.addEventListener(MouseEvent.MOUSE_DOWN, infoClicked);	//reveals all the info
		infoButton.infoText.visible = false;
		infoButton.infoText.selectable = false;
		backGround.graphics.beginFill(0xFFFFFF);
		backGround.graphics.drawRect(0,0,STAGEW,STAGEH);
		backGround.graphics.endFill();
		backGround.alpha = 1;
		emptyClip.addChild(backGround);
	//step2
		emptyClip.addChild(allInfoContent);
		allInfoContent.visible = true; 	// this will hold everything, and made visible/invisible 
		allInfoContent.x = -5;
		allInfoContent.y = 0;
		allInfoContent.addEventListener(MouseEvent.CLICK, clearInfo); //this enables "clicking anywhere" action to remove emptyClip
		//step3
		//emptyClip.addChild(infoButton);
		infoButton.visible = false;
		allInfoContent.linkText.addEventListener(MouseEvent.CLICK, externalWebPage);
	}
	
	static function littleHoverOn(evt:MouseEvent){//flap hovering starts
		infoButton.infoShown.visible = true;
		infoButton.infoText.visible = true;
	}
	static function littleHoverOff(evt:MouseEvent){//flap hovering ends
		infoButton.infoShown.visible = false;
		infoButton.infoText.visible = false;
	}
	static function infoClicked(evt:MouseEvent){//flap is clicked, show the info
		allInfoContent.visible = true;
		infoButton.visible = false;
		backGround.visible = true
	}
	static function clearInfo(evt:MouseEvent){//once the info is clicked (anywhere), flap returns along with main content
		allInfoContent.visible = false;
		backGround.visible = false;
		infoButton.visible = true;
		infoButton.infoShown.visible = false;
		infoButton.infoText.visible = false;
	}
	static function externalWebPage(event):void {//open the ecampus website in a new window
		navigateToURL(ecampusSite);
	}
	
}  // end class
} // end package