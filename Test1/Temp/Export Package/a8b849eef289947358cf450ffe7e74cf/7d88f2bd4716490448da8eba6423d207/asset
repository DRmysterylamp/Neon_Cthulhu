using UnityEngine;
using System.Collections;

public class Panner : MonoBehaviour {

	public Renderer PanMat;

	public float Uspeed;
	public float Vspeed;

	private float uP;
	private float vP;

	private float Ttt;

	void Update ()
	{

	 
		uP = Uspeed * Time.time;
		vP = Vspeed * Time.time;

	
		PanMat.material.mainTextureOffset = new Vector2 (uP, vP);



			
	}
}
