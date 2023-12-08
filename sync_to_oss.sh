#!/bin/bash

# 检查环境变量是否设置
if [ -z "$OSS_ENDPOINT" ] || [ -z "$ACCESS_KEY_ID" ] || [ -z "$ACCESS_KEY_SECRET" ]; then
    echo "Error: OSS configuration environment variables are not set."
    exit 1
fi

# 配置 ossutil
ossutil config -e $OSS_ENDPOINT -i $ACCESS_KEY_ID -k $ACCESS_KEY_SECRET -L CH

# 循环同步
while true; do
    # 同步数据到 OSS
    ossutil sync $LOCAL_REPO_PATH $OSS_BUCKET_PATH --delete

    # 等待一定时间
    sleep $SYNC_INTERVAL
done
