using UnityEngine;
using System.Collections;

public class splitScreen : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	
	void OnGUI (){
		GUI.depth = 2;
		GUIHelper.DrawLine(new Vector2(Screen.width/2-1, 0), new Vector2(Screen.width/2-1, Screen.height), Color.black);
		GUIHelper.DrawLine(new Vector2(Screen.width/2, 0), new Vector2(Screen.width/2, Screen.height), Color.black);
		GUIHelper.DrawLine(new Vector2(Screen.width/2+1, 0), new Vector2(Screen.width/2+1, Screen.height), Color.black);
	}
}


#region external class for drawing lines

public class GUIHelper

{

    protected static bool clippingEnabled;

    protected static Rect clippingBounds;

    protected static Material lineMaterial;

 

    /* @ Credit: "http://cs-people.bu.edu/jalon/cs480/Oct11Lab/clip.c" */

    protected static bool clip_test(float p, float q, ref float u1, ref float u2)

    {

        float r;

        bool retval = true;

        if (p < 0.0)

        {

            r = q / p;

            if (r > u2)

                retval = false;

            else if (r > u1)

                u1 = r;

        }

        else if (p > 0.0)

        {

            r = q / p;

            if (r < u1)

                retval = false;

            else if (r < u2)

                u2 = r;

        }

        else

            if (q < 0.0)

                retval = false;

 

        return retval;

    }

 

    protected static bool segment_rect_intersection(Rect bounds, ref Vector2 p1, ref Vector2 p2)

    {

        float u1 = 0.0f, u2 = 1.0f, dx = p2.x - p1.x, dy;

        if (clip_test(-dx, p1.x - bounds.xMin, ref u1, ref u2))

            if (clip_test(dx, bounds.xMax - p1.x, ref u1, ref u2))

            {

                dy = p2.y - p1.y;

                if (clip_test(-dy, p1.y - bounds.yMin, ref u1, ref u2))

                    if (clip_test(dy, bounds.yMax - p1.y, ref u1, ref u2))

                    {

                        if (u2 < 1.0)

                        {

                            p2.x = p1.x + u2 * dx;

                            p2.y = p1.y + u2 * dy;

                        }

                        if (u1 > 0.0)

                        {

                            p1.x += u1 * dx;

                            p1.y += u1 * dy;

                        }

                        return true;

                    }

            }

        return false;

    }

 

    public static void BeginGroup(Rect position)

    {

        clippingEnabled = true;

        clippingBounds = new Rect(0, 0, position.width, position.height);

        GUI.BeginGroup(position);

    }

 

    public static void EndGroup()

    {

        GUI.EndGroup();

        clippingBounds = new Rect(0, 0, Screen.width, Screen.height);

        clippingEnabled = false;

    }

 

    public static void DrawLine(Vector2 pointA, Vector2 pointB, Color color)

    {

        if (clippingEnabled)

            if (!segment_rect_intersection(clippingBounds, ref pointA, ref pointB))

                return;

 

        if (!lineMaterial)

        {

            /* Credit:  */

            lineMaterial = new Material("Shader \"Lines/Colored Blended\" {" +

           "SubShader { Pass {" +

           "   BindChannels { Bind \"Color\",color }" +

           "   Blend SrcAlpha OneMinusSrcAlpha" +

           "   ZWrite Off Cull Off Fog { Mode Off }" +

           "} } }");

            lineMaterial.hideFlags = HideFlags.HideAndDontSave;

            lineMaterial.shader.hideFlags = HideFlags.HideAndDontSave;

        }

 

        lineMaterial.SetPass(0);

        GL.Begin(GL.LINES);

        GL.Color(color);

        GL.Vertex3(pointA.x, pointA.y, 0);

        GL.Vertex3(pointB.x, pointB.y, 0);

        GL.End();

    }

};

#endregion