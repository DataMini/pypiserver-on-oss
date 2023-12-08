#!/bin/bash

# 检查环境变量是否设置
if [ -z "$OSS_ENDPOINT" ] || [ -z "$OSS_ACCESS_KEY_ID" ] || [ -z "$OSS_ACCESS_KEY_SECRET" ]; then
    echo "Error: OSS configuration environment variables are not set."
    exit 1
fi

# 配置 ossutil
ossutil config -e $OSS_ENDPOINT -i $OSS_ACCESS_KEY_ID -k $OSS_ACCESS_KEY_SECRET -L CH

# 循环同步
while true; do
    # 同步数据到 OSS
    ossutil sync $PYPISERVER_PATH $OSS_BUCKET_PATH --delete

    # 等待一定时间
    sleep $OSS_CYNC_INTERVAL
done
