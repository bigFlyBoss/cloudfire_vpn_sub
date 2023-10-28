#!/bin/bash

# 清空 optimization_ip 文件
> optimization_ip

# 脚本返回的 IP 数据
ip_data=$(./cloudfare_ip.sh|jq -r '.info[].ip')

# 以换行符为分隔符将 IP 数据拆分成数组
IFS=$'\n' read -rd '' -a ips <<< "$ip_data"

original_string='vless://5a810cc5-1bd9-42e4-bafb-f8c5ed38dd51@172.67.82.190:443?encryption=none&security=tls&sni=qwer.smileday.club&fp=randomized&type=ws&host=qwer.smileday.club&path=%2F%3Fed%3D2048#172.67.82.190
'
# 循环遍历每个 IP
for ip in "${ips[@]}"; do
  # 替换字符串中的 IP
  replaced_string="${original_string/172.67.82.190/$ip}"
  # 进行 base64 转换
  base64_string=$(echo -n "$replaced_string" | base64)
  # 将转换后的字符串写入文件，每个字符串换行
  echo "$base64_string" >> optimization_ip
done
