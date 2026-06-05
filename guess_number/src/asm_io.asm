; ============================================================
;  asm_io.asm  —  I/O helper library (NASM, Linux x86 32-bit)
;  Provides: print_string, print_int, print_nl, read_int
; ============================================================

global print_string, print_int, print_nl, read_int

section .data
    _nl         db 10               ; newline character
    _int_buf    times 12 db 0       ; buffer for int->string conversion
    _read_buf   times 16 db 0       ; buffer for keyboard input

section .text

; ── print_string ──────────────────────────────────────────
; IN : eax = pointer to null-terminated string
print_string:
    push eax
    push ebx
    push ecx
    push edx

    mov  ecx, eax           ; ecx = string pointer
    mov  edx, 0
.len_loop:
    cmp  byte [ecx + edx], 0
    je   .len_done
    inc  edx
    jmp  .len_loop
.len_done:
    mov  ebx, 1             ; fd = stdout
    mov  eax, 4             ; sys_write
    int  0x80

    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret

; ── print_nl ──────────────────────────────────────────────
; Prints a newline character
print_nl:
    push eax
    push ebx
    push ecx
    push edx
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, _nl
    mov  edx, 1
    int  0x80
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret

; ── print_int ─────────────────────────────────────────────
; IN : eax = signed 32-bit integer to print
print_int:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov  esi, _int_buf + 11
    mov  byte [esi], 0
    dec  esi

    ; check sign
    mov  edi, 0             ; edi = negative flag
    cmp  eax, 0
    jge  .positive
    mov  edi, 1
    neg  eax

.positive:
    mov  ecx, 10
.digit_loop:
    xor  edx, edx
    div  ecx
    add  dl, '0'
    mov  [esi], dl
    dec  esi
    cmp  eax, 0
    jne  .digit_loop

    ; prepend '-' if negative
    cmp  edi, 1
    jne  .print_it
    mov  byte [esi], '-'
    dec  esi

.print_it:
    inc  esi                ; esi now points to first char
    ; measure length
    mov  ecx, esi
    mov  edx, 0
.int_len:
    cmp  byte [ecx + edx], 0
    je   .int_len_done
    inc  edx
    jmp  .int_len
.int_len_done:
    mov  eax, 4
    mov  ebx, 1
    int  0x80

    pop  edi
    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret

; ── read_int ──────────────────────────────────────────────
; OUT: eax = integer read from stdin
read_int:
    push ebx
    push ecx
    push edx
    push esi

    ; read bytes from stdin
    mov  eax, 3
    mov  ebx, 0
    mov  ecx, _read_buf
    mov  edx, 15
    int  0x80

    mov  esi, _read_buf
    xor  eax, eax
    xor  ebx, ebx           ; sign flag

    cmp  byte [esi], '-'
    jne  .parse_digits
    mov  ebx, 1
    inc  esi

.parse_digits:
    movzx ecx, byte [esi]
    cmp  ecx, '0'
    jl   .parse_done
    cmp  ecx, '9'
    jg   .parse_done
    sub  ecx, '0'
    imul eax, eax, 10
    add  eax, ecx
    inc  esi
    jmp  .parse_digits

.parse_done:
    cmp  ebx, 1
    jne  .read_done
    neg  eax

.read_done:
    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    ret
