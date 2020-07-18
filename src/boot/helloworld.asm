; Copyright (c) 2020 Seymour Zhang<zsh2401@163.com>
; This file is licensed under Mulan PSL v2.
; You can use this software according to the terms and conditions of the Mulan PSL v2.
; You may obtain a copy of Mulan PSL v2 at:
; http://license.coscl.org.cn/MulanPSL2
; THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
; EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
; MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
; See the Mulan PSL v2 for more details.

mbrseg         equ    7c0h     ;启动扇区存放段地址

jmp   start
message:       db 'hello,worldxxxx','$'

start:
      mov   ax,mbrseg
      mov   ds,ax
      mov   si,message
      call  printstr

printstr:                  ;显示指定的字符串, 以'$'为结束标记
      mov al,[si]
      cmp al,'$'            ;判断是否打印完
      je disover            ;打印完了,跳到discover
      mov ah,0eh            
      int 10h               ;触发10h中断
      inc si                ;si++
      jmp printstr
disover:
      ret

times 510-($-$$) db 0       ;将剩余字节用0填满到510地址
db 0x55,0xaa                ;标记这是启动扇区