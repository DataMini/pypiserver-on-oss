# Pypi Server on Aliyun OSS 
[![Build and push Docker image](https://github.com/DataMini/pypiserver-on-oss/actions/workflows/docker-image-builder.yml/badge.svg)](https://github.com/DataMini/pypiserver-on-oss/actions/workflows/docker-image-builder.yml)

一个使用阿里云 OSS 作为后端文件存储的 Python 包管理服务器（PyPi Server），简单，上手容易

## 如何运行

### 一、使用docker运行

填上OSS的必要的配置即可。

```
docker run -d -P \
    -e OSS_BUCKET_PATH=oss://your-bucket/pypi/ \
    -e OSS_ENDPOINT=oss-cn-hongkong-internal.aliyuncs.com \
    -e OSS_ACCESS_KEY_ID=xxx \
    -e OSS_ACCESS_KEY_SECRET=xxx   \
    datamini/pypiserver-on-oss
```

### 二、使用docker-compose运行

示例：
```yaml
services:
  pypiserver:
    image: datamini/pypiserver-on-oss
    container_name: pypiserver
    ports:
      - 8080:8080
    environment:
      OSS_BUCKET_PATH: oss://your-bucket/pypi/
      OSS_SYNC_INTERVAL: 600
      OSS_ENDPOINT: oss-cn-hongkong-internal.aliyuncs.com
      OSS_ACCESS_KEY_ID: xxx
      OSS_ACCESS_KEY_SECRET: xxx
      PYPISERVER_USER: xxx
      PYPISERVER_PASSWORD: xxx
      PYPISERVER_PATH: /packages
```


## 如何使用


### 一、从私有仓库安装

> pip install docsbot  -i https://pypi.yourrepo.domain/


### 二、上传包到私有仓库


1. 修改本地 `~/.pypirc`

```
[distutils]
index-servers =
    pypi
    your_repo

[your_repo]
repository: https://pypi.yourrepo.domain/
username: username
password: 123456
```

2. 上传包

> twine upload --repository your_repo dist/*



