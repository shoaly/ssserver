# ssserver
## 测试运行: 
- docker run -it --rm --name ssserver  -e METHOD=chacha20 -e PASSWORD=123456 -p 58338:8388 shoaly/ssserver:master

- docker run -it --rm --name ssr -e PASSWORD=123456 shoaly/ssserver:ssr


## 正式版本:
docker run -d --name ssserver  -e METHOD=chacha20 -e PASSWORD=123456 -p 58338:8388 --restart always shoaly/ssserver:master

