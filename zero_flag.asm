;実行コマンド
;nasm -f elf32 zero_flag.asm -o zero_flag.o
;ld -m elf_i386 zero_flag.o -o zero_flag
;./zero_flag
;echo $? ... 終了コードを確認するためのechoコマンド
section .data
  num1 db 5
  num2 db 5 ; ここの5を他の整数にすると1が出力されるようになる、内部でフラグビットを確認する処理が走り、その値によって処理のジャンプ先が変わるため

section .text ; プログラムの実行可能なコード(命令)を含むセクション、_startはプログラムのエントリポイント、global指令は指定されたシンボルを外部から参照可能にするためのもの、_startシンボルをglobalとして宣言することでリンカが_startをエントリポイントとして認識する
  global _start

_start:
  mov al, [num1]  ; num1の値をalにロード
  sub al, [num2]  ; al=al-num2

  ; 結果がゼロかどうかを判定
  jz zero_result  ;0(Zero Flagがセットされている)ならジャンプ

  ; 0でない場合の処理
  mov eax, 1      ; sys_exitシステムコール番号
  mov ebx, 1      ; 終了コード1
  int 0x80        ; プログラム終了
  jmp end

zero_result:
  ; 0の場合の処理
  mov eax, 0  ; 終了コード0で終了
  mov ebx, 0      ; 終了コード0
  int 0x80        ; プログラム終了

end:
    ; ここには到達しないが、プログラムの終端として残す
    mov eax, 1
    mov ebx, 0
    int 0x80
