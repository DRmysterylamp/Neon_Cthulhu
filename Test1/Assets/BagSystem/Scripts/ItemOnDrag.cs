using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
public class ItemOnDrag : MonoBehaviour,IBeginDragHandler,IDragHandler,IEndDragHandler
{
    private RectTransform rectTrans;
    public Transform originalParent;
    public Inventory myBag;
    private int currentItemID;//当前物品ID

    private void Start()
    {
        rectTrans = GetComponent<RectTransform>();
    }
    public void OnBeginDrag(PointerEventData eventData)
    {
        originalParent = transform.parent;
        currentItemID = originalParent.GetComponent<Slot>().slotID;
        transform.SetParent(transform.parent.parent.parent.parent);
        //transform.SetParent(transform.parent.parent);
        //transform.position = eventData.position;

        GetComponent<CanvasGroup>().blocksRaycasts = false;//射线阻挡关闭
    }

    public void OnDrag(PointerEventData eventData)
    {
        //transform.position = eventData.position;
        rectTrans.anchoredPosition += eventData.delta;
        //transform.position = Input.mousePosition;
        Debug.Log(eventData.pointerCurrentRaycast.gameObject.name);//输出鼠标当前位置下第一个碰到的物品名字
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        //交换物品位置
        if (eventData.pointerCurrentRaycast.gameObject.name == "Item_Image")//鼠标下是ItemImage则互换位置
        {
            transform.SetParent(eventData.pointerCurrentRaycast.gameObject.transform.parent.parent);
            transform.position = eventData.pointerCurrentRaycast.gameObject.transform.parent.parent.position;
            //更改itemList中物品存储位置
            var temp = myBag.itemList[currentItemID];
            myBag.itemList[currentItemID] = myBag.itemList[eventData.pointerCurrentRaycast.gameObject.GetComponentInParent<Slot>().slotID];
            myBag.itemList[eventData.pointerCurrentRaycast.gameObject.GetComponentInParent<Slot>().slotID] = temp;

            eventData.pointerCurrentRaycast.gameObject.transform.parent.position = originalParent.position;
            eventData.pointerCurrentRaycast.gameObject.transform.parent.SetParent(originalParent);

            GetComponent<CanvasGroup>().blocksRaycasts = true;//射线阻挡开启，否则无法再次选中物品
            return;
        }
        else if (eventData.pointerCurrentRaycast.gameObject.name == "Item_Slot(Clone)")//鼠标下是空格则互换位置
        {
            transform.SetParent(eventData.pointerCurrentRaycast.gameObject.transform);
            transform.position = eventData.pointerCurrentRaycast.gameObject.transform.position;
            //更改itemList中物品存储位置
            myBag.itemList[eventData.pointerCurrentRaycast.gameObject.GetComponentInParent<Slot>().slotID] = myBag.itemList[currentItemID];
            //解决物品放回原位的问题
            if(eventData.pointerCurrentRaycast.gameObject.GetComponent<Slot>().slotID != currentItemID)
                myBag.itemList[currentItemID] = null;
            GetComponent<CanvasGroup>().blocksRaycasts = true;
            return;
        }
        else
        {
            transform.position = originalParent.position;
            transform.SetParent(originalParent);
            GetComponent<CanvasGroup>().blocksRaycasts = true;
            return;
        }
        GetComponent<CanvasGroup>().blocksRaycasts = true;
    }

   

}
