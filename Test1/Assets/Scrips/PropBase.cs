using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PropBase : MonoBehaviour
{
    
    public GameObject virtualObject;

    protected bool isActive;

    protected float timer;
   
    protected virtual void Start()
    {
        isActive = false;
    }
    protected virtual void OnTriggerEnter(Collider other)
    {
        virtualObject.SetActive(true);
        isActive = true;

    } 
}
