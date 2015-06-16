using UnityEngine;
using System.Collections;

public class runGame : MonoBehaviour {

	public Transform cubePrefab;
	private Transform reference;
	private Transform reference2;
	public NetworkView networkViews;
	private static int count = 0;
	private NetworkViewID myID;
	private GameObject[] gameObjs;
	private bool isSpawned = false;
	private int players = 0;
	string playerName = "newPlayer";

	class PlayerNode{
		public string playerName;
		public NetworkPlayer player;
		public NetworkViewID playerID;
	}

	private PlayerNode[] nodes;

	void OnServerInitialized()
	{
		SpawnPlayer();
	}

	void OnConnectedToServer()
	{
		SpawnPlayer();
	}
	
	void SpawnPlayer()
	{

		PlayerNode newEntry = new PlayerNode();
		newEntry.playerName = playerName;
		newEntry.player = Network.player;
		if(Network.isServer){
			if(isSpawned == false){
				reference = (Transform)Network.Instantiate(cubePrefab, GameObject.Find ("spawnPoint1").transform.position, transform.rotation, 0);
				reference.name = "server";
				networkViews = reference.GetComponent<NetworkView>();
				reference.transform.Find ("Main Camera").GetComponent<Camera>().enabled = true;
				reference.GetComponent<CharacterMotor>().enabled = true;
				reference.GetComponent<FPSInputController>().enabled = true;
				reference.GetComponent<rotateChar>().enabled = true;
				reference.transform.FindChild("bulletSpawnPoint").gameObject.SetActive(true);
				isSpawned = true;
				gameObjs = GameObject.FindGameObjectsWithTag("Player");
				
				myID = networkViews.viewID;
				newEntry.playerID = networkViews.viewID;
				for(int i = 0; i<nodes.Length;i++){
					if(nodes[i] == null){
						nodes[i] = newEntry;
						break;
					}
				}
			}else{
				//reference2 = GameObject.Find ("client").transform;
			}
		}else if(Network.isClient){
			if(isSpawned == false){
				reference2 = (Transform)Network.Instantiate(cubePrefab, GameObject.Find ("spawnPoint2").transform.position, Quaternion.Euler(new Vector3(transform.rotation.x,180,transform.rotation.z)), 0);
				reference2.name = "client";
				networkViews = reference2.GetComponent<NetworkView>();
				reference2.transform.Find ("Main Camera").GetComponent<Camera>().enabled = true;
				reference2.GetComponent<CharacterMotor>().enabled = true;
				reference2.GetComponent<FPSInputController>().enabled = true;
				reference2.GetComponent<rotateChar>().enabled = true;
				reference2.transform.FindChild("bulletSpawnPoint").gameObject.SetActive(true);
				gameObjs = GameObject.FindGameObjectsWithTag("Player");
				
				myID = networkViews.viewID;
				newEntry.playerID = networkViews.viewID;
				for(int i = 0; i<nodes.Length;i++){
					if(nodes[i] == null){
						nodes[i] = newEntry;
						break;
					}
				}
				networkView.RPC ("TellServerOurName", RPCMode.All, newEntry.playerID,Network.player);
			}
		}




		//print (myID);
		//Debug.Log (myID);
		count++;
	}

	[RPC]
	void TellServerOurName(NetworkViewID name, NetworkPlayer netPlayer,NetworkMessageInfo info){
		print("sever name: "+name);
		print("sever name: "+playerName);
		print("sever name: "+netPlayer);
		PlayerNode newEntry = new PlayerNode();
		newEntry.playerName = playerName;
		newEntry.player = netPlayer;
		newEntry.playerID = name;
		for(int i = 0; i<nodes.Length;i++){
			if(nodes[i] == null){
				nodes[i] = newEntry;
				break;
			}
		}

	}
	
	void OnPlayerConnected(NetworkPlayer netPlayer){
		print ("player joined "+ netPlayer);
		print ("nodes "+ (nodes[1] != null));
		players++;
		SpawnPlayer ();
		print ("nodes "+ (nodes[1] != null));
	}


	void OnPlayerDisconnected(NetworkPlayer netPlayer){
		//tell server to remove player object -- somehow here
		//Debug.Log ("Player disconnected: "+GetPlayerNode (netPlayer));
		//playerList.Remove (GetPlayerNode (netPlayer));
		NetworkViewID KillPlayer = myID;
		players--;
		print ("player disconnected: "+netPlayer);
		for(int a = 0;a<nodes.Length;a++){
			if(netPlayer == nodes[a].player){
				KillPlayer = nodes[a].playerID;
				print ("id to kill: "+KillPlayer);
				nodes[a] = null; //wipe out this node
				break;
			}
		}

		//networkView.RPC("DestroyBuffered", RPCMode.AllBuffered, fooObj.GetComponent<NetworkView>().viewID);


		foreach(GameObject fooObj in GameObject.FindGameObjectsWithTag("Player"))
		{

			if((fooObj.GetComponent<NetworkView>().viewID == KillPlayer)){
				networkView.RPC("DestroyBuffered", RPCMode.AllBuffered, fooObj.GetComponent<NetworkView>().viewID);
			}
		}

	}

	void OnDisconnectedFromServer(){
		//destroy cubes
                                                       		//tell clients a player has left.... figure this out{
		foreach(GameObject fooObj in GameObject.FindGameObjectsWithTag("Player"))
		{
			//if((fooObj.GetComponent<NetworkView>().viewID == myID)){
				networkView.RPC("DestroyBuffered", RPCMode.AllBuffered, fooObj.GetComponent<NetworkView>().viewID);
			//}
		}

	}

	[RPC]
	void DestroyBuffered(NetworkViewID theID) {
		Object.Destroy(NetworkView.Find(theID).gameObject); 
	}


	void Start()
	{
		nodes = new PlayerNode[32];
		if (!networkView.isMine)
			enabled = false;
	}
}
