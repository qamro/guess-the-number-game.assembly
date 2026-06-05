; ============================================================
;  guess_number.asm  —  Guess The Number Game
;  NASM, Linux x86 32-bit
;  Build: nasm -f elf32 -o guess_number.o guess_number.asm
;         ld -m elf_i386 -o guess_number guess_number.o
; ============================================================

%include "asm_io.asm"

global _start

; ── DATA SEGMENT ─────────────────────────────────────────
segment .data

    msg_title   db "========================================",10
                db "    GUESS THE NUMBER  [ 1 - 100 ]      ",10
                db "========================================",10,0

    msg_sep     db "----------------------------------------",0

    msg_prompt  db "  Enter your guess: ",0
    msg_high    db "  [HIGH] Too high! Try lower.",0
    msg_low     db "  [LOW]  Too low!  Try higher.",0
    msg_win     db "  *** CORRECT! Mabrok! You got it! ***",0
    msg_lose    db "  Game Over! The secret number was: ",0
    msg_att     db "  Attempts left: ",0
    msg_used    db "  Attempts used: ",0
    msg_used2   db " attempt(s).",0
    msg_invalid db "  [!] Invalid! Enter a number 1 to 100.",0
    msg_again   db "  Play again? (1=Yes  0=No): ",0
    msg_bye     db "  Goodbye! Thanks for playing!",0
    dev_rand    db "/dev/urandom",0

    secret      dd 0
    attempts    dd 7
    used        dd 0
    guess_val   dd 0

segment .bss
    rand_bytes  resb 4

; ── CODE ─────────────────────────────────────────────────
segment .text

_start:
    ; set up a fake frame so ebp is defined
    mov  ebp, esp

; ════════════════════════════════════════════════════════
GAME_START:
    mov  dword [attempts], 7
    mov  dword [used],     0
    mov  dword [guess_val], 0

    call GENERATE_RANDOM
    mov  [secret], eax

    mov  eax, msg_title
    call print_string

; ════════════════════════════════════════════════════════
GUESS_LOOP:
    mov  eax, msg_sep
    call print_string
    call print_nl

    mov  eax, msg_att
    call print_string
    mov  eax, [attempts]
    call print_int
    call print_nl

    mov  eax, msg_prompt
    call print_string
    call read_int
    mov  [guess_val], eax

    cmp  eax, 1
    jl   INVALID
    cmp  eax, 100
    jg   INVALID

    dec  dword [attempts]
    inc  dword [used]

    mov  eax, [guess_val]
    cmp  eax, [secret]
    je   CORRECT
    jg   TOO_HIGH

TOO_LOW:
    mov  eax, msg_low
    call print_string
    call print_nl
    jmp  CHECK_ATT

TOO_HIGH:
    mov  eax, msg_high
    call print_string
    call print_nl
    jmp  CHECK_ATT

INVALID:
    mov  eax, msg_invalid
    call print_string
    call print_nl
    jmp  GUESS_LOOP

CHECK_ATT:
    cmp  dword [attempts], 0
    je   GAME_OVER
    jmp  GUESS_LOOP

; ════════════════════════════════════════════════════════
CORRECT:
    mov  eax, msg_sep
    call print_string
    call print_nl
    mov  eax, msg_win
    call print_string
    call print_nl
    mov  eax, msg_used
    call print_string
    mov  eax, [used]
    call print_int
    mov  eax, msg_used2
    call print_string
    call print_nl
    jmp  ASK_AGAIN

; ════════════════════════════════════════════════════════
GAME_OVER:
    mov  eax, msg_sep
    call print_string
    call print_nl
    mov  eax, msg_lose
    call print_string
    mov  eax, [secret]
    call print_int
    call print_nl

; ════════════════════════════════════════════════════════
ASK_AGAIN:
    mov  eax, msg_sep
    call print_string
    call print_nl
    mov  eax, msg_again
    call print_string
    call read_int
    cmp  eax, 1
    je   GAME_START

; ════════════════════════════════════════════════════════
GAME_END:
    mov  eax, msg_bye
    call print_string
    call print_nl
    mov  eax, 1
    xor  ebx, ebx
    int  0x80

; ════════════════════════════════════════════════════════
GENERATE_RANDOM:
    push ebx
    push ecx
    push edx
    push esi

    mov  eax, 5
    mov  ebx, dev_rand
    xor  ecx, ecx
    xor  edx, edx
    int  0x80
    mov  esi, eax

    mov  eax, 3
    mov  ebx, esi
    mov  ecx, rand_bytes
    mov  edx, 4
    int  0x80

    mov  eax, 6
    mov  ebx, esi
    int  0x80

    movzx eax, byte [rand_bytes]
    movzx ebx, byte [rand_bytes+1]
    xor  eax, ebx
    movzx ebx, byte [rand_bytes+2]
    xor  eax, ebx
    movzx ebx, byte [rand_bytes+3]
    xor  eax, ebx
    and  eax, 0x7FFFFFFF
    mov  ebx, 100
    xor  edx, edx
    div  ebx
    mov  eax, edx
    inc  eax

    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    ret
