using UnityEngine;
using System;

public class ItemManager : MonoBehaviour
{
    private static ItemManager instance;

    public event Action<int> updateData;
    public event Action updateUI;
    public event Action updateItem;
    public static ItemManager Instance
    {
        get => instance;
    }
    private void Awake()
    {
        if (instance != null)
        {
            Destroy(gameObject);
        }
        instance = this;
    }
    public void UpdateData(int data)
    {
        if (updateData == null) return;
        else updateData(data);
    }
    public void UpdateUI()
    {
        if (updateUI == null) return;
        else updateUI();
    }
    public void UpdateItem()
    {
        if (updateItem == null) return;
        else updateItem();
    }
}
