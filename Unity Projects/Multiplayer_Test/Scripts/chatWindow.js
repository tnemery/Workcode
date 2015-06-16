    import Debug;

  
    private var log:Array = new Array();
    private var scrollPos:Vector2 = Vector2(0, 0);
    private var lastLogLen:int = 0;
    var maxLogMessages:int = 200;
    var visible:boolean = true;
    var stringToEdit : String = "";
    var selectTextfield : boolean = true;
    var printGUIStyle:GUIStyle;
    var maxLogLabelHeight:float = 100.0f;

	function Awake()
	{
		if (Network.isClient)
			enabled = false;
	}


    function Start()
    {
    	Input.eatKeyPressOnTextFieldFocus = false;
        log.Add("Alpha Build 1.0");
    }

     

    function print(string:String)
    {
        log.push(string);
        if(log.length > maxLogMessages)
            log.RemoveAt(0);
    }

    function OnGUI()
    {
        if(visible)
        {
        	GUI.SetNextControlName ("chatWindow");
            stringToEdit = GUI.TextField (Rect (0.0, Screen.height - 50, 200, 20), stringToEdit, 25);
           	
            if (!selectTextfield) {
	        	GUI.FocusControl ("chatWindow");
        	}

            var logBoxWidth:float = 180.0;
            var logBoxHeights:float[] = new float[log.length];
            var totalHeight:float = 0.0;
            var i:int = 0;
            var innerScrollHeight:float = totalHeight;
            var currY:float = 0.0;

            for(var string:String in log)
            {
            	var logBoxHeight = Mathf.Min(maxLogLabelHeight, printGUIStyle.CalcHeight(GUIContent(string), logBoxWidth));
                logBoxHeights[i++] = logBoxHeight;
                totalHeight += logBoxHeight+10.0;
            }

            if(lastLogLen != log.length)
            {
                scrollPos = Vector2(0.0, innerScrollHeight);
                lastLogLen = log.length;
            }

            scrollPos = GUI.BeginScrollView(Rect(0.0, Screen.height-150.0-50.0, 200, 150), scrollPos, Rect(0.0, 0.0, 180, innerScrollHeight));
            i = 0;

            for(var string:String in log)
            {
                logBoxHeight = logBoxHeights[i++];
                GUI.Label(Rect(10, currY, logBoxWidth, logBoxHeight), string, printGUIStyle);
                currY += logBoxHeight+10.0;
            }
            GUI.EndScrollView();
        } 
    }

    function Update () 
    {
    	if(Input.GetKeyDown("return")) {
			if(selectTextfield){
				selectTextfield = !selectTextfield;
 			}
			if(stringToEdit != ""){
				log.Add("" + stringToEdit );
				stringToEdit = "";
			}
		}
		if(Input.GetKeyDown(KeyCode.LeftControl)){
			visible = !visible;
		}
	}
	
	function OnSerializeNetworkView(stream : BitStream , info : NetworkMessageInfo)
	{
		if (stream.isWriting)
		{
			if(Input.GetKeyDown("return")) {
				if(selectTextfield){
					selectTextfield = !selectTextfield;
 				}
				if(stringToEdit != ""){
					log.Add("" + stringToEdit );
					stringToEdit = "";
				}
			}
			//stream.Serialize();
		}
		else
		{
			
		}
	}