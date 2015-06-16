using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SetOtherPlayers : MonoBehaviour {
	public GameObject player;
	private string fetchURL;
	private string PlayerData;
	public List<int> arrayOfInts;
	private string[] getAllData;
	private string year;
	private string term;
	// Use this for initialization
	void Start () {
		term = this.GetComponent<NodeOrder>().SetTerm();
		year = System.DateTime.Now.ToString("yyyy");
		print ("year is "+year);

		arrayOfInts = new List<int>();
		fetchURL = "https://courses.ecampus.oregonstate.edu/test/database.php?ID=1&year="+year+"&term="+term;

		StartCoroutine(FetchData());

	}
	
	IEnumerator FetchData(){
		WWW www = new WWW(fetchURL);
		yield return www;
		PlayerData = www.text;
		ParseData();
	}

	void ParseData(){
		getAllData = PlayerData.Split(',');
		for(int i = 0;i<getAllData.Length;i++){
			arrayOfInts.Add(int.Parse(getAllData[i]));
			this.GetComponent<NodeOrder>().SetPlayers(arrayOfInts[i],player);
		}

	}
}
