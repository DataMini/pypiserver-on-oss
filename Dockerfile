# 使用 Python 基础镜像
FROM python:3.8-slim

# 安装 pypiserver with passlib
RUN pip install pypiserver['passlib']

# 安装 apache2-utils 来使用 htpasswd
RUN apt-get update && apt-get install -y apache2-utils


# 创建一个用于存储用户名和密码的目录
RUN mkdir /auth
# 创建一个目录来存储包
RUN mkdir /packages

# 复制 start_pypiserver.sh 到容器
COPY start_pypiserver.sh /start_pypiserver.sh
RUN chmod +x /start_pypiserver.sh

# 可以是 update,download,list
ENV PYPISERVER_AUTHENTICATE=update,download
ENV PYPISERVER_USER=
ENV PYPISERVER_PASSWORD=
ENV PYPISERVER_PATH=/packages


# 下载 ossutil
ADD http://gosspublic.alicdn.com/ossutil/1.7.0/ossutil64 /usr/local/bin/ossutil
RUN chmod 755 /usr/local/bin/ossutil
# 添加同步脚本
COPY sync_to_oss.sh /sync_to_oss.sh
RUN chmod +x /sync_to_oss.sh


# 设置环境变量
ENV OSS_BUCKET_PATH=oss://your-bucket-name/pypi/
# 同步间隔时间（以秒为单位），这里设为 10 分钟
ENV OSS_CYNC_INTERVAL=600
# 设置 OSS 环境变量
ENV OSS_ENDPOINT=
ENV OSS_ACCESS_KEY_ID=
ENV OSS_ACCESS_KEY_SECRET=


# 安装 supervisord
RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 设置工作目录
WORKDIR /packages

EXPOSE 8080

# 配置启动命令
CMD ["/usr/bin/supervisord"]
