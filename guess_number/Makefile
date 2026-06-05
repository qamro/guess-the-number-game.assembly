# ============================================================
#  Makefile — Guess The Number (NASM Linux x86 32-bit)
#  asm_io.asm is %include'd into guess_number.asm directly,
#  so only one .o file is compiled.
# ============================================================

ASM     = nasm
LD      = ld
AFLAGS  = -f elf32
LFLAGS  = -m elf_i386

SRC     = src/guess_number.asm
OBJ     = build/guess_number.o
TARGET  = guess_number

.PHONY: all clean run

all: build $(TARGET)

build:
	mkdir -p build

$(OBJ): $(SRC) src/asm_io.asm
	$(ASM) $(AFLAGS) -I src/ -o $(OBJ) $(SRC)

$(TARGET): $(OBJ)
	$(LD) $(LFLAGS) -o $@ $^
	@echo ""
	@echo "  Build successful!  Run with:  make run"
	@echo ""

run: all
	./$(TARGET)

clean:
	rm -rf build $(TARGET)
