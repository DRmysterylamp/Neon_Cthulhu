using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Data", menuName = "Charater Data")]
public class CharaterData : ScriptableObject
{
    [Header("»ù´¡ÊôÐÔ")]
    public int maxHealth;

    public int currentHealth;

    public int attack;
}
