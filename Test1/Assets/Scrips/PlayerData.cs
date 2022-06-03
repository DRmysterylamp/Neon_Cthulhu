using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerData : MonoBehaviour
{
    public CharaterData charaterData;

    public int MaxHealth { get => charaterData?.maxHealth ?? 0; set => charaterData.maxHealth = value; }
    public int CurrentHealth { get => charaterData?.currentHealth ?? 0; set => charaterData.currentHealth = value; }

    public int attack{ get => charaterData?.attack ?? 0; set => charaterData.attack = value; }
}
