; コンパイル＋実行コマンド
; nasm -f elf32 carry_flag.asm -o carry_flag.o
; ld -m elf_i386 carry_flag.o -o carry_flag
; ./carry_flag
; 最後の終了コードを出力
; echo $?

; 説明：Carry Flagは符号なし演算においてキャリーが発生したときにセットされる
; キャリーとは：

section .data
  num1 db 200 ; ここを100にするとキャリーを防げる
  num2 db 100

section .text
  global _start

_start:
  mov al, [num1] ; num1をalにロード
  add al, [num2] ; al=al+num2

  ; キャリーが起ったかどうかを判定
  jc carry_result ; キャリーが起こったらジャンプ

   ; キャリーが起こってない場合の処理
  mov eax, 1      ; システムコール番号 (exit)
  xor ebx, ebx    ; 終了ステータス 0
  int 0x80        ; システムコール呼び出し

carry_result:
  ; キャリーが起こった場合の処理
  mov eax, 1      ; システムコール番号 (exit)
  mov ebx, 1      ; 終了ステータス 1
  int 0x80        ; システムコール呼び出し

end:
  int 0x80 ; プログラム終了
