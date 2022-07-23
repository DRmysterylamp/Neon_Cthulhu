    
    
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    
    public class AnimControl: MonoBehaviour
    {
        public float move;
        public float moveSpeed;
        public float horizontal;
        private Rigidbody2D rig;
        private Animator anim;  //动画组件

        void Start()
        {
            rig = GetComponent<Rigidbody2D>();   //获取主角刚体组件
            anim = GetComponent<Animator>();
        }

        void Update()
        {

        horizontal = Input.GetAxis("Horizontal");   //水平方向按键偏移量
            move = horizontal * moveSpeed;   //刚体具体速度
            rig.velocity = new Vector2(move, rig.velocity.y);

            if(horizontal >0)                  // 播放向右走动画
            {
                anim.SetBool("IsRight", true);
                anim.SetBool("IsLeft", false);
            }
            else if(horizontal < 0)         // 播放向左走动画
            {
                anim.SetBool("IsLeft", true);
                anim.SetBool("IsRight", false);
            }
            else                                 //静止 Idle 动画
            {
                anim.SetBool("IsRight", false);
                anim.SetBool("IsLeft", false);
            }        
        }
    }