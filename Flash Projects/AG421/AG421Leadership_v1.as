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
import flash.geom.*;
import infoFlap;
	
public class AG421Leadership_v1 extends MovieClip{
	var lawScores:Array = new Array(21);
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
	var rbg1:RadioButtonGroup = new RadioButtonGroup("group1");
	var rbg2:RadioButtonGroup = new RadioButtonGroup("group2");
	var rbg3:RadioButtonGroup = new RadioButtonGroup("group3");
	var rbg4:RadioButtonGroup = new RadioButtonGroup("group4");
	var flag = 0;
	var testTransform:ColorTransform;
	
	
	public function AG421Leadership_v1() {
		infoFlap.createInfo(Number(stage.stageHeight),Number(stage.stageWidth),0,400);
		stage.addChild(infoFlap.emptyClip);
		stage.addChild(infoFlap.infoButton);
		
		Larrow.alpha = .3;
		LawClip.visible = false;
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
		Never2.value = 0;
		Rarely2.value = 1;
		Occasionally2.value = 2;
		Always2.value = 3;
		
		Never3.selected = true;
		Never3.label = "Never";
		Rarely3.label = "Rarely";
		Occasionally3.label = "Occasionally";
		Always3.label = "Always";
		Occasionally3.group = rbg3;
		Rarely3.group = rbg3;
		Never3.group = rbg3;
		Always3.group = rbg3;
		Never3.value = 0;
		Rarely3.value = 1;
		Occasionally3.value = 2;
		Always3.value = 3;
		
		Never4.selected = true;
		Never4.label = "Never";
		Rarely4.label = "Rarely";
		Occasionally4.label = "Occasionally";
		Always4.label = "Always";
		Occasionally4.group = rbg4;
		Rarely4.group = rbg4;
		Never4.group = rbg4;
		Always4.group = rbg4;
		Never4.value = 0;
		Rarely4.value = 1;
		Occasionally4.value = 2;
		Always4.value = 3;
		
		
		Larrow.gotoAndStop(1);
		Rarrow.gotoAndStop(1);
		
		
		Larrow.addEventListener(MouseEvent.MOUSE_DOWN, backClicked);
		Rarrow.addEventListener(MouseEvent.MOUSE_DOWN, nextClicked);
		Larrow.addEventListener(MouseEvent.ROLL_OVER, LOVER);
		Larrow.addEventListener(MouseEvent.ROLL_OUT, LOUT);
		Rarrow.addEventListener(MouseEvent.ROLL_OVER, ROVER);
		Rarrow.addEventListener(MouseEvent.ROLL_OUT, ROUT);
		
		LawClip.square1.addEventListener(MouseEvent.ROLL_OVER, Law1Over);
		LawClip.square1.addEventListener(MouseEvent.ROLL_OUT, Law1Out);
		LawClip.scoreBox01.addEventListener(MouseEvent.ROLL_OVER, Law1Over);
		LawClip.scoreBox01.addEventListener(MouseEvent.ROLL_OUT, Law1Out);
		LawClip.Lid.addEventListener(MouseEvent.ROLL_OVER, Law1Over);
		LawClip.Lid.addEventListener(MouseEvent.ROLL_OUT, Law1Out);
		
		LawClip.square2.addEventListener(MouseEvent.ROLL_OVER, Law2Over);
		LawClip.square2.addEventListener(MouseEvent.ROLL_OUT, Law2Out);
		LawClip.scoreBox02.addEventListener(MouseEvent.ROLL_OVER, Law2Over);
		LawClip.scoreBox02.addEventListener(MouseEvent.ROLL_OUT, Law2Out);
		LawClip.Influence.addEventListener(MouseEvent.ROLL_OVER, Law2Over);
		LawClip.Influence.addEventListener(MouseEvent.ROLL_OUT, Law2Out);
		
		LawClip.square3.addEventListener(MouseEvent.ROLL_OVER, Law3Over);
		LawClip.square3.addEventListener(MouseEvent.ROLL_OUT, Law3Out);
		LawClip.scoreBox03.addEventListener(MouseEvent.ROLL_OVER, Law3Over);
		LawClip.scoreBox03.addEventListener(MouseEvent.ROLL_OUT, Law3Out);
		LawClip.Process.addEventListener(MouseEvent.ROLL_OVER, Law3Over);
		LawClip.Process.addEventListener(MouseEvent.ROLL_OUT, Law3Out);
		
		LawClip.square4.addEventListener(MouseEvent.ROLL_OVER, Law4Over);
		LawClip.square4.addEventListener(MouseEvent.ROLL_OUT, Law4Out);
		LawClip.scoreBox04.addEventListener(MouseEvent.ROLL_OVER, Law4Over);
		LawClip.scoreBox04.addEventListener(MouseEvent.ROLL_OUT, Law4Out);
		LawClip.Navigation.addEventListener(MouseEvent.ROLL_OVER, Law4Over);
		LawClip.Navigation.addEventListener(MouseEvent.ROLL_OUT, Law4Out);
		
		LawClip.square5.addEventListener(MouseEvent.ROLL_OVER, Law5Over);
		LawClip.square5.addEventListener(MouseEvent.ROLL_OUT, Law5Out);
		LawClip.scoreBox05.addEventListener(MouseEvent.ROLL_OVER, Law5Over);
		LawClip.scoreBox05.addEventListener(MouseEvent.ROLL_OUT, Law5Out);
		LawClip.Addition.addEventListener(MouseEvent.ROLL_OVER, Law5Over);
		LawClip.Addition.addEventListener(MouseEvent.ROLL_OUT, Law5Out);
		
		LawClip.square6.addEventListener(MouseEvent.ROLL_OVER, Law6Over);
		LawClip.square6.addEventListener(MouseEvent.ROLL_OUT, Law6Out);
		LawClip.scoreBox06.addEventListener(MouseEvent.ROLL_OVER, Law6Over);
		LawClip.scoreBox06.addEventListener(MouseEvent.ROLL_OUT, Law6Out);
		LawClip.Solid.addEventListener(MouseEvent.ROLL_OVER, Law6Over);
		LawClip.Solid.addEventListener(MouseEvent.ROLL_OUT, Law6Out);
		
		LawClip.square7.addEventListener(MouseEvent.ROLL_OVER, Law7Over);
		LawClip.square7.addEventListener(MouseEvent.ROLL_OUT, Law7Out);
		LawClip.scoreBox07.addEventListener(MouseEvent.ROLL_OVER, Law7Over);
		LawClip.scoreBox07.addEventListener(MouseEvent.ROLL_OUT, Law7Out);
		LawClip.Respect.addEventListener(MouseEvent.ROLL_OVER, Law7Over);
		LawClip.Respect.addEventListener(MouseEvent.ROLL_OUT, Law7Out);
		
		LawClip.square8.addEventListener(MouseEvent.ROLL_OVER, Law8Over);
		LawClip.square8.addEventListener(MouseEvent.ROLL_OUT, Law8Out);
		LawClip.scoreBox08.addEventListener(MouseEvent.ROLL_OVER, Law8Over);
		LawClip.scoreBox08.addEventListener(MouseEvent.ROLL_OUT, Law8Out);
		LawClip.Intuition.addEventListener(MouseEvent.ROLL_OVER, Law8Over);
		LawClip.Intuition.addEventListener(MouseEvent.ROLL_OUT, Law8Out);
		
		LawClip.square9.addEventListener(MouseEvent.ROLL_OVER, Law9Over);
		LawClip.square9.addEventListener(MouseEvent.ROLL_OUT, Law9Out);
		LawClip.scoreBox09.addEventListener(MouseEvent.ROLL_OVER, Law9Over);
		LawClip.scoreBox09.addEventListener(MouseEvent.ROLL_OUT, Law9Out);
		LawClip.Magnetism.addEventListener(MouseEvent.ROLL_OVER, Law9Over);
		LawClip.Magnetism.addEventListener(MouseEvent.ROLL_OUT, Law9Out);
		
		LawClip.square10.addEventListener(MouseEvent.ROLL_OVER, Law10Over);
		LawClip.square10.addEventListener(MouseEvent.ROLL_OUT, Law10Out);
		LawClip.scoreBox10.addEventListener(MouseEvent.ROLL_OVER, Law10Over);
		LawClip.scoreBox10.addEventListener(MouseEvent.ROLL_OUT, Law10Out);
		LawClip.Connection.addEventListener(MouseEvent.ROLL_OVER, Law10Over);
		LawClip.Connection.addEventListener(MouseEvent.ROLL_OUT, Law10Out);
		
		LawClip.square11.addEventListener(MouseEvent.ROLL_OVER, Law11Over);
		LawClip.square11.addEventListener(MouseEvent.ROLL_OUT, Law11Out);
		LawClip.scoreBox11.addEventListener(MouseEvent.ROLL_OVER, Law11Over);
		LawClip.scoreBox11.addEventListener(MouseEvent.ROLL_OUT, Law11Out);
		LawClip.Inner.addEventListener(MouseEvent.ROLL_OVER, Law11Over);
		LawClip.Inner.addEventListener(MouseEvent.ROLL_OUT, Law11Out);
		
		LawClip.square12.addEventListener(MouseEvent.ROLL_OVER, Law12Over);
		LawClip.square12.addEventListener(MouseEvent.ROLL_OUT, Law12Out);
		LawClip.scoreBox12.addEventListener(MouseEvent.ROLL_OVER, Law12Over);
		LawClip.scoreBox12.addEventListener(MouseEvent.ROLL_OUT, Law12Out);
		LawClip.Empowerment.addEventListener(MouseEvent.ROLL_OVER, Law12Over);
		LawClip.Empowerment.addEventListener(MouseEvent.ROLL_OUT, Law12Out);
		
		LawClip.square13.addEventListener(MouseEvent.ROLL_OVER, Law13Over);
		LawClip.square13.addEventListener(MouseEvent.ROLL_OUT, Law13Out);
		LawClip.scoreBox13.addEventListener(MouseEvent.ROLL_OVER, Law13Over);
		LawClip.scoreBox13.addEventListener(MouseEvent.ROLL_OUT, Law13Out);
		LawClip.Picture.addEventListener(MouseEvent.ROLL_OVER, Law13Over);
		LawClip.Picture.addEventListener(MouseEvent.ROLL_OUT, Law13Out);
		
		LawClip.square14.addEventListener(MouseEvent.ROLL_OVER, Law14Over);
		LawClip.square14.addEventListener(MouseEvent.ROLL_OUT, Law14Out);
		LawClip.scoreBox14.addEventListener(MouseEvent.ROLL_OVER, Law14Over);
		LawClip.scoreBox14.addEventListener(MouseEvent.ROLL_OUT, Law14Out);
		LawClip.Buy.addEventListener(MouseEvent.ROLL_OVER, Law14Over);
		LawClip.Buy.addEventListener(MouseEvent.ROLL_OUT, Law14Out);
		
		LawClip.square15.addEventListener(MouseEvent.ROLL_OVER, Law15Over);
		LawClip.square15.addEventListener(MouseEvent.ROLL_OUT, Law15Out);
		LawClip.scoreBox15.addEventListener(MouseEvent.ROLL_OVER, Law15Over);
		LawClip.scoreBox15.addEventListener(MouseEvent.ROLL_OUT, Law15Out);
		LawClip.Victory.addEventListener(MouseEvent.ROLL_OVER, Law15Over);
		LawClip.Victory.addEventListener(MouseEvent.ROLL_OUT, Law15Out);
		
		LawClip.square16.addEventListener(MouseEvent.ROLL_OVER, Law16Over);
		LawClip.square16.addEventListener(MouseEvent.ROLL_OUT, Law16Out);
		LawClip.scoreBox16.addEventListener(MouseEvent.ROLL_OVER, Law16Over);
		LawClip.scoreBox16.addEventListener(MouseEvent.ROLL_OUT, Law16Out);
		LawClip.Big.addEventListener(MouseEvent.ROLL_OVER, Law16Over);
		LawClip.Big.addEventListener(MouseEvent.ROLL_OUT, Law16Out);
		
		LawClip.square17.addEventListener(MouseEvent.ROLL_OVER, Law17Over);
		LawClip.square17.addEventListener(MouseEvent.ROLL_OUT, Law17Out);
		LawClip.scoreBox17.addEventListener(MouseEvent.ROLL_OVER, Law17Over);
		LawClip.scoreBox17.addEventListener(MouseEvent.ROLL_OUT, Law17Out);
		LawClip.Priorities.addEventListener(MouseEvent.ROLL_OVER, Law17Over);
		LawClip.Priorities.addEventListener(MouseEvent.ROLL_OUT, Law17Out);
		
		LawClip.square18.addEventListener(MouseEvent.ROLL_OVER, Law18Over);
		LawClip.square18.addEventListener(MouseEvent.ROLL_OUT, Law18Out);
		LawClip.scoreBox18.addEventListener(MouseEvent.ROLL_OVER, Law18Over);
		LawClip.scoreBox18.addEventListener(MouseEvent.ROLL_OUT, Law18Out);
		LawClip.Sacrifice.addEventListener(MouseEvent.ROLL_OVER, Law18Over);
		LawClip.Sacrifice.addEventListener(MouseEvent.ROLL_OUT, Law18Out);
		
		LawClip.square19.addEventListener(MouseEvent.ROLL_OVER, Law19Over);
		LawClip.square19.addEventListener(MouseEvent.ROLL_OUT, Law19Out);
		LawClip.scoreBox19.addEventListener(MouseEvent.ROLL_OVER, Law19Over);
		LawClip.scoreBox19.addEventListener(MouseEvent.ROLL_OUT, Law19Out);
		LawClip.Timing.addEventListener(MouseEvent.ROLL_OVER, Law19Over);
		LawClip.Timing.addEventListener(MouseEvent.ROLL_OUT, Law19Out);
		
		LawClip.square20.addEventListener(MouseEvent.ROLL_OVER, Law20Over);
		LawClip.square20.addEventListener(MouseEvent.ROLL_OUT, Law20Out);
		LawClip.scoreBox20.addEventListener(MouseEvent.ROLL_OVER, Law20Over);
		LawClip.scoreBox20.addEventListener(MouseEvent.ROLL_OUT, Law20Out);
		LawClip.Explosive.addEventListener(MouseEvent.ROLL_OVER, Law20Over);
		LawClip.Explosive.addEventListener(MouseEvent.ROLL_OUT, Law20Out);
		
		LawClip.square21.addEventListener(MouseEvent.ROLL_OVER, Law21Over);
		LawClip.square21.addEventListener(MouseEvent.ROLL_OUT, Law21Out);
		LawClip.scoreBox21.addEventListener(MouseEvent.ROLL_OVER, Law21Over);
		LawClip.scoreBox21.addEventListener(MouseEvent.ROLL_OUT, Law21Out);
		LawClip.Legacy.addEventListener(MouseEvent.ROLL_OVER, Law21Over);
		LawClip.Legacy.addEventListener(MouseEvent.ROLL_OUT, Law21Out);
		
		
		
		
		LawClip.square1.addEventListener(MouseEvent.CLICK, Law1);
		LawClip.square2.addEventListener(MouseEvent.CLICK, Law2);
		LawClip.square3.addEventListener(MouseEvent.CLICK, Law3);
		LawClip.square4.addEventListener(MouseEvent.CLICK, Law4);
		LawClip.square5.addEventListener(MouseEvent.CLICK, Law5);
		LawClip.square6.addEventListener(MouseEvent.CLICK, Law6);
		LawClip.square7.addEventListener(MouseEvent.CLICK, Law7);
		LawClip.square8.addEventListener(MouseEvent.CLICK, Law8);
		LawClip.square9.addEventListener(MouseEvent.CLICK, Law9);
		LawClip.square10.addEventListener(MouseEvent.CLICK, Law10);
		LawClip.square11.addEventListener(MouseEvent.CLICK, Law11);
		LawClip.square12.addEventListener(MouseEvent.CLICK, Law12);
		LawClip.square13.addEventListener(MouseEvent.CLICK, Law13);
		LawClip.square14.addEventListener(MouseEvent.CLICK, Law14);
		LawClip.square15.addEventListener(MouseEvent.CLICK, Law15);
		LawClip.square16.addEventListener(MouseEvent.CLICK, Law16);
		LawClip.square17.addEventListener(MouseEvent.CLICK, Law17);
		LawClip.square18.addEventListener(MouseEvent.CLICK, Law18);
		LawClip.square19.addEventListener(MouseEvent.CLICK, Law19);
		LawClip.square20.addEventListener(MouseEvent.CLICK, Law20);
		LawClip.square21.addEventListener(MouseEvent.CLICK, Law21);
		LawClip.scoreBox01.addEventListener(MouseEvent.CLICK, Law1);
		LawClip.scoreBox02.addEventListener(MouseEvent.CLICK, Law2);
		LawClip.scoreBox03.addEventListener(MouseEvent.CLICK, Law3);
		LawClip.scoreBox04.addEventListener(MouseEvent.CLICK, Law4);
		LawClip.scoreBox05.addEventListener(MouseEvent.CLICK, Law5);
		LawClip.scoreBox06.addEventListener(MouseEvent.CLICK, Law6);
		LawClip.scoreBox07.addEventListener(MouseEvent.CLICK, Law7);
		LawClip.scoreBox08.addEventListener(MouseEvent.CLICK, Law8);
		LawClip.scoreBox09.addEventListener(MouseEvent.CLICK, Law9);
		LawClip.scoreBox10.addEventListener(MouseEvent.CLICK, Law10);
		LawClip.scoreBox11.addEventListener(MouseEvent.CLICK, Law11);
		LawClip.scoreBox12.addEventListener(MouseEvent.CLICK, Law12);
		LawClip.scoreBox13.addEventListener(MouseEvent.CLICK, Law13);
		LawClip.scoreBox14.addEventListener(MouseEvent.CLICK, Law14);
		LawClip.scoreBox15.addEventListener(MouseEvent.CLICK, Law15);
		LawClip.scoreBox16.addEventListener(MouseEvent.CLICK, Law16);
		LawClip.scoreBox17.addEventListener(MouseEvent.CLICK, Law17);
		LawClip.scoreBox18.addEventListener(MouseEvent.CLICK, Law18);
		LawClip.scoreBox19.addEventListener(MouseEvent.CLICK, Law19);
		LawClip.scoreBox20.addEventListener(MouseEvent.CLICK, Law20);
		LawClip.scoreBox21.addEventListener(MouseEvent.CLICK, Law21);
		LawClip.Lid.addEventListener(MouseEvent.CLICK, Law1);
		LawClip.Influence.addEventListener(MouseEvent.CLICK, Law2);
		LawClip.Process.addEventListener(MouseEvent.CLICK, Law3);
		LawClip.Navigation.addEventListener(MouseEvent.CLICK, Law4);
		LawClip.Addition.addEventListener(MouseEvent.CLICK, Law5);
		LawClip.Solid.addEventListener(MouseEvent.CLICK, Law6);
		LawClip.Respect.addEventListener(MouseEvent.CLICK, Law7);
		LawClip.Intuition.addEventListener(MouseEvent.CLICK, Law8);
		LawClip.Magnetism.addEventListener(MouseEvent.CLICK, Law9);
		LawClip.Connection.addEventListener(MouseEvent.CLICK, Law10);
		LawClip.Inner.addEventListener(MouseEvent.CLICK, Law11);
		LawClip.Empowerment.addEventListener(MouseEvent.CLICK, Law12);
		LawClip.Picture.addEventListener(MouseEvent.CLICK, Law13);
		LawClip.Buy.addEventListener(MouseEvent.CLICK, Law14);
		LawClip.Victory.addEventListener(MouseEvent.CLICK, Law15);
		LawClip.Big.addEventListener(MouseEvent.CLICK, Law16);
		LawClip.Priorities.addEventListener(MouseEvent.CLICK, Law17);
		LawClip.Sacrifice.addEventListener(MouseEvent.CLICK, Law18);
		LawClip.Timing.addEventListener(MouseEvent.CLICK, Law19);
		LawClip.Explosive.addEventListener(MouseEvent.CLICK, Law20);
		LawClip.Legacy.addEventListener(MouseEvent.CLICK, Law21);
	}
	
