; ----------------------------------------------------------------------------------------
; Prints the numbers 1-10 using the C library printf function. Runs on 64-bit macOS only.
; To assemble and run:
;
;     nasm -fmacho64 numbers-mac.asm
;     ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lc -o numbers-mac numbers-mac.o
;     ./numbers-mac
; ----------------------------------------------------------------------------------------

          global    _main
          extern    _printf
          default   rel


          section   .text
_main:
          mov       rcx, 1                  ; initialise the counter to 1

print_loop:
          ; Print the counter
          push      rcx                     ; caller - save register
          lea       rdi, [format]           ; set 1st parameter (format)
          mov       rsi, rcx                ; set 2nd parameter (current number),
          call      _printf                 ; call the C library printf function
          pop       rcx                     ; restore caller-saved register

          ; Increment the counter and loop while <= 10
          inc       rcx                     ; increment the counter
          cmp       rcx, 11                 ; compare the counter value to 11
          jne       print_loop              ; jump to print_loop if not equal

          ; Exit the program
          mov       rax, 0                  ; set the exit code
          ret


          section   .data
format:   db        "%d", 10, 0             ; note the newline at and NULL characters at the end
