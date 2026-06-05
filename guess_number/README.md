# Guess The Number — Assembly x86 (NASM / Linux)

لعبة تخمين الأرقام مكتوبة بلغة Assembly x86 32-bit لنظام Linux.

## هيكل الملفات

```
guess_number/
├── src/
│   ├── asm_io.asm          ← مكتبة I/O (print_string, read_int, ...)
│   └── guess_number.asm    ← الكود الرئيسي للعبة
├── build/                  ← ملفات .o (تُنشأ تلقائياً)
├── Makefile
└── README.md
```

## المتطلبات

```bash
# Ubuntu / Debian / WSL
sudo apt install nasm binutils

# إذا كنت على نظام 64-bit وتريد تشغيل 32-bit
sudo apt install gcc-multilib
```

## البناء والتشغيل

```bash
make          # بناء اللعبة فقط
make run      # بناء وتشغيل مباشرة
make clean    # حذف ملفات البناء
```

## الإجراءات المُعرَّفة (asm_io.asm)

| الإجراء        | المدخل       | الوظيفة                    |
|----------------|--------------|----------------------------|
| print_string   | eax = pointer | طباعة نص (null-terminated) |
| print_int      | eax = integer | طباعة رقم صحيح            |
| print_nl       | —             | طباعة سطر جديد (newline)  |
| read_int       | —             | قراءة رقم → eax           |

## المفاهيم المُستخدَمة

- **Segments**: .data, .bss, .text
- **Syscalls**: sys_write (4), sys_read (3), sys_open (5), sys_close (6), sys_exit (1)
- **Interrupts**: int 0x80
- **Instructions**: MOV, CMP, JE/JG/JL/JMP, PUSH/POP, INC/DEC, DIV, XOR, AND, IMUL
- **Registers**: eax, ebx, ecx, edx, esi, edi, esp, ebp
- **Procedures**: CALL / RET with stack frame