	public function Law1Over(event){
		LawClip.square1.scaleX = 1.1;
		LawClip.square1.scaleY = 1.1;
		LawClip.Lid.scaleX = 1.1;
		LawClip.Lid.scaleY = 1.1;
		LawClip.scoreBox01.scaleX = 1.1;
		LawClip.scoreBox01.scaleY = 1.1;
	}
	
	public function Law1Out(event){
		LawClip.square1.scaleX = 1;
		LawClip.square1.scaleY = 1;
		LawClip.Lid.scaleX = 1;
		LawClip.Lid.scaleY = 1;
		LawClip.scoreBox01.scaleX = 1;
		LawClip.scoreBox01.scaleY = 1;
	}
	
	public function Law2Over(event){
		LawClip.square2.scaleX = 1.1;
		LawClip.square2.scaleY = 1.1;
		LawClip.Influence.scaleX = 1.1;
		LawClip.Influence.scaleY = 1.1;
		LawClip.scoreBox02.scaleX = 1.1;
		LawClip.scoreBox02.scaleY = 1.1;
	}
	
	public function Law2Out(event){
		LawClip.square2.scaleX = 1;
		LawClip.square2.scaleY = 1;
		LawClip.Influence.scaleX = 1;
		LawClip.Influence.scaleY = 1;
		LawClip.scoreBox02.scaleX = 1;
		LawClip.scoreBox02.scaleY = 1;
	}
	
