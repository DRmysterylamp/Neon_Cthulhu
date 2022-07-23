using UnityEngine;
using System.Collections;

public class Axis_rotator : MonoBehaviour {

	public float Yspeed =0;
	public float Xspeed =0;
	public float Zspeed = 0;

	private float xf;
	private float yf;
	private float zf;

	void Update () {
		yf += Yspeed * Time.deltaTime;
	    xf += Xspeed * Time.deltaTime; 
		zf += Zspeed * Time.deltaTime;	

		transform.localEulerAngles = new Vector3 (xf, yf, zf);
	
	}
}
