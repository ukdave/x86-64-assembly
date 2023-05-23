; -----------------------------------------------------------------------------
; A 64-bit program that displays "Hello x" where x is the first command line argument.
;
; To assemble and run:
;     nasm -fmacho64 cmdargs2-mac.asm
;     ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lc -o cmdargs2-mac cmdargs2-mac.o
;     ./cmdargs2-mac
; -----------------------------------------------------------------------------

          global    _main
          extern    _printf
          default   rel


          section   .text
_main:
          cmp       rdi, 2                     ; check we got 2 command line args
          jne       _error

          push      rdi                        ; save registers that printf uses
          push      rsi
          sub       rsp, 8                     ; must align stack before call

          lea       rdi, [message]             ; set 1st parameter (format)
          mov       rsi, [rsi+8]               ; set 2nd parameter (first command line arg)
          call      _printf                    ; print it

          add       rsp, 8                     ; restore %rsp to pre-aligned value
          pop       rsi                        ; restore registers printf used
          pop       rdi

          mov       rax, 0                     ; set the exit code
          ret

_error:
          sub       rsp, 8                     ; must align stack before call

          lea       rdi, [error]               ; set 1st parameter (format)
          mov       rsi, [rsi]                 ; set 2nd parameter (zeroth command line arg)
          call      _printf                    ; print it

          add       rsp, 8                     ; restore %rsp to pre-aligned value

          mov       rax, 1                     ; set the exit code
          ret


          section   .data
message:  db        "Hello %s", 10, 0          ; note the newline at and NULL characters at the end
error:    db        "Usage: %s <name>", 10, 0
