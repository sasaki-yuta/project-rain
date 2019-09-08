/**
 * @file Hippocampus.h
 * @brief 海馬ヘッダ
 * @brief 大脳辺縁系の海馬ヘッダファイル
 * @author rain
 * @date 2019/09/08 新規作成
 * @copyright 2019 project rain
 */
#ifndef ___HIPPOCAMPUS_H___
#define ___HIPPOCAMPUS_H___

#include <stdbool.h>

#define MQ_MEMORY_DATA_SIZE 50

/* メッセージデータ */
typedef struct MessageHippocampusData {
    char data1[MQ_MEMORY_DATA_SIZE];
    char data2[MQ_MEMORY_DATA_SIZE];
    char data3[MQ_MEMORY_DATA_SIZE];
    char data4[MQ_MEMORY_DATA_SIZE];
    char data5[MQ_MEMORY_DATA_SIZE];
} MessageHippocampusData;

/* メッセージキューで送受信するメッセージ */
typedef struct MessageHippocampus {
    long msgtyp; /* message type, must be > 0 */
    MessageHippocampusData data;
} MessageHippocampus;

/* メッセージ生成 */
bool CreateHippocampusMessageKey(int *msqid, long *msgtyp);

#endif /* ___HIPPOCAMPUS_H___ */