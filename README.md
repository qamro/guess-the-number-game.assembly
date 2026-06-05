<div align="center">

```
 _____ _   _ _____ _____ _____   _____ _   _  _____
|  __ \ | | |  ___/  ___/  ___| |_   _| | | ||  ___|
| |  \/ | | | |__ \ `--. \ `--.    | | | |_| || |__
| | __| | | |  __| `--. \`--. \   | | |  _  ||  __|
| |_\ \ |_| | |___/\__/ /\__/ /   | | | | | || |___
 \____/\___/\____/\____/\____/    \_/ \_| |_/\____/

 _   _ _   _ __  __ ____  _____ ____
| \ | | | | |  \/  |  _ \| ____|  _ \
|  \| | | | | |\/| | |_) |  _| | |_) |
| |\  | |_| | |  | |  _ <| |___|  _ <
|_| \_|\___/|_|  |_|_| \_\_____|_| \_|
```

[![Language](https://img.shields.io/badge/x86_Assembly-NASM-brightgreen?style=for-the-badge&logo=assemblyscript)](https://nasm.us)
[![Platform](https://img.shields.io/badge/Linux-32--bit-orange?style=for-the-badge&logo=linux)](https://kernel.org)
[![School](https://img.shields.io/badge/ESTIN-CS_Year_1-blue?style=for-the-badge)](https://estin.dz)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

---

## 🖥️ Preview

<br>

<img width="1919" height="1037" alt="Preview" src="https://github.com/user-attachments/assets/df8577c5-fb5f-4755-b56a-6c915c140571" />

</div>

---

## 📖 About

**Guess The Number** is a fully interactive terminal game written in **x86 Assembly (NASM)** for Linux.
The computer secretly picks a number between **1 and 100** using true randomness from `/dev/urandom` — and you have **7 attempts** to find it, guided by smart hints after every guess.

This project demonstrates core low-level programming concepts including syscalls, registers, stack management, procedures, and memory segments — all without a single line of C or Python.

---

## 🎯 Project Goal

> The goal of this project is to apply the fundamentals of **x86 Assembly language** in a real, working program — going beyond simple print statements and actually building interactive logic, I/O handling, random number generation, and reusable procedures entirely at the hardware level.

This is a hands-on way to understand:
- How a CPU really executes instructions
- How memory is organized in segments
- How Linux syscalls work under the hood
- How functions are built manually using the stack

---

## ✨ Features

| | Feature | Description |
|---|---|---|
| 🎲 | **True Randomness** | Secret number generated from `/dev/urandom` — never the same |
| 💬 | **Smart Hints** | `[HIGH]` or `[LOW]` feedback after every guess |
| ✅ | **Input Validation** | Rejects numbers outside `[1..100]` without wasting a turn |
| 🔄 | **Play Again** | Instant rematch without restarting the binary |
| 🏆 | **Score Display** | Shows how many attempts you used when you win |
| ⌨️ | **Backspace Support** | Fix typos while typing your guess |
| 💀 | **Game Over** | Reveals the secret number if you run out of attempts |

---

## 🕹️ How to Play

1. Run the game with `./guess_number`
2. A secret number between **1 and 100** is chosen
3. Enter your guess and press **Enter**
4. You get a hint — `[HIGH]` means guess lower, `[LOW]` means guess higher
5. Keep guessing until you find it or run out of **7 attempts**
6. Win or lose — you can always play again!

---

## 📁 Structure

```
guess_number/
├── src/
│   ├── asm_io.asm        ← I/O library  (print, read)
│   └── guess_number.asm  ← Game logic
├── Makefile
└── README.md
```

---

## 🚀 Build & Run

```bash
# Install tools (once)
sudo apt install nasm binutils

# On 64-bit systems also run
sudo apt install gcc-multilib

# Build & play
make run
```

---

## 📚 Procedures

| Procedure | Input | Description |
|---|---|---|
| `print_string` | `eax` = pointer | Print a null-terminated string |
| `print_int` | `eax` = number | Print a signed integer |
| `print_nl` | — | Print a newline |
| `read_int` | — | Read integer from stdin → `eax` |
| `GENERATE_RANDOM` | — | `/dev/urandom` → `[1..100]` in `eax` |

---

## 👨‍💻 Author

<div align="center">

<img src="https://avatars.githubusercontent.com/u/0?v=4" width="80" style="border-radius:50%"/>

### Bakhouche Mohamed Qamar Eddine

🎓 Computer Science Student — **1st Year**
🏫 [ESTIN](https://estin.dz) — Higher School of Computer Science, Béjaïa, Algeria
💻 Passionate about low-level programming & computer architecture

[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat-square&logo=github)](https://github.com/qamro)

</div>

---

## 📜 License

feel free to use, modify, and distribute it.

---

<div align="center">

*Made with ❤️ and* `INT 0x80` — **ESTIN CS · Year 1 · Algeria**

</div>
