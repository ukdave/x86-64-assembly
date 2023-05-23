; -----------------------------------------------------------------------------
; A 64-bit program that displays its command line arguments, one per line.
;
; You know that in C, main is just a plain old function, and it has a couple
; parameters of its own:
;
; int main(int argc, char** argv)
;
; So, you guessed it, argc will end up in rdi, and argv (a pointer) will end
; up in rsi. Here is a program that uses this fact to simply echo the command
; line arguments to a program, one per line:
;
; To assemble and run:
;     nasm -fmacho64 cmdargs-mac.asm
;     ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lc -o cmdargs-mac cmdargs-mac.o
;     ./cmdargs-mac
; -----------------------------------------------------------------------------

          global    _main
          extern    _puts

          section   .text
_main:
          push      rdi             ; save registers that puts uses
          push      rsi
          sub       rsp, 8          ; must align stack before call

          mov       rdi, [rsi]      ; the argument string to display
          call      _puts           ; print it

          add       rsp, 8          ; restore %rsp to pre-aligned value
          pop       rsi             ; restore registers puts used
          pop       rdi

          add       rsi, 8          ; point to next argument
          dec       rdi             ; count down
          jnz       _main           ; if not done counting keep going

          ret