	public function Law3Over(event){
		LawClip.square3.scaleX = 1.1;
		LawClip.square3.scaleY = 1.1;
		LawClip.Process.scaleX = 1.1;
		LawClip.Process.scaleY = 1.1;
		LawClip.scoreBox03.scaleX = 1.1;
		LawClip.scoreBox03.scaleY = 1.1;
	}
	
	public function Law3Out(event){
		LawClip.square3.scaleX = 1;
		LawClip.square3.scaleY = 1;
		LawClip.Process.scaleX = 1;
		LawClip.Process.scaleY = 1;
		LawClip.scoreBox03.scaleX = 1;
		LawClip.scoreBox03.scaleY = 1;
	}
	
	public function Law4Over(event){
		LawClip.square4.scaleX = 1.1;
		LawClip.square4.scaleY = 1.1;
		LawClip.Navigation.scaleX = 1.1;
		LawClip.Navigation.scaleY = 1.1;
		LawClip.scoreBox04.scaleX = 1.1;
		LawClip.scoreBox04.scaleY = 1.1;
	}
	
	public function Law4Out(event){
		LawClip.square4.scaleX = 1;
		LawClip.square4.scaleY = 1;
		LawClip.Navigation.scaleX = 1;
		LawClip.Navigation.scaleY = 1;
		LawClip.scoreBox04.scaleX = 1;
		LawClip.scoreBox04.scaleY = 1;
	}
	
