; コンパイル＋実行コマンド
; nasm -f elf32 overflow_flag.asm -o overflow_flag.o
; ld -m elf_i386 overflow_flag.o -o overflow_flag
; ./overflow_flag
; 最後の終了コードを出力
; echo $?
section .data
  num1 db 127 ; 126とするとセグフォが起きてechoの結果が139になる(why?)
  num2 db 1

section .text
  global _start

_start:
  mov al,[num1] ; num1の値をalにロード
  add al,[num2] ; al=al+num2

  ; 符号付きオーバーフローが起こったかどうかを判定
  jo overflow_result ; オーバーフローが怒ってたらジャンプ

  ; オーバーフローが怒ってない場合の処理
  mov eax, 0  ; 終了コード0で終了
  jmp end

overflow_result:
  ; オーバーフローが起こった場合の処理
  mov eax, 1  ; 終了コード1で終了

end:
  int 0x80  ; プログラム終了
