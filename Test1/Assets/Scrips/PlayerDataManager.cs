using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerDataManager : MonoBehaviour
{
    public CharaterData charaterData;
    private static PlayerDataManager instance;

    public static PlayerDataManager Instance { get => instance; }
    public int MaxHealth { get => charaterData?.maxHealth ?? 0; set => charaterData.maxHealth = value; }
    public int CurrentHealth { get => charaterData?.currentHealth ?? 0; set => charaterData.currentHealth = value; }
    public int Attack{ get => charaterData?.attack ?? 0; set => charaterData.attack = value; }
    public bool IsFear { get => charaterData.isFear; set => charaterData.isFear = value; }  
    public bool IsAnger { get => charaterData.isAnger; set => charaterData.isAnger = value; } 
    public bool IsConfuse { get => charaterData.isConfuse; set => charaterData.isConfuse = value; }
    public bool EyeOpen { get => charaterData.eyeOpen; set => charaterData.eyeOpen = value; }
    public bool EarOpen { get => charaterData.earOpen; set => charaterData.earOpen = value; }

    private void Awake()
    {
        if (instance != null) Destroy(gameObject);
        instance = this;
    }

 

}
