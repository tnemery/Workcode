using UnityEngine;
using System.Collections;

public class taskLists : MonoBehaviour {
	public static GameObject task1;
	public static GameObject task2;
	public static GameObject task3;
	public static GameObject task4;
	public static GameObject task5;
	// Use this for initialization
	void Start () {
		task1 = GameObject.FindGameObjectWithTag("Task1");
		task2 = GameObject.FindGameObjectWithTag("Task2");
		task3 = GameObject.FindGameObjectWithTag("Task3");
		task4 = GameObject.FindGameObjectWithTag("Task4");
		task5 = GameObject.FindGameObjectWithTag("Task5");
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public static void reset(){
		task1.renderer.material.color = Color.black;
		task2.renderer.material.color = Color.black;
		task3.renderer.material.color = Color.black;
		task4.renderer.material.color = Color.black;
		task5.renderer.material.color = Color.black;
	}
	
	
	public static void changeState(int obj, bool done){
		Debug.Log("obj: "+obj+" done: "+done);
		if( obj == 1 ){
			if(done == true){
				task1.renderer.material.color = Color.green;
			}else{
				task1.renderer.material.color = Color.red;
			}
		}
		
		if( obj == 2 ){
			if(done == true){
				task2.renderer.material.color = Color.green;
			}else{
				task2.renderer.material.color = Color.red;
			}
		}
		
		if( obj == 3 ){
			if(done == true){
				task3.renderer.material.color = Color.green;
			}else{
				task3.renderer.material.color = Color.red;
			}
		}
		
		if( obj == 4 ){
			if(done == true){
				task4.renderer.material.color = Color.green;
			}else{
				task4.renderer.material.color = Color.red;
			}
		}
		
		if( obj == 5 ){
			if(done == true){
				task5.renderer.material.color = Color.green;
			}else{
				task5.renderer.material.color = Color.red;
			}
		}
	}
}
