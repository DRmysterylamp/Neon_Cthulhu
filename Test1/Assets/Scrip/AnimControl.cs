    
    
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    
    public class AnimControl: MonoBehaviour
    {
        public float move;
        public float moveSpeed;
        public float horizontal;
        private Rigidbody2D rig;
        private Animator ani;  //动画组件

        void Start()
        {
            rig = GetComponent<Rigidbody2D>();   //获取主角刚体组件
            ani = GetComponent<Animator>();
        }

        
        void Update () 
        {
            float h = Input.GetAxis("Horizontal");
            float v = Input.GetAxis("Vertical");
            ani.SetFloat ("vert",v);
            ani.SetFloat ("hori",h);
        }
    }