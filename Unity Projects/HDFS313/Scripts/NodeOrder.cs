using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class NodeOrder : MonoBehaviour {
	public GameObject[] nodes;
	public GameObject MyPlayer;
	private int initialnode;
	private int curNode;
	private string urlStore;
	private string numObjs = "";
	private string year;
	private string term;

	//terms
	//fall sep - december
	//winter January - March
	//Sprin April - June
	//Summer July - August

	void Awake(){
		curNode = initialnode = 33; //node0
		year = System.DateTime.Now.ToString("yyyy");
		SetTerm();
	}

	public void MovePlayer(int dir){
		curNode += dir;
		if(curNode > nodes.Length){
			curNode = nodes.Length -1;
		}
		if(curNode < 0){
			curNode = 0;
		}
		MyPlayer.transform.position = new Vector3(nodes[curNode].transform.position.x,nodes[curNode].transform.position.y,nodes[curNode].transform.position.z);
	}

	//call a database for tile values... will be returned as an array
	//use term date to search for class
	//current access url is https://courses.ecampus.oregonstate.edu/test/database.php?tile=25
	//System.DateTime.Now.ToString("yyyy-M-d")
	public void SetClass(GameObject player, int node){
		//curNode += dir;

		//MyPlayer.transform.position = new Vector3(nodes[curNode].transform.position.x,nodes[curNode].transform.position.y,nodes[curNode].transform.position.z);
	}

	public void SendResult(){
		urlStore = "https://courses.ecampus.oregonstate.edu/test/database.php?tile="+curNode+"&year="+year+"&term="+term;
		StartCoroutine(sending());
	}


	IEnumerator sending() {
		WWW www = new WWW(urlStore);
		yield return www;
	}

	public void SetPlayers(int players, GameObject otherPlayer){
		numObjs +=(players.ToString()+" ");
		GameObject dummyObj = Instantiate(otherPlayer,nodes[players].transform.position,Quaternion.identity) as GameObject;

	}

	public string SetTerm(){
		if(System.DateTime.Now.ToString("M").Substring(0,3) == "Aug" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Sep" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Jul"){
			
			term = "Summer";
		}
		if(System.DateTime.Now.ToString("M").Substring(0,3) == "Oct" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Nov" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Dec"){
			
			term = "Fall";
		}
		if(System.DateTime.Now.ToString("M").Substring(0,3) == "Jan" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Feb" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Mar"){
			
			term = "Winter";
		}
		if(System.DateTime.Now.ToString("M").Substring(0,3) == "Apr" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "May" ||
		   System.DateTime.Now.ToString("M").Substring(0,3) == "Jun"){
			
			term = "Spring";
		}

		return term;
	}


}
