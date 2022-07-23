using UnityEngine;
using System.Collections;

public class LocalScalePulse : MonoBehaviour {


	public float pulseSpeed = 1;
	public float MaxScale = 1;




	private float scaleL;



	void Update () {

		scaleL = 1 + Mathf.PingPong (Time.time * pulseSpeed , MaxScale);

		transform.localScale = new Vector3 (scaleL, scaleL, scaleL);
	
	}
}
