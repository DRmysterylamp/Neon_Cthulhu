using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DialogSystem : MonoBehaviour
{
    [Header("UI���")]
    public Text textLable;//���panel->text
    public Image faceImage;//���panel->image

    [Header("�ı��ļ�")]
    public TextAsset textFile;//���BarText.txt
    public TextAsset textBranch1;//���BranchText1.txt
    public TextAsset textBranch2;//���BranchText2.txt
    public int index;//������ȡ�������۲첻�ø��ģ�
    public float textSpeed;//�����������ٶȣ����Լӿ�����ٶȣ�

    [Header("ͷ��")]
    public Sprite Haley, Tom;//��ɫͷ��

    [Header("����(��֧��������")]
    public bool branchEmotion;//����������ȡ����


    //����ʵ����������Ϳ�����ʾ����
    bool typingFinished;//�����������
    bool typingCanceled;//���ƿ�����ʾ����


    //��ʱ����б�
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



    //��ȡ�ı�
    void GetTextFromFile(TextAsset file)
    {
        textList.Clear();//��ʾ����
        index = 0;

        var lineData = file.text.Split('\n');//�ı��ָ�����

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

            //������������֧�Ի��ļ�
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

        //�������룬typingCanceled�ı�Ϊtrue���������
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
