using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PropTest : MonoBehaviour
{
    public int data;
    private void Awake()
    {
        data = 10;
    }
    private void OnMouseDown()
    {
        ItemManager.Instance.UpdateData(data);
    }


}
