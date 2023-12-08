# pypiserver-with-oss


## 如何运行

示例：
使用docker-compose运行
```yaml
services:
  pypiserver:
    image: datamini/pypiserver-on-oss:3.0
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


- 上传


修改本地 `~/.pypirc`

```
[distutils]
index-servers =
    pypi
    your_repo

[datamini]
repository: https://pypi.yourrepo.domain/
username: username
password: 123456
```


