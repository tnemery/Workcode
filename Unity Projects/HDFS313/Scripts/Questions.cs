using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Questions : MonoBehaviour {
	private string[] AllQuestions = new string[66];
	private int[] MoveDirection = new int[66];
	public GameObject MyPlayer;
	public GUISkin MainSkin;
	private int i = 0;
	private bool sendData = true;


	// Use this for initialization
	void Start () {

		AllQuestions[0] = "You feel that your primary ethnic identity is “American”";
		AllQuestions[1] = "You are male";
		AllQuestions[2] = "You are heterosexual";
		AllQuestions[3] = "You are sometimes called names or ridiculed because of your race, ethnicity or class background";
		AllQuestions[4] = "You are unable to discuss your same sex partner at work or in class because you fear for your job or your safety";
		AllQuestions[5] = "You have ever had to use a back or side entrance to a building, or been banned from an event because the main entrance was physically inaccessible to you";
		AllQuestions[6] = "Your parents do or did employ extra help such as servants, maids, gardeners or nannies";
		AllQuestions[7] = "You are or were ever embarrassed or ashamed of your clothes, your house or your family car";
		AllQuestions[8] = "You have an immediate family member who is a doctor, lawyer, or other professional";
		AllQuestions[9] = "Prostitution, drugs, or other illegal activities are prevalent where you live";
		AllQuestions[10] = "Any women in your family, including yourself if you are female, were ever physically or sexually assaulted";
		AllQuestions[11] = "You studied the history and culture of your ethnic ancestors";
		AllQuestions[12] = "You started school speaking a language other than English";
		AllQuestions[13] = "You are, or think you might be, discouraged from becoming a big sister/big brother, mentor, scout leader or coach because of your sexual/affectional orientation";
		AllQuestions[14] = "You have ever refrained from participating in a class project or discussion because the environment does not support your learning style";
		AllQuestions[15] = "You ever skipped a meal or went away from a meal hungry because there wasn’t enough money to buy food";
		AllQuestions[16] = "You were taken to art galleries, museums or plays by your parents";
		AllQuestions[17] = "You have ever attended a summer camp";
		AllQuestions[18] = "You received less encouragement in academics or sports from your family or from teachers because of your gender";
		AllQuestions[19] = "Your parents have told you that you are beautiful, smart and capable of achieving your dreams";
		AllQuestions[20] = "You were ever discouraged or prevented from pursuing your goals or tracked into a lower level because of your race or ethnicity";
		AllQuestions[21] = "Your parents are encouraging you to go to college";
		AllQuestions[22] = "You have traveled to another country";
		AllQuestions[23] = "You have a parent that did not complete high school";
		AllQuestions[24] = "You can express affection for your partner either physically or verbally while in public without fear of any violence from others as a result";
		AllQuestions[25] = "You commonly see people of your race, ethnicity, sex or ability portrayed negatively or representing degrading roles in the media";
		AllQuestions[26] = "You have ever gotten a job or promotion through the help of a friend or family member";
		AllQuestions[27] = "You were ever mistrusted or accused of stealing, cheating or lying because of your race, ethnicity or class";
		AllQuestions[28] = "You generally think of the police as people that you can call on for help";
		AllQuestions[29] = "You have ever been stopped by police because of your race, ethnicity or class";
		AllQuestions[30] = "You or close friends or family were ever a victim of violence because of your race or ethnicity";
		AllQuestions[31] = "You know anyone in prison";
		AllQuestions[32] = "You or your parents are immigrants";
		AllQuestions[33] = "You have never entered a public place and been avoided because of your physical ability";
		AllQuestions[34] = "Your family had more than fifty books in the house when you were growing up";
		AllQuestions[35] = "One of your parents was ever laid off, unemployed or underemployed not by choice";
		AllQuestions[36] = "You ever attended a private school";
		AllQuestions[37] = "You grew up in a single parent household";


		MoveDirection[0] = 1;
		MoveDirection[1] = 2;
		MoveDirection[2] = 2;
		MoveDirection[3] = -2;
		MoveDirection[4] = -1;
		MoveDirection[5] = -1;
		MoveDirection[6] = 2;
		MoveDirection[7] = -1;
		MoveDirection[8] = 1;
		MoveDirection[9] = -2;
		MoveDirection[10] = -1;
		MoveDirection[11] = 1;
		MoveDirection[12] = -2;
		MoveDirection[13] = -1;
		MoveDirection[14] = -1;
		MoveDirection[15] = -1;
		MoveDirection[16] = 1;
		MoveDirection[17] = 1;
		MoveDirection[18] = -2;
		MoveDirection[19] = 2;
		MoveDirection[20] = -2;
		MoveDirection[21] = 2;
		MoveDirection[22] = 1;
		MoveDirection[23] = -1;
		MoveDirection[24] = 1;
		MoveDirection[25] = -1;
		MoveDirection[26] = 1;
		MoveDirection[27] = -1;
		MoveDirection[28] = 1;
		MoveDirection[29] = -1;
		MoveDirection[30] = -1;
		MoveDirection[31] = -1;
		MoveDirection[32] = -2;
		MoveDirection[33] = 1;
		MoveDirection[34] = 1;
		MoveDirection[35] = -1;
		MoveDirection[36] = 2;
		MoveDirection[37] = -1;
	}
	
	void OnGUI(){
		GUI.skin = MainSkin;
		if(i < AllQuestions.Length){
			GUI.BeginGroup(new Rect(0,0,300,300));
				GUI.Box (new Rect(0,0,300,300),AllQuestions[i]);
				if(GUI.Button(new Rect(50,200,100,50),"Yes")){
					this.GetComponent<NodeOrder>().MovePlayer(MoveDirection[i]);
					i++;
				}
				if(GUI.Button (new Rect(175,200,100,50),"No")){
					this.GetComponent<NodeOrder>().MovePlayer(MoveDirection[i]*(-1));	
					i++;
				}
			GUI.EndGroup();
		}else if(i == AllQuestions.Length){
			i++;
			SendResult ();
		}
	}


	void SendResult(){
		if(sendData){
			this.GetComponent<NodeOrder>().SendResult();
			sendData = false;
		}
	}
}
