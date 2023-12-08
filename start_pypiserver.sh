#!/bin/bash

# 检查用户名和密码环境变量是否设置
if [ -n "$PYPISERVER_USER" ] && [ -n "$PYPISERVER_PASS" ]; then
    # 创建 htpasswd 文件
    htpasswd -cb /auth/htpasswd $PYPISERVER_USER $PYPISERVER_PASS
    # 启动 pypiserver 带有认证
    exec pypi-server -p 8080 -P /auth/htpasswd -a 'update,download' /packages
else
    # 启动 pypiserver 无认证
    exec pypi-server -p 8080 /packages -a. -P .
fi