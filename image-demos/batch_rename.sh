#!/bin/bash

# 获取当前目录下所有文件（不包括文件夹和脚本自身）
files=($(ls -p | grep -v / | grep -v "$(basename $0)"))

count=1
for file in "${files[@]}"
do
    ext="${file##*.}"
    new_name=$(printf "%03d.%s" "$count" "$ext")
    # 如果新文件名已存在，跳过
    if [ -e "$new_name" ]; then
        echo "$new_name 已存在，跳过 $file"
    else
        mv "$file" "$new_name"
        echo "$file -> $new_name"
        ((count++))
        # 超过999则停止
        if [ $count -gt 999 ]; then
            break
        fi
    fi
done 