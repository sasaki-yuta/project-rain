/**
 * @file Hippocampus.c
 * @brief 海馬.c
 * @brief 大脳辺縁系の海馬実装部
 * @author rain
 * @date 2019/09/08 新規作成
 * @copyright 2019 project rain
 */
#include <stdio.h>
#include <pthread.h>
#include <sys/msg.h>
#include "Hippocampus.h"

extern void *threadHippocampus(void *arg);

// プロセスmainスレッド
int main(void)
{
    /* サブスレッド生成 */
    pthread_t subThread;
    if (0 !=  pthread_create(&subThread, NULL, threadHippocampus, NULL))
    {
        return 0;
    }

    /* サブスレッドの終了を待つ */
    if (0 != pthread_join(subThread, NULL))
    {
        return 0;
    }

    return 0;
}

/* Hippocampusスレッド */
void *threadHippocampus(void *arg)
{
    /* メッセージ */
    MessageHippocampus message;
    MessageHippocampusData message_data;

    /* メッセージキューのID */
    int msqid;
    long msgtyp;
    if(!CreateHippocampusMessageKey(&msqid, &msgtyp))
    {
        return NULL;
    }

    /* メッセージループ */
    while (1)
    {
        printf("loop start \n");
        if(msgrcv(msqid, &message, sizeof(message_data), msgtyp, 0) != -1)
        {
        }
    }
}

/* メッセージ生成 */
bool CreateHippocampusMessageKey(int *msqid, long *msgtyp)
{
    bool ret = false;

    if (NULL != msqid && NULL != msgtyp) {
        /* メッセージID生成 */
        if((*msqid = msgget((key_t)1111, 0666 | IPC_CREAT)) != -1)
        {
            /* メッセージタイプ生成 */
            *msgtyp = 999;
            ret = true;
        }
    }

    return ret;
}