	public function Law5Over(event){
		LawClip.square5.scaleX = 1.1;
		LawClip.square5.scaleY = 1.1;
		LawClip.Addition.scaleX = 1.1;
		LawClip.Addition.scaleY = 1.1;
		LawClip.scoreBox05.scaleX = 1.1;
		LawClip.scoreBox05.scaleY = 1.1;
	}
	
	public function Law5Out(event){
		LawClip.square5.scaleX = 1;
		LawClip.square5.scaleY = 1;
		LawClip.Addition.scaleX = 1;
		LawClip.Addition.scaleY = 1;
		LawClip.scoreBox05.scaleX = 1;
		LawClip.scoreBox05.scaleY = 1;
	}
	
	public function Law6Over(event){
		LawClip.square6.scaleX = 1.1;
		LawClip.square6.scaleY = 1.1;
		LawClip.Solid.scaleX = 1.1;
		LawClip.Solid.scaleY = 1.1;
		LawClip.scoreBox06.scaleX = 1.1;
		LawClip.scoreBox06.scaleY = 1.1;
	}
	
	public function Law6Out(event){
		LawClip.square6.scaleX = 1;
		LawClip.square6.scaleY = 1;
		LawClip.Solid.scaleX = 1;
		LawClip.Solid.scaleY = 1;
		LawClip.scoreBox06.scaleX = 1;
		LawClip.scoreBox06.scaleY = 1;
	}
	
	public function Law7Over(event){
		LawClip.square7.scaleX = 1.1;
		LawClip.square7.scaleY = 1.1;
		LawClip.Respect.scaleX = 1.1;
		LawClip.Respect.scaleY = 1.1;
		LawClip.scoreBox07.scaleX = 1.1;
		LawClip.scoreBox07.scaleY = 1.1;
	}
	
	public function Law7Out(event){
		LawClip.square7.scaleX = 1;
		LawClip.square7.scaleY = 1;
		LawClip.Respect.scaleX = 1;
		LawClip.Respect.scaleY = 1;
		LawClip.scoreBox07.scaleX = 1;
		LawClip.scoreBox07.scaleY = 1;
	}
	
	public function Law8Over(event){
		LawClip.square8.scaleX = 1.1;
		LawClip.square8.scaleY = 1.1;
		LawClip.Intuition.scaleX = 1.1;
		LawClip.Intuition.scaleY = 1.1;
		LawClip.scoreBox08.scaleX = 1.1;
		LawClip.scoreBox08.scaleY = 1.1;
	}
	
	public function Law8Out(event){
		LawClip.square8.scaleX = 1;
		LawClip.square8.scaleY = 1;
		LawClip.Intuition.scaleX = 1;
		LawClip.Intuition.scaleY = 1;
		LawClip.scoreBox08.scaleX = 1;
		LawClip.scoreBox08.scaleY = 1;
	}
	
	public function Law9Over(event){
		LawClip.square9.scaleX = 1.1;
		LawClip.square9.scaleY = 1.1;
		LawClip.Magnetism.scaleX = 1.1;
		LawClip.Magnetism.scaleY = 1.1;
		LawClip.scoreBox09.scaleX = 1.1;
		LawClip.scoreBox09.scaleY = 1.1;
	}
	
	public function Law9Out(event){
		LawClip.square9.scaleX = 1;
		LawClip.square9.scaleY = 1;
		LawClip.Magnetism.scaleX = 1;
		LawClip.Magnetism.scaleY = 1;
		LawClip.scoreBox09.scaleX = 1;
		LawClip.scoreBox09.scaleY = 1;
	}
	
	public function Law10Over(event){
		LawClip.square10.scaleX = 1.1;
		LawClip.square10.scaleY = 1.1;
		LawClip.Connection.scaleX = 1.1;
		LawClip.Connection.scaleY = 1.1;
		LawClip.scoreBox10.scaleX = 1.1;
		LawClip.scoreBox10.scaleY = 1.1;
	}
	
	public function Law10Out(event){
		LawClip.square10.scaleX = 1;
		LawClip.square10.scaleY = 1;
		LawClip.Connection.scaleX = 1;
		LawClip.Connection.scaleY = 1;
		LawClip.scoreBox10.scaleX = 1;
		LawClip.scoreBox10.scaleY = 1;
	}
	
	public function Law11Over(event){
		LawClip.square11.scaleX = 1.1;
		LawClip.square11.scaleY = 1.1;
		LawClip.Inner.scaleX = 1.1;
		LawClip.Inner.scaleY = 1.1;
		LawClip.scoreBox11.scaleX = 1.1;
		LawClip.scoreBox11.scaleY = 1.1;
	}
	
	public function Law11Out(event){
		LawClip.square11.scaleX = 1;
		LawClip.square11.scaleY = 1;
		LawClip.Inner.scaleX = 1;
		LawClip.Inner.scaleY = 1;
		LawClip.scoreBox11.scaleX = 1;
		LawClip.scoreBox11.scaleY = 1;
	}
	
	public function Law12Over(event){
		LawClip.square12.scaleX = 1.1;
		LawClip.square12.scaleY = 1.1;
		LawClip.Empowerment.scaleX = 1.1;
		LawClip.Empowerment.scaleY = 1.1;
		LawClip.scoreBox12.scaleX = 1.1;
		LawClip.scoreBox12.scaleY = 1.1;
	}
	
	public function Law12Out(event){
		LawClip.square12.scaleX = 1;
		LawClip.square12.scaleY = 1;
		LawClip.Empowerment.scaleX = 1;
		LawClip.Empowerment.scaleY = 1;
		LawClip.scoreBox12.scaleX = 1;
		LawClip.scoreBox12.scaleY = 1;
	}
	
	public function Law13Over(event){
		LawClip.square13.scaleX = 1.1;
		LawClip.square13.scaleY = 1.1;
		LawClip.Picture.scaleX = 1.1;
		LawClip.Picture.scaleY = 1.1;
		LawClip.scoreBox13.scaleX = 1.1;
		LawClip.scoreBox13.scaleY = 1.1;
	}
	
