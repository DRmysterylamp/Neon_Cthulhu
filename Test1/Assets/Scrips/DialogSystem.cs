using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DialogSystem : MonoBehaviour
{
    [Header("UI���")]
    public Text textLable;//��ŶԻ�UI
    public Image faceImage;//������ͷ��

    [Header("�ı��ļ�")]
    public TextAsset textFile;//��ŶԻ��ı�
    public int index;//������ȡ
    public float textSpeed;//�����������ٶ�

    [Header("ͷ��")]
    public Sprite face01, face02;//��ɫͷ��


    //����ʵ����������Ϳ�����ʾ����
    bool textFinished;//�����������
    bool cancelTyping;//���ƿ�����ʾ����


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

        //�������룬cancelTyping�ı�Ϊtrue���������
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
