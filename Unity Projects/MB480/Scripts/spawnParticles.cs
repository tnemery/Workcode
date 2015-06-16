using UnityEngine;
using System.Collections;

public class spawnParticles : MonoBehaviour {
	public ParticleRenderer partWrong;
	public ParticleRenderer partRight;

	void Awake (){
		DontDestroyOnLoad(this);
		partWrong.particleEmitter.emit = false;
		partRight.particleEmitter.emit = false;
	}
	public void playpart(Vector3 myPos, int type){
		if(type == 1){
			partWrong.transform.position = myPos;
			partWrong.particleEmitter.emit = true;
			StartCoroutine(stoppart());
		}else{
			partRight.transform.position = myPos;
			partRight.particleEmitter.emit = true;
			StartCoroutine(stoppart());
		}
	}

	public IEnumerator stoppart(){
		if(partWrong.particleEmitter.emit == true){
			yield return new WaitForSeconds(2);
			partWrong.particleEmitter.emit = false;
		}
		if(partRight.particleEmitter.emit == true){
			yield return new WaitForSeconds(2);
			partRight.particleEmitter.emit = false;
		}
	}

}
