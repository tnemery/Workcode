using UnityEngine;
using System.Collections;

public class imaker : MonoBehaviour {
	public Texture2D BackGround;
	public Texture2D RandBtn;
	public Texture2D DoneBtn;
	public Texture2D lilDude;
	
	public GUIStyle RandSkin;
	public GUIStyle DoneSkin;
	
	public GUISkin sliderskin;
	
	private float XIndent = 80.0f; //align the buttons to the screen size
	private float YIndent = 140.0f;
	private float YCentIndent = 425.0f;
	private float pushXSprite = 625.0f; // for sprite on right side
	private float pushYSprite = 140.0f;
	private float SliderXPos = 320.0f;
	private float SliderYPos = 175.0f;
	private float SliderLen = 250.0f;
	private float SliderOffSet = 70.0f;
	
	private float AgeSlider = 0.0F;
	private float GenderSlider = 0.0F;
	private float RaceSlider = 0.0F;
	private float IdentitySlider = 0.0F;
	private float AbilitySlider = 0.0F;
	private float EthnicitySlider = 0.0F;
	
	void Awake(){
		DetermineScreenInsets();
	}
	
	
	void OnGUI(){
		
		GUI.DrawTexture(new Rect(0,0,Screen.width,Screen.height),BackGround, ScaleMode.StretchToFill);
		GUI.DrawTexture(new Rect(pushXSprite,pushYSprite,Screen.width/4,Screen.height/1.5f),lilDude);
		//Debug.Log("width: "+Screen.width+"height: "+Screen.height);
		if(GUI.Button(new Rect(XIndent,YIndent,Screen.width/6.5f,Screen.height/4),RandBtn,RandSkin)){
			
		}
		
		if(GUI.Button(new Rect(XIndent,YCentIndent,Screen.width/6.5f,Screen.height/4),DoneBtn,DoneSkin)){
			Application.LoadLevel("GameScene");
		}
		
		//slider stuff
		GUI.skin = sliderskin;

		AgeSlider = GUI.HorizontalSlider (new Rect (SliderXPos, SliderYPos, SliderLen, 30), AgeSlider, 1F, 5F);
		GenderSlider = GUI.HorizontalSlider (new Rect (SliderXPos, SliderYPos+SliderOffSet, SliderLen, 30), GenderSlider, 0F, 5F);
		RaceSlider = GUI.HorizontalSlider (new Rect (SliderXPos, SliderYPos+(SliderOffSet*2), SliderLen, 30), RaceSlider, 0F, 5F);
		IdentitySlider = GUI.HorizontalSlider (new Rect (SliderXPos, SliderYPos+(SliderOffSet*3), SliderLen, 30), IdentitySlider, 0F, 5F);
		AbilitySlider = GUI.HorizontalSlider (new Rect (SliderXPos, SliderYPos+(SliderOffSet*4), SliderLen, 30), AbilitySlider, 0F, 5F);
		EthnicitySlider = GUI.HorizontalSlider (new Rect (SliderXPos, SliderYPos+(SliderOffSet*5), SliderLen, 30), EthnicitySlider, 0F, 5F);
		
		GUI.skin = null;
		//end slider stuff
	}
	
	
	void DetermineScreenInsets(){
		float tempWid = 0f;
		float tempHeight = 0f;
		if(Screen.width == 960 && Screen.height == 600){
			//offsets remain at defaults	
		}else{
			//change the offsets
			tempWid = 960f / Screen.width;
			tempHeight = 600f / Screen.height;
			XIndent = XIndent / tempWid;
			YIndent = YIndent / tempHeight;
			pushXSprite = pushXSprite / tempWid;
			pushYSprite = pushYSprite / tempHeight;
			YCentIndent = YCentIndent / tempHeight;
			
			SliderXPos = SliderXPos / tempWid;
			SliderYPos = SliderYPos / tempHeight;
			SliderLen = SliderLen / tempWid;
			SliderOffSet = SliderOffSet / tempHeight;
			
			
		}
	}
	
}
