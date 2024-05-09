section .data
    prompt db 'Enter some text:', 0xA  ; 改行文字を追加
    prompt_len equ $ - prompt          ; プロンプトの実際の長さを計算

section .bss
    input resb 100                    ; 100バイトのバッファを確保

section .text
    global _start

_start:
    ; プロンプトを表示する
    mov edx, prompt_len               ; プロンプトの長さ
    mov ecx, prompt                   ; プロンプトのアドレス
    mov ebx, 1                        ; 標準出力（変更点）
    mov eax, 4                        ; sys_write
    int 0x80

    ; ユーザーからの入力を読み取る
    mov edx, 100                      ; バッファのサイズ
    mov ecx, input                    ; バッファのアドレス
    mov ebx, 0                        ; 標準入力
    mov eax, 3                        ; sys_read
    int 0x80

    ; eaxに読み取ったバイト数が格納される
    mov ebx, eax                      ; 読み取ったバイト数をebxに保存
    dec ebx                           ; 改行文字のバイトを除く

    ; 入力されたデータを表示（改行文字を除外）
    mov edx, ebx                      ; 表示するデータの長さをedxにセット
    mov ecx, input                    ; 表示するデータのアドレス
    mov ebx, 1                        ; 標準出力（変更点）
    mov eax, 4                        ; sys_write
    int 0x80

    ; プログラムの終了
    mov eax, 1                        ; sys_exit
    int 0x80
