section .data
  msg db 'Hello World!',0xa ; 0xaは0と何が違うか、たぶんxaが改行
  len equ $ - msg ; length of the string

section .text
  global _start

_start:
  mov edx, len ; メッセージの長さを指定
  mov ecx, msg ; メッセージを指示
  mov ebx, 1 ; ファイル記述子(標準出力)
  mov eax, 4 ; システムコール番号(sys_write)
  int 0x80 ; システムコールを呼び出す

  mov eax, 1 ; システムコール番号(sys_exit)
  int 0x80 ; システムコールを呼び出して終了
  ; アセンブリコードを機械語にコンパイルするコマンド(下)
  ; nasm -f elf64 hello.asm -o hello.o
  ; ./hello
  ; 復習：

;   プログラム中で使用される各レジスタ (edx, ecx, ebx, eax) が保持する値と、それらがどのように使用されるかについて詳しく説明します。この説明は、アセンブリ言語のプログラムがシステムコールを使ってどのように動作するかを理解するのに役立ちます。

; edx レジスタ
; 用途: このレジスタは通常、データのサイズ（長さ）や数値の限界などを保持するために使用されます。
; プログラム中での使用: edxにはメッセージ「Hello World!」のバイト数、すなわち13をロードします。これはsys_writeシステムコールを使用してデータを書き込むとき、カーネルにこのデータの長さを伝えるために必要です。
; ecx レジスタ
; 用途: ecxはしばしばカウンターとして使用されますが、データのアドレス（ポインター）を保持するのにも使われます。
; プログラム中での使用: ecxには「Hello World!」という文字列データが格納されているメモリアドレス（helloラベルのアドレス）をロードします。sys_writeシステムコールにおいて、このレジスタが指し示すアドレスからデータを読み取り、指定されたデバイス（ここでは標準出力）に送ります。
; ebx レジスタ
; 用途: ebxはベースアドレスを保持するためのものですが、関数やシステムコールの引数としても使用されます。
; プログラム中での使用: ebxにはsys_writeシステムコールでデータを送信するデバイスのファイル記述子、ここでは標準出力を示す1をロードします。これにより、書き込む対象が標準出力であることをシステムに伝えます。
; eax レジスタ
; 用途: eaxはアキュムレータとして一般的に使用され、算術演算の結果を保持したり、システムコールの番号を保持するのに使われます。
; プログラム中での使用:
; 最初に、eaxにはsys_writeのシステムコール番号4をロードします。これはOSに対して「データを書き込む」というアクションを要求します。
; 次に、プログラムの終了を指示するためにeaxにsys_exitのシステムコール番号1をロードします。
; システムコールの実行: int 0x80
; この命令は、レジスタに設定されたシステムコール番号に基づいてカーネルにサービスを要求します。eaxで指定されたシステムコール番号に応じて、カーネルはebx, ecx, edxに格納されたデータを使用して指定された操作を実行します。

; このように、各レジスタはプログラム内で特定の役割を持ち、これらのレジスタを使ってプロセッサは効率的にデータを処理し、システムコールを通じてオペレーティングシステムと通信します。アセンブリ言語を使用することで、これらの低レベルの操作がどのように行われるかを詳細に制御することが可能です。






