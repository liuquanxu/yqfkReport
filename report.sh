#!/usr/bin/env bash
curl 'https://app.upc.edu.cn/uc/wap/login/check' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'DNT: 1' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Origin: https://app.upc.edu.cn' \
  -H 'Referer: https://app.upc.edu.cn/uc/wap/login?redirect=https%3A%2F%2Fapp.upc.edu.cn%2Fncov%2Fwap%2Fdefault%2Findex' \
  -H 'Accept-Language: zh-CN,zh;q=0.9' \
  --data-raw "username=${username}&password=${password}" -c cookie.txt  --compressed
  content=`curl -b cookie.txt 'https://app.upc.edu.cn/ncov/wap/default/index'  \
  -H 'Connection: keep-alive' -H 'X-Requested-With:XMLHttpRequest'\
  -H 'Cache-Control: max-age=0' \
  -H 'DNT: 1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7'  \
  --compressed | jq '.d | .oldInfo.date = .info.date | .oldInfo.id = .info.id | .oldInfo.created = .info.created | .oldInfo |to_entries|map("\(.key)=\(.value|tostring)") |.|join("&")'`

  curl -X POST 'https://app.upc.edu.cn/ncov/wap/default/save' \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'DNT: 1' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Origin: https://app.upc.edu.cn' \
  -H 'Referer: https://app.upc.edu.cn/uc/wap/login?redirect=https%3A%2F%2Fapp.upc.edu.cn%2Fncov%2Fwap%2Fdefault%2Findex' \
  -d "$content"  -b cookie.txt \
  --compressed
