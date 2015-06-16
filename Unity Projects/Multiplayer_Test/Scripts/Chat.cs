using UnityEngine;
using System.Collections;

public class Chat : MonoBehaviour {

	bool usingChat = false;
	bool showChat = false;

	string inputField = "";

	Vector2 scrollposition;
	int width = 500;
	int height = 150;
	string playerName;
	float lastUnfocusTime = 0;
	public Rect window = new Rect(100, 100, 120, 50);

	ArrayList playerList = new ArrayList();
	class PlayerNode{
		public string playerName;
		public NetworkPlayer player;

	}

	ArrayList chatEntries = new ArrayList();
	class ChatEntry{
		public string name = "";
		public string text = "";
	}

	// Use this for initialization
	void GenerateName () {
		window = new Rect(Screen.width/2 - width/2, Screen.height - height+5, width,height);
		playerName = PlayerPrefs.GetString ("playerName","");

		if(playerName == "") playerName = "RandomName" + Random.Range (1,999);

	}

	void OnConnectedToServer(){
		GenerateName ();
		ShowChatWindow();
		networkView.RPC ("TellServerOurName", RPCMode.Server, playerName);
		addGameChatMessage(playerName + " has just joined the chat!");
	}

	void OnServerInitialized(){
		GenerateName ();
		ShowChatWindow();
		PlayerNode newEntry = new PlayerNode();
		newEntry.playerName = playerName;
		newEntry.player = Network.player;
		playerList.Add (newEntry);
		addGameChatMessage(playerName + " has just joined the chat!");
	}
	
	PlayerNode GetPlayerNode(NetworkPlayer netPlay){
		foreach(PlayerNode entry in playerList){
			if(entry.player == netPlay)
				return entry;
		}
		Debug.LogError ("GetPlayerNode: Requested a playernode of non-existing player!");
		return null;
	}

	void OnPlayerDisconnected(NetworkPlayer netPlayer){
		addGameChatMessage("A Player has disconnected");
		//playerList.Remove (GetPlayerNode (netPlayer));
	}

	void OnDisconnectedFromServer(){
		CloseChatWindow();
	}

	[RPC]
	void TellServerOurName(string name, NetworkMessageInfo info){
		PlayerNode newEntry = new PlayerNode();
		newEntry.playerName = playerName;
		newEntry.player = Network.player;
		playerList.Add (newEntry);
		addGameChatMessage(playerName + " has joined the chat!");
	}

	void CloseChatWindow(){
		showChat = false;
		inputField = "";
		chatEntries = new ArrayList();
	}

	void ShowChatWindow(){
		showChat = true;
		inputField = "";
		chatEntries = new ArrayList();
	}

	void OnGUI(){
		if(!showChat) return;

		if(Event.current.type == EventType.keyDown && Event.current.character == '\n' & inputField.Length <= 0){
			if(lastUnfocusTime + .25f < Time.time){
				usingChat = true;
				GUI.FocusWindow (5);
				GUI.FocusControl ("Chat input field");
			}
		}

		window = GUI.Window (5,window,GlobalChatWindow, "");

	}

	void GlobalChatWindow(int id){
		GUILayout.BeginVertical ();
		GUILayout.Space (10);
		GUILayout.EndVertical();

		scrollposition = GUILayout.BeginScrollView(scrollposition);

		foreach(ChatEntry entry in chatEntries){
			GUILayout.BeginHorizontal ();
			if(entry.name == " - ")
				GUILayout.Label (entry.name + entry.text);
			else
				GUILayout.Label (entry.name + ": "+entry.text);

			GUILayout.EndHorizontal ();
			GUILayout.Space (1);
		}

		GUILayout.EndScrollView();

		if(Event.current.type == EventType.keyDown && Event.current.character == '\n' & inputField.Length > 0){
			HitEnter(inputField);
		}

		GUI.SetNextControlName("Chat input field");
		inputField = GUILayout.TextField (inputField);

		if(Input.GetKeyDown ("mouse 0")){
			if(usingChat){
				usingChat = false;
				GUI.UnfocusWindow();
				lastUnfocusTime = Time.time;
			}
		}

	}

	void HitEnter(string msg){
		msg = msg.Replace ('\n', ' ');
		networkView.RPC ("ApplyGlobalChatText", RPCMode.All, playerName, msg);
	}

	[RPC]
	void ApplyGlobalChatText(string name, string msg){
		ChatEntry entry = new ChatEntry();
		entry.name = name;
		entry.text = msg;

		chatEntries.Add(entry);

		if(chatEntries.Count > 100)
			chatEntries.RemoveAt(0);

		scrollposition.y = 1000000;
		inputField = "";
	}

	void addGameChatMessage(string str){
		ApplyGlobalChatText (" - ", str);
		if(Network.connections.Length > 0)
			networkView.RPC ("ApplyGlobalChatText", RPCMode.Others, " - ", str);
	}

}
