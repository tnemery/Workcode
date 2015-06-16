/******************************************
Oregon State University Extended Campus 
-Designed and Written by: Thomas Emery
.created: November 29, 2010
.approved: 
.delivered: 
*******************************************/
package{
import fl.controls.*;
import flash.display.*;
import flash.events.*;
import flash.text.*; 		// for text field
	
public class AG421Leadership extends MovieClip{
	var lawScores:Array = new Array(21);
	var back:int = 0;
	var count:int = 0; //used for storing values into the array to keep track of answers
	var count2:int = 1; //used to step through the results
	var lastCount:int = 0;
	var ScoreArray:Array = new Array(63); //used to store answers
	var QuestionArray:Array = new Array("Q1","Q2","Q3","Q4","Q5","Q6","Q7","Q8",
										"Q9","Q10","Q11","Q12","Q13","Q14","Q15","Q16",
										"Q17","Q18","Q19","Q20","Q21","Q22","Q23","Q24",
										"Q25","Q26","Q27","Q28","Q29","Q30","Q31","Q32",
										"Q33","Q34","Q35","Q36","Q37","Q38","Q39","Q40",
										"Q41","Q42","Q43","Q44","Q45","Q46","Q47","Q48",
										"Q49","Q50","Q51","Q52","Q53","Q54","Q55","Q56",
										"Q57","Q58","Q59","Q60","Q61","Q62","Q63");
	var LawArray:Array = new Array("law1","law2","law3","law4","law5","law6",
								   "law7","law8","law9","law10","law11","law12",
								   "law13","law14","law15","law16","law17","law18",
								   "law19","law20","law21");
	var rbg1:RadioButtonGroup = new RadioButtonGroup("group1");
	var rbg2:RadioButtonGroup = new RadioButtonGroup("group2");
	var rbg3:RadioButtonGroup = new RadioButtonGroup("group3");
	var rbg4:RadioButtonGroup = new RadioButtonGroup("group4");
	var group1:int = 0;
	var group2:int = 0;
	var group3:int = 0;
	var group4:int = 0;
	
	public function AG421Leadership() {
		
		
		instruction2.visible = false; //setting everything up
		scoreBox.visible = false;
		Never.selected = true;
		Never.label = "Never";
		Never.value = 0;
		Rarely.label = "Rarely";
		Rarely.value = 1;
		Occasionally.label = "Occasionally";
		Occasionally.value = 2;
		Always.label = "Always";
		Always.value = 3;
		Occasionally.group = rbg1;
		Rarely.group = rbg1;
		Never.group = rbg1;
		Always.group = rbg1;
		
		Never2.selected = true;
		Never2.label = "Never";
		Rarely2.label = "Rarely";
		Occasionally2.label = "Occasionally";
		Always2.label = "Always";
		Occasionally2.group = rbg2;
		Rarely2.group = rbg2;
		Never2.group = rbg2;
		Always2.group = rbg2;
		
		Never3.selected = true;
		Never3.label = "Never";
		Rarely3.label = "Rarely";
		Occasionally3.label = "Occasionally";
		Always3.label = "Always";
		Occasionally3.group = rbg3;
		Rarely3.group = rbg3;
		Never3.group = rbg3;
		Always3.group = rbg3;
		
		Never4.selected = true;
		Never4.label = "Never";
		Rarely4.label = "Rarely";
		Occasionally4.label = "Occasionally";
		Always4.label = "Always";
		Occasionally4.group = rbg4;
		Rarely4.group = rbg4;
		Never4.group = rbg4;
		Always4.group = rbg4;
		
		
		Larrow.gotoAndStop(1);
		Rarrow.gotoAndStop(1);
		
		Never.addEventListener(MouseEvent.CLICK, NeverSel); //allows the radio buttons to be listened to
		Never2.addEventListener(MouseEvent.CLICK, NeverSel);
		Never3.addEventListener(MouseEvent.CLICK, NeverSel);
		Never4.addEventListener(MouseEvent.CLICK, NeverSel);
		Rarely.addEventListener(MouseEvent.CLICK, RarelySel);
		Rarely2.addEventListener(MouseEvent.CLICK, RarelySel);
		Rarely3.addEventListener(MouseEvent.CLICK, RarelySel);
		Rarely4.addEventListener(MouseEvent.CLICK, RarelySel);
		Occasionally.addEventListener(MouseEvent.CLICK, OccasionallySel);
		Occasionally2.addEventListener(MouseEvent.CLICK, OccasionallySel);
		Occasionally3.addEventListener(MouseEvent.CLICK, OccasionallySel);
		Occasionally4.addEventListener(MouseEvent.CLICK, OccasionallySel);
		Always.addEventListener(MouseEvent.CLICK, AlwaysSel);
		Always2.addEventListener(MouseEvent.CLICK, AlwaysSel);
		Always3.addEventListener(MouseEvent.CLICK, AlwaysSel);
		Always4.addEventListener(MouseEvent.CLICK, AlwaysSel);
		Larrow.addEventListener(MouseEvent.MOUSE_DOWN, backClicked);
		Rarrow.addEventListener(MouseEvent.MOUSE_DOWN, nextClicked);
		Larrow.addEventListener(MouseEvent.ROLL_OVER, LOVER);
		Larrow.addEventListener(MouseEvent.ROLL_OUT, LOUT);
		Rarrow.addEventListener(MouseEvent.ROLL_OVER, ROVER);
		Rarrow.addEventListener(MouseEvent.ROLL_OUT, ROUT);
		rbg1.addEventListener(MouseEvent.CLICK, dummyFunc);
		rbg2.addEventListener(MouseEvent.CLICK, dummyFunc);
	}
	
	
	public function dummyFunc(e:MouseEvent){
		trace(e.selectedData);
		trace(e.target.crazy + " "+e.currentTarget.crazy);
	}
	
	public function LOVER(event){
		Larrow.gotoAndStop(2);
	}
	
	public function LOUT(event){
		Larrow.gotoAndStop(1);
	}
	
	public function ROVER(event){
		Rarrow.gotoAndStop(2);
	}
	
	public function ROUT(event){
		Rarrow.gotoAndStop(1);
	}
		
		
	public function NeverSel(event){ //if never is selected then store the value in the appropriate spot in the array
		
			ScoreArray[count] = Never.value;
			count++;
			
	}
	
	public function RarelySel(event){ //same as previous function
		
		ScoreArray[count] = Rarely.value;
		count++;
	}
	public function OccasionallySel(event){ //same as previous function
		
		ScoreArray[count] = Occasionally.value;
		count++;
	}
	public function AlwaysSel(event){ //same as previous function
		
		ScoreArray[count] = Always.value;
		count++;
	}
	
	public function backClicked(event){
			
	}
	
	
	
	public function nextClicked(event){ //scrolls through the results when next is clicked
		//trace((count-lastCount)%4)
		if((count == lastCount) || ((count-lastCount)%4 != 0)){
			for(var t:int = count-lastCount;t<4;t++)
				{
					if(ScoreArray[count] != 0){}
					else{
						ScoreArray[count] = Never.value;
					}
					count++;
				}
				lastCount = count;
		}
		if(back == 0 && count != 60){
			trace(QuestionArray[count].name);
			this[QuestionArray[count]].x = 15;
			this[QuestionArray[count]].y = 37;
			this[QuestionArray[count-4]].x = 5000;
			trace(rbg1.selectedData);
			
			this[QuestionArray[count+1]].x = 15;
			this[QuestionArray[count+1]].y = 133;
			this[QuestionArray[count-3]].x = 5000;
			
			this[QuestionArray[count+2]].x = 15;
			this[QuestionArray[count+2]].y = 217;
			this[QuestionArray[count-2]].x = 5000;
			
			this[QuestionArray[count+3]].x = 15;
			this[QuestionArray[count+3]].y = 294;
			this[QuestionArray[count-1]].x = 5000;
			Never.selected = true;
			Never2.selected = true;
			Never3.selected = true;
			Never4.selected = true;
		}
		if(count == 60){
			this[QuestionArray[count]].x = 15;
			this[QuestionArray[count]].y = 37;
			this[QuestionArray[count-4]].x = 5000;
			
			this[QuestionArray[count+1]].x = 15;
			this[QuestionArray[count+1]].y = 133;
			this[QuestionArray[count-3]].x = 5000;
			
			this[QuestionArray[count+2]].x = 15;
			this[QuestionArray[count+2]].y = 217;
			this[QuestionArray[count-2]].x = 5000;
			
			this[QuestionArray[count-1]].x = 5000;
			Never.selected = true;
			Never2.selected = true;
			Never3.selected = true;
	
			Occasionally4.visible = false;
			Rarely4.visible = false;
			Never4.visible = false;
			Always4.visible = false;
		}
		
		lawScores[0] = ScoreArray[0]+ScoreArray[1]+ScoreArray[2]; //stores the scores into the appropriate law
		lawScores[1] = ScoreArray[3]+ScoreArray[4]+ScoreArray[5];
		lawScores[2] = ScoreArray[6]+ScoreArray[7]+ScoreArray[8];
		lawScores[3] = ScoreArray[9]+ScoreArray[10]+ScoreArray[11];
		lawScores[4] = ScoreArray[12]+ScoreArray[13]+ScoreArray[14];
		lawScores[5] = ScoreArray[15]+ScoreArray[16]+ScoreArray[17];
		lawScores[6] = ScoreArray[18]+ScoreArray[19]+ScoreArray[20];
		lawScores[7] = ScoreArray[21]+ScoreArray[22]+ScoreArray[23];
		lawScores[8] = ScoreArray[24]+ScoreArray[25]+ScoreArray[26];
		lawScores[9] = ScoreArray[27]+ScoreArray[28]+ScoreArray[29];
		lawScores[10] = ScoreArray[30]+ScoreArray[31]+ScoreArray[32];
		lawScores[11] = ScoreArray[33]+ScoreArray[34]+ScoreArray[35];
		lawScores[12] = ScoreArray[36]+ScoreArray[37]+ScoreArray[38];
		lawScores[13] = ScoreArray[39]+ScoreArray[40]+ScoreArray[41];
		lawScores[14] = ScoreArray[42]+ScoreArray[43]+ScoreArray[44];
		lawScores[15] = ScoreArray[45]+ScoreArray[46]+ScoreArray[47];
		lawScores[16] = ScoreArray[48]+ScoreArray[49]+ScoreArray[50];
		lawScores[17] = ScoreArray[51]+ScoreArray[52]+ScoreArray[53];
		lawScores[18] = ScoreArray[54]+ScoreArray[55]+ScoreArray[56];
		lawScores[19] = ScoreArray[57]+ScoreArray[58]+ScoreArray[59];
		lawScores[20] = ScoreArray[60]+ScoreArray[61]+ScoreArray[62];
		
		
		/*
		trace(count2);
		if(count2<20)
			count2++;
		
		if(count2>0 && back == 0){
			this[LawArray[count2]].x = 44;
			this[LawArray[count2]].y = 154;
			this[LawArray[count2-1]].x = 5000;
			scoreBox.text = String(lawScores[count2-1]);
		}
		if( back == 1){
			this[LawArray[count2]].x = 44;
			this[LawArray[count2]].y = 154;
			this[LawArray[count2+1]].x = 5000;
			scoreBox.text = String(lawScores[count2-1]);
			back = 0;
		}*/
	}
}
}