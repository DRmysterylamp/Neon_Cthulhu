using UnityEngine;
using System.Collections;

public class TextureSwitcher : MonoBehaviour {

	public Texture[] Textures;
	public Renderer TargetRendererMesh;


	public Color[] TexturesColors;

	public float MaxTime = 10;
	public float MinTime = 5;

	private float FinTime;
	private Color FinColor;


	// Use this for initialization
	void Start () {

		TextureSwitch ();
	
	}
	
	// Update is called once per frame
	void Update () {

		FinTime -= Time.deltaTime;
		if (FinTime < 0.0f)
		{
			TextureSwitch ();
		}

	
	}


	void TextureSwitch()
	{
		FinColor = TexturesColors[Random.Range(0,TexturesColors.Length)];
		TargetRendererMesh.material.mainTexture = Textures[Random.Range(0,Textures.Length)];

		TargetRendererMesh.material.SetColor ("_TintColor", FinColor);


		FinTime = Random.Range (MinTime, MaxTime);

	}
}