	public function Law13Out(event){
		LawClip.square13.scaleX = 1;
		LawClip.square13.scaleY = 1;
		LawClip.Picture.scaleX = 1;
		LawClip.Picture.scaleY = 1;
		LawClip.scoreBox13.scaleX = 1;
		LawClip.scoreBox13.scaleY = 1;
	}
	
	public function Law14Over(event){
		LawClip.square14.scaleX = 1.1;
		LawClip.square14.scaleY = 1.1;
		LawClip.Buy.scaleX = 1.1;
		LawClip.Buy.scaleY = 1.1;
		LawClip.scoreBox14.scaleX = 1.1;
		LawClip.scoreBox14.scaleY = 1.1;
	}
	
	public function Law14Out(event){
		LawClip.square14.scaleX = 1;
		LawClip.square14.scaleY = 1;
		LawClip.Buy.scaleX = 1;
		LawClip.Buy.scaleY = 1;
		LawClip.scoreBox14.scaleX = 1;
		LawClip.scoreBox14.scaleY = 1;
	}
	
	public function Law15Over(event){
		LawClip.square15.scaleX = 1.1;
		LawClip.square15.scaleY = 1.1;
		LawClip.Victory.scaleX = 1.1;
		LawClip.Victory.scaleY = 1.1;
		LawClip.scoreBox15.scaleX = 1.1;
		LawClip.scoreBox15.scaleY = 1.1;
	}
	
	public function Law15Out(event){
		LawClip.square15.scaleX = 1;
		LawClip.square15.scaleY = 1;
		LawClip.Victory.scaleX = 1;
		LawClip.Victory.scaleY = 1;
		LawClip.scoreBox15.scaleX = 1;
		LawClip.scoreBox15.scaleY = 1;
	}
	
	public function Law16Over(event){
		LawClip.square16.scaleX = 1.1;
		LawClip.square16.scaleY = 1.1;
		LawClip.Big.scaleX = 1.1;
		LawClip.Big.scaleY = 1.1;
		LawClip.scoreBox16.scaleX = 1.1;
		LawClip.scoreBox16.scaleY = 1.1;
	}
	
	public function Law16Out(event){
		LawClip.square16.scaleX = 1;
		LawClip.square16.scaleY = 1;
		LawClip.Big.scaleX = 1;
		LawClip.Big.scaleY = 1;
		LawClip.scoreBox16.scaleX = 1;
		LawClip.scoreBox16.scaleY = 1;
	}
	
	public function Law17Over(event){
		LawClip.square17.scaleX = 1.1;
		LawClip.square17.scaleY = 1.1;
		LawClip.Priorities.scaleX = 1.1;
		LawClip.Priorities.scaleY = 1.1;
		LawClip.scoreBox17.scaleX = 1.1;
		LawClip.scoreBox17.scaleY = 1.1;
	}
	
	public function Law17Out(event){
		LawClip.square17.scaleX = 1;
		LawClip.square17.scaleY = 1;
		LawClip.Priorities.scaleX = 1;
		LawClip.Priorities.scaleY = 1;
		LawClip.scoreBox17.scaleX = 1;
		LawClip.scoreBox17.scaleY = 1;
	}
	
	public function Law18Over(event){
		LawClip.square18.scaleX = 1.1;
		LawClip.square18.scaleY = 1.1;
		LawClip.Sacrifice.scaleX = 1.1;
		LawClip.Sacrifice.scaleY = 1.1;
		LawClip.scoreBox18.scaleX = 1.1;
		LawClip.scoreBox18.scaleY = 1.1;
	}
	
	public function Law18Out(event){
		LawClip.square18.scaleX = 1;
		LawClip.square18.scaleY = 1;
		LawClip.Sacrifice.scaleX = 1;
		LawClip.Sacrifice.scaleY = 1;
		LawClip.scoreBox18.scaleX = 1;
		LawClip.scoreBox18.scaleY = 1;
	}
	
	public function Law19Over(event){
		LawClip.square19.scaleX = 1.1;
		LawClip.square19.scaleY = 1.1;
		LawClip.Timing.scaleX = 1.1;
		LawClip.Timing.scaleY = 1.1;
		LawClip.scoreBox19.scaleX = 1.1;
		LawClip.scoreBox19.scaleY = 1.1;
	}
	
	public function Law19Out(event){
		LawClip.square19.scaleX = 1;
		LawClip.square19.scaleY = 1;
		LawClip.Timing.scaleX = 1;
		LawClip.Timing.scaleY = 1;
		LawClip.scoreBox19.scaleX = 1;
		LawClip.scoreBox19.scaleY = 1;
	}
	
	public function Law20Over(event){
		LawClip.square20.scaleX = 1.1;
		LawClip.square20.scaleY = 1.1;
		LawClip.Explosive.scaleX = 1.1;
		LawClip.Explosive.scaleY = 1.1;
		LawClip.scoreBox20.scaleX = 1.1;
		LawClip.scoreBox20.scaleY = 1.1;
	}
	
	public function Law20Out(event){
		LawClip.square20.scaleX = 1;
		LawClip.square20.scaleY = 1;
		LawClip.Explosive.scaleX = 1;
		LawClip.Explosive.scaleY = 1;
		LawClip.scoreBox20.scaleX = 1;
		LawClip.scoreBox20.scaleY = 1;
	}
	
	public function Law21Over(event){
		LawClip.square21.scaleX = 1.1;
		LawClip.square21.scaleY = 1.1;
		LawClip.Legacy.scaleX = 1.1;
		LawClip.Legacy.scaleY = 1.1;
		LawClip.scoreBox21.scaleX = 1.1;
		LawClip.scoreBox21.scaleY = 1.1;
	}
	
