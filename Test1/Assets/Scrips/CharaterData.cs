using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Data", menuName = "Charater Data")]
public class CharaterData : ScriptableObject
{
    [Header("基础属性")]
    public int maxHealth;

    public int currentHealth;

    public int attack;


    public bool isFear;     //恐惧；
    public bool isAnger;    //生气；
    public bool isConfuse;  //困惑;

    public bool eyeOpen;
    public bool earOpen;

}
