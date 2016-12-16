# ssserver
## 测试运行: 

- docker run -it --rm --name ssr -e PASSWORD=123456 shoaly/ssserver:ssr 
- python server.py -p 443 -k password -m aes-256-cfb -O origin -o http_simple
- 说明：-p 端口 -k 密码  -m 加密方式 -O 协议插件 -o 混淆插件
- https://bit.no.com:43110/shadowsocksr.bit
## 正式版本:
docker run -d --name ssserver  -e METHOD=chacha20 -e PASSWORD=123456 -p 58338:8388 --restart always shoaly/ssserver

## 更多说明


## 客户端

客户端的协议插件暂无配置参数，混淆插件有配置参数，混淆插件列表如下：

`plain`：不混淆，无参数

`http_simple`：简易伪装为http get请求，参数为要伪装的域名，如`cloudfront.com`。仅在C#版客户端上支持用逗号分隔多个域名如`a.com,b.net,c.org`，连接时会随机使用其中之一。不填写参数时，会使用此节点配置的服务器地址作为参数。

`http_post`：与`http_simple`绝大部分相同，区别是使用POST方式发送数据，符合http规范，欺骗性更好，但只有POST请求这种行为容易被统计分析出异常。参数配置与`http_simple`一样

`tls1.2_ticket_auth`：伪装为tls请求。参数配置与`http_simple`一样

其它插件不推荐使用，在这里忽略

客户端的协议插件，仅建议使用`origin`,`verify_sha1`,`auth_sha1_v2`,`auth_sha1_v4`,`auth_aes128_md5`,`auth_aes128_sha1`，解释如下：  
`origin`：原版协议，为了兼容  
`verify_sha1`：原版OTA协议，为了兼容  
`auth_sha1_v2`：中等安全性，无时间校对的要求，适合路由器或树莓派，混淆强度大  
`auth_sha1_v4`：较高安全性，有宽松的时间校对要求，混淆强度大  
`auth_aes128_md5`或`auth_aes128_sha1`：最高安全性，有宽松的时间校对要求，计算量相对高一些，混淆强度较大

如不考虑兼容，可无视前两个

## 服务端

大部分插件都可以通过添加`_compatible`后缀以表示兼容原版，例如默认的`http_simple_compatible`或`auth_sha1_v4_compatible`这样

服务端的协议插件，仅`auth_*`系列有协议参数，其值为整数。表示允许的同时在线客户端数量，建议最小值为2。默认值64

服务端的混淆插件，`http_simple`或`http_post`有混淆参数，用逗号分开若干个host，表示客户端仅能使用以上任一个host连接，而留空表示客户端可以使用任意host。`tls1.2_ticket_auth`有混淆参数，其值为整数，表示与客户端之间允许的UTC时间差，单位为秒，为0或不填写（默认）表示无视时间差

其它说明参见客户端部分

## 总结

如不考虑原版的情况下，推荐使用的协议，只有`auth_sha1_v4`和`auth_aes128_md5`和`auth_aes128_sha1`，推荐使用的混淆只有`plain`,`http_simple`,`http_post`,`tls1.2_ticket_auth`

不要奇怪为什么推荐`plain`，因为**混淆不总是有效果**，要看各地区的策略的，有时候不混淆让其看起来像随机数据更好