//#pragma strict

var dragging: boolean = false; //!!!? maybe this should be a single global? so you can't drag one thing yellow, and hover another thing blue?
var speed : int= 50; //used to affect rotation speed

internal var yrot  = 0.0;

function Start () {
//colorStore = renderer.material.color ;
    var angles = transform.eulerAngles;
    yrot = angles.y;
                if (rigidbody)
                                rigidbody.freezeRotation = true;// Make the rigid body not change rotation
}

function Update () {
                if (dragging){
                yrot += Input.GetAxis("Mouse X") * speed * 0.02;
             
                var yrot2 = 0;
                var chkTri : int = Mathf.Floor(yrot / 60);
                
                if(chkTri == 1)    yrot2 = 60;
                if(chkTri == 2) yrot2 = 120;
                
                if(yrot >= 180) yrot = 0;
                Debug.Log("yrot: " + yrot + ", yrot2: " + yrot2 + ", chkTri: " + chkTri);
                
                var rotation : Quaternion;
                if (name == "LensWheel"){
                                rotation = Quaternion.Euler(0, yrot2, 0);
    }else{
                rotation = Quaternion.Euler(0, yrot, 0);
                    }
                    transform.rotation = rotation;
                }
}

function OnMouseDown () { //highlight
               // OrbitVariableDistance.dragFlag = false;
                dragging = true;
}