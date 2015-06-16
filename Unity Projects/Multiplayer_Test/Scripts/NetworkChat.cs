using UnityEngine;
using System.Collections;
using System;

public class NetworkChat : MonoBehaviour 
{
	private string gameName = "ecampus101";
	private string serverName = "test", port = "23466", customName = "";
	private Rect windowRect = new Rect(0, 0, 400, 400);
	public GameObject networkprefab;

	void Awake(){
		MasterServer.ipAddress = "128.193.165.163";
		MasterServer.port = 23466;
		//Network.InitializeSecurity();
		//Network.InitializeServer(10, int.Parse(port), !Network.HavePublicAddress());
		//MasterServer.RegisterHost (gameName, serverName);
		//Network.natFacilitatorIP = MasterServer.ipAddress;
		//Network.natFacilitatorPort = 50005;
	}

	private void OnGUI()
	{
		if (Network.peerType == NetworkPeerType.Disconnected)
		{
			windowRect = GUI.Window (0, windowRect, windowFunc, "Servers:(Drag Window)");

		}
		else
		{
			if (GUILayout.Button ("Disconnect"))
			{
				Network.Disconnect ();
				MasterServer.UnregisterHost();
				Application.LoadLevel ("Gallery");
				Destroy(GameObject.Find ("NetworkOld"));
				GameObject myobj = Instantiate (networkprefab) as GameObject;
				myobj.name = "NetworkOld";
			}
		}
	}
	
	private void windowFunc(int id)
	{
		MasterServer.RequestHostList (gameName);
		if (GUILayout.Button ("Refresh"))
		{
			MasterServer.RequestHostList (gameName);
		}
		GUILayout.BeginHorizontal ();
		
		GUILayout.Box ("Server Name");
		
		GUILayout.EndHorizontal ();
		
		if (MasterServer.PollHostList().Length != 0)
		{
			HostData[] data = MasterServer.PollHostList ();
			foreach(HostData c in data)
			{
				GUILayout.BeginHorizontal ();
				GUILayout.Box (c.gameName);
				if(GUILayout.Button ("Connect"))
				{
					Network.Connect (c);
				}
				GUILayout.EndHorizontal ();
			}
		}else{
			GUILayout.Label ("<color=#800000>Server Name</color>");
			serverName = GUILayout.TextField (serverName);
			
			GUILayout.Label ("<color=#800000>Game Name</color>");
			customName = GUILayout.TextField (customName);
			
			GUILayout.Label ("<color=#800000>Port</color>");
			port = GUILayout.TextField (port);
			
			if ( GUILayout.Button ("Create Server"))
			{
				try
				{
					Network.InitializeSecurity();
					Network.InitializeServer(10, int.Parse(port), !Network.HavePublicAddress());
					MasterServer.RegisterHost (gameName, serverName);
					Network.InitializeServer(32, 25002, !Network.HavePublicAddress());
					MasterServer.RegisterHost("ecampus101", customName, "l33t game for all");
					
				}
				catch (Exception)
				{
					print ("Please Type in numbers for port and max players");
				}
			}
		}
		
		GUI.DragWindow (new Rect (0, 0, Screen.width, Screen.height));
	}
}