using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DialogSystem : MonoBehaviour
{
    [Header("UI组件")]
    public Text textLable;//存放对话UI
    public Image faceImage;//存放玩家头像

    [Header("文本文件")]
    public TextAsset textFile;//存放对话文本
    public int index;//行数读取
    public float textSpeed;//文字逐个输出速度

    [Header("头像")]
    public Sprite face01, face02;//角色头像


    //用于实现逐字输出和快速显示整行
    bool textFinished;//控制逐字输出
    bool cancelTyping;//控制快速显示整行


    //临时存放列表
    List<string> textList = new List<string>();

    void Awake()
    {
        GetTextFromFile(textFile);
    }

    private void OnEnable()
    {
        //textLable.text = textList[index];
        //index++;
        textFinished = true;
        StartCoroutine(SetTextUI());
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.R)&& index == textList.Count)
        {
            gameObject.SetActive(false);
            index = 0;
            return;
        }
        //if(Input.GetKeyDown(KeyCode.R)&& textFinished) 
        //{
        //    //textLable.text = textList[index];
        //    //index++;

        //    StartCoroutine(SetTextUI());
        //}

        if(Input.GetKeyDown(KeyCode.R))
        {
            if(textFinished && !cancelTyping)
            {
                StartCoroutine(SetTextUI());
            }
            else if(!textFinished)
            {
                cancelTyping = !cancelTyping;
            }
        }
    }



    //读取文本
    void GetTextFromFile(TextAsset file)
    {
        textList.Clear();//显示单行
        index = 0;

        var lineData = file.text.Split('\n');//文本分割条件

        foreach(var line in lineData)
        {
            textList.Add(line);
        }
    }



    IEnumerator SetTextUI()
    {
        textFinished = false;
        textLable.text = "";

        switch(textList[index])
        {
            case "haley":
                faceImage.sprite = face01;
                index++;
                break;
            case "tom":
                faceImage.sprite = face02;
                index++;
                break;
        }


        //for(int i = 0; i < textList[index].Length; i++)
        //{
        //    textLable.text += textList[index][i];

        //    yield return new WaitForSeconds(textSpeed);
        //}
        int letter = 0;

        //逐字输入，cancelTyping改变为true就整行输出
        while(!cancelTyping && letter<textList[index].Length - 1)
        {
            textLable.text += textList[index][letter];
            letter++;
            yield return new WaitForSeconds(textSpeed);
        }
        textLable.text = textList[index];
        cancelTyping = false;
        textFinished = true;
        index++;
    }
}
