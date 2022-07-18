using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DialogSystem : MonoBehaviour
{
    [Header("UI组件")]
    public Text textLable;//存放panel->text
    public Image faceImage;//存放panel->image

    [Header("文本文件")]
    public TextAsset textFile;//存放BarText.txt
    public TextAsset textBranch1;//存放BranchText1.txt
    public TextAsset textBranch2;//存放BranchText2.txt
    public int index;//行数读取（用来观察不用更改）
    public float textSpeed;//文字逐个输出速度（可以加快打字速度）

    [Header("头像")]
    public Sprite Haley, Tom;//角色头像

    [Header("情绪(分支更改量）")]
    public bool branchEmotion;//！！！！获取情绪


    //用于实现逐字输出和快速显示整行
    bool typingFinished;//控制逐字输出
    bool typingCanceled;//控制快速显示整行


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
        typingFinished = true;
        StartCoroutine(SetTextUI());
    }

    // Update is called once per frame
    void Update()
    {
        
        if(Input.GetKeyDown(KeyCode.E)&& index == textList.Count)
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

        if(Input.GetKeyDown(KeyCode.E))
        {
            if(typingFinished && !typingCanceled)
            {
                StartCoroutine(SetTextUI());
            }
            else if(!typingFinished)
            {
                typingCanceled = !typingCanceled;
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
        typingFinished = false;
        textLable.text = "";

        switch(textList[index])
        {
            case "haley":
                faceImage.sprite = Haley;
                index++;
                break;
            case "tom":
                faceImage.sprite = Tom;
                index++;
                break;

            //！！！！进分支对话文件
            case "branch":
                faceImage.sprite = Tom;
                if (branchEmotion)
                {
                    GetTextFromFile(textBranch1);
                    switch (textList[index])
                    {
                        case "haley":
                            faceImage.sprite = Haley;
                            index++;
                            break;
                        case "tom":
                            faceImage.sprite = Tom;
                            index++;
                            break;
                    }
                    break;
                }
                else
                {
                    GetTextFromFile(textBranch2);
                    switch (textList[index])
                    {
                        case "haley":
                            faceImage.sprite = Haley;
                            index++;
                            break;
                        case "tom":
                            faceImage.sprite = Tom;
                            index++;
                            break;
                    }
                    break;
                }
        }


        //for(int i = 0; i < textList[index].Length; i++)
        //{
        //    textLable.text += textList[index][i];

        //    yield return new WaitForSeconds(textSpeed);
        //}
        int letter = 0;

        //逐字输入，typingCanceled改变为true就整行输出
        while (!typingCanceled && letter<textList[index].Length - 1)
        {
            textLable.text += textList[index][letter];
            letter++;
            yield return new WaitForSeconds(textSpeed);
        }
        textLable.text = textList[index];
        typingCanceled = false;
        typingFinished = true;
        index++;
    }
}
