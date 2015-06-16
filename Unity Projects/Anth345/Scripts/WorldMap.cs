using UnityEngine;
using System;
//using System.;
using System.Collections;
using System.Collections.Generic;

public class WorldMap : MonoBehaviour {
	public GameObject IME;
	public GameObject groundTiles;
	private Transform [] childrenTiles = new Transform[6];
	
	private int index = 0;
	private int curMove = 0;
	private int maxMoves = 2; //set to be one less then total tiles
	
	private float spaceTime = 0.1f;
	private float grabY;
	
	void Awake(){
		int idx = 0;
		Transform[] allChildren = groundTiles.GetComponentsInChildren<Transform>();
		for(int i = 0; i<allChildren.Length;i++){
			if(allChildren[i].name.Substring(0,5) == "rGame"){
				if(idx >= childrenTiles.Length){
					Array.Resize(ref childrenTiles,childrenTiles.Length+1);
				}
				childrenTiles[idx] = allChildren[i];
				idx++;
			}
		}
	}
	
	
	void Start(){
		MoveCharacter();	
	}
	
	void Update(){
		if(Input.GetKeyDown(KeyCode.A)){
			maxMoves = 2;
			curMove = 0;
			MoveCharacter();
		}
		
	}
	
	
	void MoveCharacter(){
		if(index >= childrenTiles.Length){
			index = 0;	
		}
		
		Vector3 v1 = new Vector3(IME.transform.position.x,IME.transform.position.y,IME.transform.position.z);
		Vector3 v2 = new Vector3(childrenTiles[index].position.x,IME.transform.position.y,childrenTiles[index].position.z);
		//Debug.Log("v1: "+v1+"v2: "+v2);
		StartCoroutine(moveObj(IME,v1,v2,spaceTime));
	}
	
	IEnumerator moveObj(GameObject thisTransform, Vector3 startPos, Vector3 endPos, float timeToTake){
		float i = 0.0f;
		float rate = 1.0f/timeToTake;
		
		if(index+1 == childrenTiles.Length){
			IME.transform.LookAt(childrenTiles[0]);
		}else{
			IME.transform.LookAt(childrenTiles[index+1]);
		}
		grabY = IME.transform.eulerAngles.y;
		IME.transform.rotation = Quaternion.LookRotation(new Vector3(IME.transform.rotation.x,grabY,IME.transform.rotation.z), Vector3.up);
		//IME.transform.rotation = Quaternion.Euler(new Vector3(IME.transform.rotation.x,grabY,IME.transform.rotation.z));
		
		while(i < 1.0f){
			IME.transform.rotation = Quaternion.Euler(new Vector3(IME.transform.rotation.x,grabY,IME.transform.rotation.z));
			Debug.Log ("grabY: "+IME.transform.eulerAngles.y);
			i += Time.deltaTime * rate;
			thisTransform.transform.position = Vector3.Lerp(startPos,endPos, i);
			yield return new WaitForSeconds(spaceTime);
		}
		//this finds total moves
		if(curMove < maxMoves){
			curMove++;
			index++;
			MoveCharacter();
		} 
		
	}
	
}