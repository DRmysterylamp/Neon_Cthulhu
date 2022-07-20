using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovementSP : MonoBehaviour
{
    [Header("�ٶȲ���")]
    public float speed = 12f;
    [Header("�������ٶ�")]
    public float gravity = -9.81f;
    [Header("��Ծ�߶�")]
    public float jumpHeight = 3f;
    
    [Header("������")]
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
        Test();
    }
    
    void Movement()
    {
        //ˮƽ�ƶ�
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


        //��ֱ�ƶ�
        velocity.y += 1.5f*gravity * Time.deltaTime;

        chara.Move(velocity * Time.deltaTime);

        isGround = Physics.CheckSphere(groundCheck.position, groundDistance, GroundMask);

        if (isGround && velocity.y < 0)
        {
            velocity.y = -1f;
        }

        //��Ծ
        if (Input.GetButtonDown("Jump") && isGround)
        {
            velocity.y = Mathf.Sqrt(-2 * jumpHeight * gravity); //v=sqrt��2gh����
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Enemy"))
        {
            playerData.CurrentHealth -= 2;
        }
        Debug.Log(playerData.CurrentHealth);

        
    }

    void Test()
    {
        var ray = new Ray(transform.position, transform.right);
      
        RaycastHit rh;
        if (Physics.Raycast(ray, out rh,1f))
        {
            
            if (rh.collider.gameObject.CompareTag("Enemy"))
            {
                playerData.CurrentHealth -= 2;
                Debug.Log(playerData.CurrentHealth);
                if (playerData.CurrentHealth <= 0)
                {
                    Debug.Log("player die");

                    playerData.MaxHealth <<= 1;
                    playerData.CurrentHealth = playerData.MaxHealth;
                }
            }
        }
    }
}