	public function Law21Out(event){
		LawClip.square21.scaleX = 1;
		LawClip.square21.scaleY = 1;
		LawClip.Legacy.scaleX = 1;
		LawClip.Legacy.scaleY = 1;
		LawClip.scoreBox21.scaleX = 1;
		LawClip.scoreBox21.scaleY = 1;
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
	
	public function backClicked(event){
		if(count == 60 && this[QuestionArray[56]].x != 15){
			count -= 4;
			this[QuestionArray[56]].x = 15;
			this[QuestionArray[56]].y = 37;
			this[QuestionArray[60]].x = 5000;
			
			this[QuestionArray[57]].x = 15;
			this[QuestionArray[57]].y = 133;
			this[QuestionArray[61]].x = 5000;
			
			this[QuestionArray[58]].x = 15;
			this[QuestionArray[58]].y = 217;
			this[QuestionArray[62]].x = 5000;
			
			this[QuestionArray[59]].x = 15;
			this[QuestionArray[59]].y = 294;
			rbg1.selectedData = ScoreArray[count];
			rbg2.selectedData = ScoreArray[count+1];
			rbg3.selectedData = ScoreArray[count+2];
			rbg4.selectedData = ScoreArray[count+3];
			Occasionally4.visible = true;
			Rarely4.visible = true;
			Never4.visible = true;
			Always4.visible = true;
			Rarrow.visible = true;
			flag = 0;
			
		}
		else if(count > 0)
		{
			if(count == 4){
				Larrow.alpha = .3;
			}
			else{
				Larrow.alpha = 1;
			}
			count -= 4;
		
			this[QuestionArray[count]].x = 15;
			this[QuestionArray[count]].y = 37;
			this[QuestionArray[count+4]].x = 5000;
			
			this[QuestionArray[count+1]].x = 15;
			this[QuestionArray[count+1]].y = 133;
			this[QuestionArray[count+5]].x = 5000;
			
			this[QuestionArray[count+2]].x = 15;
			this[QuestionArray[count+2]].y = 217;
			this[QuestionArray[count+6]].x = 5000;
			
			this[QuestionArray[count+3]].x = 15;
			this[QuestionArray[count+3]].y = 294;
			this[QuestionArray[count+7]].x = 5000;
			rbg1.selectedData = ScoreArray[count];
			rbg2.selectedData = ScoreArray[count+1];
			rbg3.selectedData = ScoreArray[count+2];
			rbg4.selectedData = ScoreArray[count+3];
			Occasionally4.visible = true;
			Rarely4.visible = true;
			Never4.visible = true;
			Always4.visible = true;
		}
		
	}
	
	public function Law1(event){
		
		LawClip.LawTitle.text = "1. The Law of the Lid:";
		LawClip.subTitle.text = "Leadership Ability Determines a Person's Level of Effectiveness.";
		LawClip.Explaination.text = "Explanation: Leadership ability is the lid that determines a person's level of effectiveness. The higher the individuals ability to lead, the higher the lid is on potential.";
		LawClip.Based.text = "(based off questions 1,2,3)";
	}
	
	public function Law2(event){
		
		LawClip.LawTitle.text = "2. The Law of Influence:";
		LawClip.subTitle.text = "The True Measure of Leadership Is Influence - Nothing More, Nothing Less.";
		LawClip.Explaination.text = "Explanation: The ability to lead successfully requires influence, without influence you will never be able to lead others.";
		LawClip.Based.text = "(based off questions 4,5,6)";
	}
	
	public function Law3(event){
		
		LawClip.LawTitle.text = "3. The Law of Process:";
		LawClip.subTitle.text = "Leadership Develops Daily, Not in a Day.";
		LawClip.Explaination.text = "Explanation: Leadership is similar to investing in stocks, you will not make your fortune in one day. What matters most is what you do day by day over the long haul.";
		LawClip.Based.text = "(based off questions 7,8,9)";
	}
	public function Law4(event){
		
		LawClip.LawTitle.text = "4. The Law of Navigation:";
		LawClip.subTitle.text = "Anyone Can Steer the Ship, but It Takes a Leader to Change the Course.";
		LawClip.Explaination.text = "Explanation: Vision is defined as the ability to see the whole trip before leaving the dock. A leader will also see obstacles before others do. A leader sees more, sees farther, and sees before others.";
		LawClip.Based.text = "(based off questions 10,11,12)";
	}
	
	public function Law5(event){
		
		LawClip.LawTitle.text = "5. The Law of Addition:";
		LawClip.subTitle.text = "Leaders Add Value by Serving Others.";
		LawClip.Explaination.text = "Explanation: The bottom line in leadership is not how far we advance ourselves but how far we advance others. This is achieved by serving others and adding value to their lives.";
		LawClip.Based.text = "(based off questions 13,14,15)";
	}
	
	public function Law6(event){
		
		LawClip.LawTitle.text = "6. The Law of Solid Ground:";
		LawClip.subTitle.text = "Trust Is the Foundation of Leadership.";
		LawClip.Explaination.text = "Explanation: Trust is the most important thing. A leader cannot repeatedly break the trust of their followers and continue to influence them. To build trust, a leader must exhibit competence, connection, and character.";
		LawClip.Based.text = "(based off questions 16,17,18)";
	}
	
	public function Law7(event){
		
		LawClip.LawTitle.text = "7. The Law of Respect:";
		LawClip.subTitle.text = "People Naturally Follow Leaders Stronger Than Themselves.";
		LawClip.Explaination.text = "Definition: When people respect you as a person, they admire you. When they respect you as a friend they love you. When they respect you as a leader, they follow you. Even natural leaders tend to fall in behind those who they sense have a higher “leadership quotient” than themselves.";
		LawClip.Based.text = "(based off questions 19,20,21)";
	}
	
	public function Law8(event){
		
		LawClip.LawTitle.text = "8. The Law of Intuition:";
		LawClip.subTitle.text = "Leaders Evaluate Everything with a Leadership Bias.";
		LawClip.Explaination.text = "Explanation: Leaders see trends, resources and problems, and can read people. Intuition is the most difficult law to teach; natural leaders understand instantly, learned leaders will understand eventually, and non-leaders may never understand.";
		LawClip.Based.text = "(based off questions 22,23,24)";
	}
	
	public function Law9(event){
		
		LawClip.LawTitle.text = "9. The Law of Magnetism:";
		LawClip.subTitle.text = "Who You Are Is Who You Attract.";
		LawClip.Explaination.text = "Explanation: Hire your weaknesses. If you only attract followers, your organization will be weak. Work to attract leaders rather than followers if you want to build a truly strong organization.";
		LawClip.Based.text = "(based off questions 25,26,27)";
	}
	
	public function Law10(event){
		
		LawClip.LawTitle.text = "10. The Law of Connection:";
		LawClip.subTitle.text = "Leaders Touch a Heart Before They Ask for a Hand.";
		LawClip.Explaination.text = "Explanation: You cannot move people to action unless you first move them with emotion. Communicate on the level of emotion first to make a personal connection. The heart comes before the head.";
		LawClip.Based.text = "(based off questions 28,29,30)";
	}
	
	public function Law11(event){
		
		LawClip.LawTitle.text = "11. The Law of the Inner Circle:";
		LawClip.subTitle.text = "A Leader's Potential Is Determined by Those Closest to Him.";
		LawClip.Explaination.text = "Explanation: Nobody does anything great alone. One must maintain, \"You can do what I cannot do. I can do what you cannot do. Together we can do great things.\" The leader finds greatness in the group, and helps the members find it in themselves.";
		LawClip.Based.text = "(based off questions 31,32,33)";
	}
	
	public function Law12(event){
		
		LawClip.LawTitle.text = "12. The Law of Empowerment:";
		LawClip.subTitle.text = "Only Secure Leaders Give Power to Others.";
		LawClip.Explaination.text = "Explanation: Great things can happen when you don’t care who gets the credit. The best executive is the one who has sense enough to pick good men to do what he wants done, and self-restraint enough to keep from meddling with them while they do it. Great leaders gain authority by giving it away.";
		LawClip.Based.text = "(based off questions 34,35,36)";
	}
	
	public function Law13(event){
		
		LawClip.LawTitle.text = "13. The Law of the Picture:";
		LawClip.subTitle.text = "People Do What People See.";
		LawClip.Explaination.text = "Explanation: Leaders are both highly visionary and highly practical. This vision allows them to see beyond the immediate and practical enough to know a vision without action is nothing at all. Followers may doubt what a leader says, but they usually believe what they do.";
		LawClip.Based.text = "(based off questions 37,38,39)";
	}
	
	public function Law14(event){
		
		LawClip.LawTitle.text = "14. The Law of Buy-In:";
		LawClip.subTitle.text = "People Buy into the Leader, Then the Vision.";
		LawClip.Explaination.text = "Explanation: Leaders find the dream and then the people, while people find the leader and then the dream. If followers do not like the leader but like the vision, they get a new leader. If they do not like the leader or the vision, they get a new leader. If they do not like the vision but like the leader, they get a new vision.";
		LawClip.Based.text = "(based off questions 40,41,42)";
	}
	
	public function Law15(event){
		
		LawClip.LawTitle.text = "15. The Law of Victory:";
		LawClip.subTitle.text = "Leaders Find a Way for the Team to Win.";
		LawClip.Explaination.text = "Explanation: Victorious leaders all have one thing in common: they share an unwillingness to accept defeat. As a result they figure out what must be done to achieve victory. Unity of vision, diversity of skills plus a leader are needed for a win. You cannot win without good athletes, but you can still lose with them; coaching makes the difference.";
		LawClip.Based.text = "(based off questions 43,44,45)";
	}
	
	public function Law16(event){
		
		LawClip.LawTitle.text = "16. The Law of the Big Mo:";
		LawClip.subTitle.text = "Momentum is a Leader's Best Friend.";
		LawClip.Explaination.text = "Explanation: If you cannot get things going you will not succeed. Even the average person can perform far above average in an organization with great momentum. It takes a leader to create forward motion, they always find a way to make things happen.";
		LawClip.Based.text = "(based off questions 46,47,48)";
	}
	
	public function Law17(event){
		
		LawClip.LawTitle.text = "17. The Law of Priorities:";
		LawClip.subTitle.text = "Leaders Understand That Activity Is Not Necessarily Accomplishment.";
		LawClip.Explaination.text = "Explanation: Not every leader practices the discipline of prioritizing, even though no leader will advance to the point where they no longer need to prioritize. There are three reasons for this: 1) when we are busy we naturally believe we are achieving, 2) prioritizing requires leaders to continually think ahead, to know what is important, the know what is next, and to see how everything relates to the vision (this is hard work), and 3) prioritizing causes us to do things that are at the least uncomfortable and sometimes painful. If you are a leader, you must learn the three “Rs”... a) what’s Required b) what gives the greatest Return c) what brings the greatest Reward. A leader is the one who climbs the tallest tree, surveys the situation, and yells, \"wrong jungle!\". ";
		LawClip.Based.text = "(based off questions 49,50,51)";
	}
	
	public function Law18(event){
		
		LawClip.LawTitle.text = "18. The Law of Sacrifice:";
		LawClip.subTitle.text = "A Leader Must Give Up to Go Up.";
		LawClip.Explaination.text = "Explanation: Successful leaders must maintain an attitude of sacrifice to turn around an organization. One sacrifice seldom brings success, sacrifice is an ongoing process and not a one-time payment. Effective leaders sacrifice much that is good in order to dedicate themselves to what is best. When you become a leader, you lose the right to think about yourself.";
		LawClip.Based.text = "(based off questions 52,53,54)";
	}
	
	public function Law19(event){
		
		LawClip.LawTitle.text = "19. The Law of Timing:";
		LawClip.subTitle.text = "When to Lead Is as Important as What to Do and Where to Go.";
		LawClip.Explaination.text = "Explanation: Only the right action at the right time will bring success. Good leadership timing requires: Understanding of the situation, Maturity with their motives, Confidence to maintain followers, Decisiveness to make firm decisions, Experience to have wisdom in the situation (or find someone who does), Intuition to know when the time is right, and Preparation to make the conditions right for action.";
		LawClip.Based.text = "(based off questions 55,56,57)";
	}
	
	public function Law20(event){
		
		LawClip.LawTitle.text = "20. The Law of Explosive Growth:";
		LawClip.subTitle.text = "To Add Growth, Lead Followers - To Multiply, Lead Leaders.";
		LawClip.Explaination.text = "Explanation: Leaders who attract followers need to be needed, develop the bottom 20 percent, focus on weaknesses, treat everyone the same, spend time with others, impact only the people they touch, and grow by addition. Leader who develop leaders, want to be succeeded, develop the top 20 percent, focus on strength, treat individuals differently, invest time in others, impact people beyond their reach, and grow by multiplication.";
		LawClip.Based.text = "(based off questions 58,59,60)";
	}
	
	public function Law21(event){
		
		LawClip.LawTitle.text = "21. The Law of Legacy:";
		LawClip.subTitle.text = "A Leader's Lasting Value is Measured by Succession.";
		LawClip.Explaination.text = "Explanation: A legacy is created only when a person puts their organization into a position to great things without them. Leadership is the one thing you cannot delegate. You either exercise it – or abdicate it.";
		LawClip.Based.text = "(based off questions 61,62,63)";
	}
	
	public function nextClicked(event){ //scrolls through the results when next is clicked
		if(flag == 1){
			stage.removeChild(infoFlap.emptyClip);
			stage.removeChild(infoFlap.infoButton);
			ScoreArray[count] = rbg1.selectedData;
			ScoreArray[count+1] = rbg2.selectedData;
			ScoreArray[count+2] = rbg3.selectedData;
			Occasionally3.visible = false;
			Rarely3.visible = false;
			Never3.visible = false;
			Always3.visible = false;
			Occasionally2.visible = false;
			Rarely2.visible = false;
			Never2.visible = false;
			Always2.visible = false;
			Occasionally.visible = false;
			Rarely.visible = false;
			Never.visible = false;
			Always.visible = false;
			instruction1.visible = false;
			total.visible = false;
			Rarrow.visible = false;
			Larrow.visible = false;
			Q62.x = 5000;
			Q61.x = 5000;
			Q63.x = 5000;
			
			LawClip.LawTitle.text = "1. The Law of the Lid:";
			LawClip.subTitle.text = "Leadership Ability Determines a Person's Level of Effectiveness.";
			LawClip.Explaination.text = "Explanation: Leadership ability is the lid that determines a person's level of effectiveness. The higher the individuals ability to lead, the higher the lid is on potential.";
			LawClip.Based.text = "(based off questions 1,2,3)";
			
			LawClip.visible = true;
			LawClip.scoreBox01.text = String(lawScores[0] = ScoreArray[0]+ScoreArray[1]+ScoreArray[2]); //stores the scores into the appropriate law
			if(lawScores[0]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square1.transform.colorTransform = testTransform;
			}
			if(lawScores[0]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square1.transform.colorTransform = testTransform;
			}
			if(lawScores[0]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square1.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox02.text = String(lawScores[1] = ScoreArray[3]+ScoreArray[4]+ScoreArray[5]);
			if(lawScores[1]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square2.transform.colorTransform = testTransform;
			}
			if(lawScores[1]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square2.transform.colorTransform = testTransform;
			}
			if(lawScores[1]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square2.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox03.text = String(lawScores[2] = ScoreArray[6]+ScoreArray[7]+ScoreArray[8]);
			if(lawScores[2]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square3.transform.colorTransform = testTransform;
			}
			if(lawScores[2]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square3.transform.colorTransform = testTransform;
			}
			if(lawScores[2]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square3.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox04.text = String(lawScores[3] = ScoreArray[9]+ScoreArray[10]+ScoreArray[11]);
			if(lawScores[3]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square4.transform.colorTransform = testTransform;
			}
			if(lawScores[3]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square4.transform.colorTransform = testTransform;
			}
			if(lawScores[3]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square4.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox05.text = String(lawScores[4] = ScoreArray[12]+ScoreArray[13]+ScoreArray[14]);
			if(lawScores[4]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square5.transform.colorTransform = testTransform;
			}
			if(lawScores[4]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square5.transform.colorTransform = testTransform;
			}
			if(lawScores[4]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square5.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox06.text = String(lawScores[5] = ScoreArray[15]+ScoreArray[16]+ScoreArray[17]);
			if(lawScores[5]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square6.transform.colorTransform = testTransform;
			}
			if(lawScores[5]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square6.transform.colorTransform = testTransform;
			}
			if(lawScores[5]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square6.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox07.text = String(lawScores[6] = ScoreArray[18]+ScoreArray[19]+ScoreArray[20]);
			if(lawScores[6]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square7.transform.colorTransform = testTransform;
			}
			if(lawScores[6]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square7.transform.colorTransform = testTransform;
			}
			if(lawScores[6]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square7.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox08.text = String(lawScores[7] = ScoreArray[21]+ScoreArray[22]+ScoreArray[23]);
			if(lawScores[7]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square8.transform.colorTransform = testTransform;
			}
			if(lawScores[7]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square8.transform.colorTransform = testTransform;
			}
			if(lawScores[7]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square8.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox09.text = String(lawScores[8] = ScoreArray[24]+ScoreArray[25]+ScoreArray[26]);
			if(lawScores[8]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square9.transform.colorTransform = testTransform;
			}
			if(lawScores[8]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square9.transform.colorTransform = testTransform;
			}
			if(lawScores[8]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square9.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox10.text = String(lawScores[9] = ScoreArray[27]+ScoreArray[28]+ScoreArray[29]);
			if(lawScores[9]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square10.transform.colorTransform = testTransform;
			}
			if(lawScores[9]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square10.transform.colorTransform = testTransform;
			}
			if(lawScores[9]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square10.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox11.text = String(lawScores[10] = ScoreArray[30]+ScoreArray[31]+ScoreArray[32]);
			if(lawScores[10]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square11.transform.colorTransform = testTransform;
			}
			if(lawScores[10]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square11.transform.colorTransform = testTransform;
			}
			if(lawScores[10]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square11.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox12.text = String(lawScores[11] = ScoreArray[33]+ScoreArray[34]+ScoreArray[35]);
			if(lawScores[11]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square12.transform.colorTransform = testTransform;
			}
			if(lawScores[11]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square12.transform.colorTransform = testTransform;
			}
			if(lawScores[11]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square12.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox13.text = String(lawScores[12] = ScoreArray[36]+ScoreArray[37]+ScoreArray[38]);
			if(lawScores[12]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square13.transform.colorTransform = testTransform;
			}
			if(lawScores[12]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square13.transform.colorTransform = testTransform;
			}
			if(lawScores[12]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square13.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox14.text = String(lawScores[13] = ScoreArray[39]+ScoreArray[40]+ScoreArray[41]);
			if(lawScores[13]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square14.transform.colorTransform = testTransform;
			}
			if(lawScores[13]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square14.transform.colorTransform = testTransform;
			}
			if(lawScores[13]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square14.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox15.text = String(lawScores[14] = ScoreArray[42]+ScoreArray[43]+ScoreArray[44]);
			if(lawScores[14]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square15.transform.colorTransform = testTransform;
			}
			if(lawScores[14]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square15.transform.colorTransform = testTransform;
			}
			if(lawScores[14]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square15.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox16.text = String(lawScores[15] = ScoreArray[45]+ScoreArray[46]+ScoreArray[47]);
			if(lawScores[15]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square16.transform.colorTransform = testTransform;
			}
			if(lawScores[15]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square16.transform.colorTransform = testTransform;
			}
			if(lawScores[15]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square16.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox17.text = String(lawScores[16] = ScoreArray[48]+ScoreArray[49]+ScoreArray[50]);
			if(lawScores[16]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square17.transform.colorTransform = testTransform;
			}
			if(lawScores[16]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square17.transform.colorTransform = testTransform;
			}
			if(lawScores[16]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square17.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox18.text = String(lawScores[17] = ScoreArray[51]+ScoreArray[52]+ScoreArray[53]);
			if(lawScores[17]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square18.transform.colorTransform = testTransform;
			}
			if(lawScores[17]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square18.transform.colorTransform = testTransform;
			}
			if(lawScores[17]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square18.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox19.text = String(lawScores[18] = ScoreArray[54]+ScoreArray[55]+ScoreArray[56]);
			if(lawScores[18]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square19.transform.colorTransform = testTransform;
			}
			if(lawScores[18]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square19.transform.colorTransform = testTransform;
			}
			if(lawScores[18]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square19.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox20.text = String(lawScores[19] = ScoreArray[57]+ScoreArray[58]+ScoreArray[59]);
			if(lawScores[19]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square20.transform.colorTransform = testTransform;
			}
			if(lawScores[19]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square20.transform.colorTransform = testTransform;
			}
			if(lawScores[19]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square20.transform.colorTransform = testTransform;
			}
			LawClip.scoreBox21.text = String(lawScores[20] = ScoreArray[60]+ScoreArray[61]+ScoreArray[62]);
			if(lawScores[20]>=0){
				testTransform = new ColorTransform(1,0,0,.2);
				LawClip.square21.transform.colorTransform = testTransform;
			}
			if(lawScores[20]>=5){
				testTransform = new ColorTransform(1,1,0,.2);
				LawClip.square21.transform.colorTransform = testTransform;
			}
			if(lawScores[20]>=8){
				testTransform = new ColorTransform(0,1,0,.2);
				LawClip.square21.transform.colorTransform = testTransform;
			}
		}
		
		else if(flag == 0){
			Larrow.alpha = 1;
			if(ScoreArray[count] > 0 || ScoreArray[count+1] > 0 || ScoreArray[count+2] > 0 || ScoreArray[count+3] > 0){
				rbg1.selectedData = ScoreArray[count];
				rbg2.selectedData = ScoreArray[count+1];
				rbg3.selectedData = ScoreArray[count+2];
				rbg4.selectedData = ScoreArray[count+3];
			}
			else{
				ScoreArray[count] = rbg1.selectedData;
				ScoreArray[count+1] = rbg2.selectedData;
				ScoreArray[count+2] = rbg3.selectedData;
				ScoreArray[count+3] = rbg4.selectedData;
				Never.selected = true;
				Never2.selected = true;
				Never3.selected = true;
				Never4.selected = true;
			}
			count += 4;
			if(count != 60){
				this[QuestionArray[count]].x = 15;
				this[QuestionArray[count]].y = 37;
				this[QuestionArray[count-4]].x = 5000;
				
				this[QuestionArray[count+1]].x = 15;
				this[QuestionArray[count+1]].y = 133;
				this[QuestionArray[count-3]].x = 5000;
				
				this[QuestionArray[count+2]].x = 15;
				this[QuestionArray[count+2]].y = 217;
				this[QuestionArray[count-2]].x = 5000;
				
				this[QuestionArray[count+3]].x = 15;
				this[QuestionArray[count+3]].y = 294;
				this[QuestionArray[count-1]].x = 5000;
				
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
				flag = 1;
		
				Occasionally4.visible = false;
				Rarely4.visible = false;
				Never4.visible = false;
				Always4.visible = false;
			}
		}
		
	}
}
}