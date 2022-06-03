using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    [Header("速度参数")]
    public float speed = 12f;
    [Header("重力加速度")]
    public float gravity = -9.81f;
    [Header("跳跃高度")]
    public float jumpHeight = 3f;
    
    [Header("地面检测")]
    public Transform groundCheck;
    public float groundDistance = 0.2f;
    public LayerMask GroundMask;

    private CharacterController chara;
    private PlayerData playerData;

    private Vector3 velocity;
    private bool isGround;
    private void Awake()
    {
        chara = GetComponent<CharacterController>();
        playerData = GetComponent<PlayerData>();
        
    }
    private void Update()
    {
        Movement();
    }
    
    void Movement()
    {
        //水平移动
        var horizontal = Input.GetAxisRaw("Horizontal");
        if (horizontal > 0)
        {
            transform.localRotation = Quaternion.Euler(0, 0, 0);

        }
        else if (horizontal < 0)
        {
            transform.localRotation = Quaternion.Euler(0, 180, 0);
        }

        chara.Move(new Vector3(horizontal, 0, 0) * speed * Time.deltaTime);


        //竖直移动
        velocity.y += 1.5f*gravity * Time.deltaTime;

        chara.Move(velocity * Time.deltaTime);

        isGround = Physics.CheckSphere(groundCheck.position, groundDistance, GroundMask);

        if (isGround && velocity.y < 0)
        {
            velocity.y = -1f;
        }

        //跳跃
        if (Input.GetButtonDown("Jump") && isGround)
        {
            velocity.y = Mathf.Sqrt(-2 * jumpHeight * gravity); //v=sqrt（2gh）；
        }
    }


}
