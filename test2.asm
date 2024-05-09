section .data                           ;Data segment
   userMsg db 'Please enter a number: ' ;Ask the user to enter a number
   lenUserMsg equ $-userMsg             ;The length of the message
   dispMsg db 'You have entered: '
   lenDispMsg equ $-dispMsg

section .bss           ;Uninitialized data
   num resb 5 ; resb:reserve bytes→5バイトメモリを予約を意味

section .text          ;Code Segment
   global _start

;先にメモ
;eax：システムコールの種類指定
;
;ebx：システムコールを実行する際に内部でアダプタ等が必要なら指定
;
;ecx：ファイルへの読み書きなどが必要な時にその対象を指定(高級言語の引数、内部で扱うデータに対応)
;
;edx：ecxで扱うデータの長さを処理機構に知らせる(そうしないと安全かつ正確な処理挙動が得られないため)
_start:                ;User prompt
   mov eax, 4 ; sys_write
   mov ebx, 1 ; ファイルディスクリプタ(stdout)
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 80h

   ;Read and store the user input
   mov eax, 3 ; sys_read
   mov ebx, 2 ; ファイルディスクリプタ(stdin)
   mov ecx, num
   mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information
   int 80h

   ;Output the message 'The entered number is: '
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 80h

   ;Output the number entered
   mov eax, 4
   mov ebx, 1
   mov ecx, num
   mov edx, 5
   int 80h

   ; Exit code
   mov eax, 1
   mov ebx, 0
   int 80h


