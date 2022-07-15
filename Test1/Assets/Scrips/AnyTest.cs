using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnyTest : PropBase
{
    public float thisTimer = 10f;
    protected override void Start()
    {
        base.Start();
        timer = thisTimer;
    }
  
    protected override void OnTriggerEnter(Collider other)
    {
        base.OnTriggerEnter(other);
        
    }
}
