using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VirtualTest : MonoBehaviour
{
    public float timer = 10f;

    private void Awake()
    {
        PlayerDataManager.Instance.IsFear = true;
        Debug.Log(PlayerDataManager.Instance.IsFear);
    }
    private void Update()
    {
        timer -= Time.deltaTime;
        if (timer <= 0)
        {
            PlayerDataManager.Instance.IsFear = false;
            Destroy(gameObject);
        }
    }
    private void OnMouseDown()
    {
        timer+=5f;
    }
}
