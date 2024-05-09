section .data
    num1 dd 5          ; 32 ビット値として num1 を定義
    num2 dd 10         ; 32 ビット値として num2 を定義
    msg db "Result: ", 0  ; 結果表示用のメッセージ
    newline db 10, 0       ; 改行

section .bss
    result resd 1      ; 32 ビット値として result を定義（未初期化）
    buffer resb 12     ; 結果を格納するためのバッファ

section .text
    global _start

_start:
    ; num1 と num2 の加算
    mov eax, [num1]     ; 32 ビット値 num1 を eax にロード
    add eax, [num2]     ; 32 ビット値 num2 を eax に追加
    mov [result], eax   ; 結果を 32 ビット値として result に保存

    ; 結果の表示
    ; "Result: " メッセージを表示
    mov edx, 8          ; メッセージの長さ
    mov ecx, msg        ; メッセージのアドレス
    mov ebx, 1          ; 標準出力
    mov eax, 4          ; sys_write
    int 0x80

    ; 整数を文字列に変換して表示
    mov eax, [result]   ; 加算結果を eax にロード
    call int_to_ascii   ; 数値を文字列に変換

    ; 変換した文字列を表示
    mov edx, 12         ; バッファの最大サイズ
    mov ecx, buffer     ; バッファのアドレス
    mov ebx, 1          ; 標準出力
    mov eax, 4          ; sys_write
    int 0x80

    ; 改行を表示
    mov edx, 1          ; 改行の長さ
    mov ecx, newline    ; 改行のアドレス
    mov ebx, 1          ; 標準出力
    mov eax, 4          ; sys_write
    int 0x80

    ; プログラムの終了
    mov eax, 1          ; sys_exit
    xor ebx, ebx       ; ステータス 0
    int 0x80

; 関数：int_to_ascii
; eax にある整数値を 10 進数の文字列に変換し、buffer に格納する
int_to_ascii:
    mov ecx, buffer + 11  ; バッファの終端
    mov byte [ecx], 0     ; 終端文字をセット

convert_loop:
    dec ecx               ; 次の文字位置に移動
    mov edx, 0            ; レジスタ edx をクリア
    mov ebx, 10           ; 除算のためのベース 10
    div ebx               ; eax を 10 で割り、商が eax、余りが edx に
    add dl, '0'           ; 余りを文字に変換
    mov [ecx], dl         ; バッファに文字を格納
    test eax, eax         ; eax が 0 かどうかを確認
    jnz convert_loop      ; 0 でなければループ継続

    ret
