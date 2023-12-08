# 使用 Python 基础镜像
FROM python:3.8-slim

# 安装 pypiserver
RUN pip install pypiserver

# 下载 ossutil
ADD http://gosspublic.alicdn.com/ossutil/1.7.0/ossutil64 /usr/local/bin/ossutil
RUN chmod 755 /usr/local/bin/ossutil


# 安装 supervisord
RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# 添加同步脚本
COPY sync_to_oss.sh /sync_to_oss.sh
RUN chmod +x /sync_to_oss.sh

# 创建一个目录来存储包
RUN mkdir /packages

# 设置环境变量
ENV OSS_BUCKET_PATH=oss://your-bucket-name/pypi/
ENV LOCAL_REPO_PATH=/packages

# 同步间隔时间（以秒为单位），这里设为 10 分钟
ENV SYNC_INTERVAL=600

# 设置 OSS 环境变量
ENV OSS_ENDPOINT=
ENV ACCESS_KEY_ID=
ENV ACCESS_KEY_SECRET=

# 设置工作目录
WORKDIR /packages

# 配置启动命令
CMD ["/usr/bin/supervisord"]
