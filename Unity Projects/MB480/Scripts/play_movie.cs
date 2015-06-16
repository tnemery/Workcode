using UnityEngine;
using System.Collections;

public class play_movie : MonoBehaviour {
		
	private MovieTexture movietexture;
	// Use this for initialization
	void Start () {
		movietexture = renderer.material.mainTexture as MovieTexture;
		movietexture.loop = true;
		movietexture.Play();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
