using UnityEngine;
using System.Collections;

public class bulletMove : MonoBehaviour {
	private float speed = 20.0f;
	public float time;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		time += Time.deltaTime;
		transform.Translate(Vector3.forward * speed * Time.deltaTime,Space.Self);

		if(time > 3.0f){
			Destroy (gameObject);
		}
	}

	void OnCollisionEnter(Collision bulletHit){
		Destroy (gameObject);
	}
}
