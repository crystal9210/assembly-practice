; コンパイル＋実行コマンド
; nasm -f elf32 sign_flag.asm -o sign_flag.o
; ld -m elf_i386 sign_flag.o -o sign_flag
; ./sign_flag
; 最後の終了コードを出力
; echo $?

section .data
  num1 db 4
  num2 db 5

section .text
  global _start

_start:
  mov al,[num1] ; num1の値をalにロード
  sub al,[num2] ; al=al-num2

  ; 結果が負かどうかを判定
  js negative_result ; 負ならジャンプ

  ; 負じゃない場合の処理
  mov eax, 0 ; 終了コード0で終了
  jmp end

negative_result:
  ; 負の場合の処理
  mov eax, 1  ; 終了コード1で終了

end:
  int 0x80  ; プログラム終了
