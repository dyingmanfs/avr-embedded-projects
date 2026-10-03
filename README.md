# ATmega128 Embedded Systems Projects

A collection of embedded systems projects developed using **AVR Assembly** for the **ATmega128 microcontroller**.

The repository demonstrates a progression from basic I/O and arithmetic programming to timer-driven control systems, interrupts, pedestrian-crossing logic, 7-segment displays, and LCD interfacing.

## Projects

### Project 1 – ATmega128 6-Bit Calculator

A 6-bit calculator implemented in AVR Assembly.

The calculator reads two unsigned values from input ports and performs one of four arithmetic operations:

- Addition
- Subtraction
- Multiplication
- Division

The operation is selected through a dedicated input port.

The project also includes:

- SRAM result storage
- Multi-byte multiplication results
- Quotient and remainder storage
- Invalid-operation detection
- Division error handling

Input/output organization:

```text
PORTA → First operand
PORTB → Second operand
PORTC → Operation selector
PORTD.0 → Error indicator
```

Supported operations:

```text
1 → Addition
2 → Subtraction
3 → Multiplication
4 → Division
```

Result memory locations:

| Operation | Memory Address |
|---|---|
| Addition | `0x0120` |
| Subtraction | `0x0121` |
| Multiplication High Byte | `0x0122` |
| Multiplication Low Byte | `0x0123` |
| Division Quotient | `0x0124` |
| Division Remainder | `0x0125` |

---

### Project 2 – 3-Way Traffic Light Controller

A traffic-control system for a three-way intersection using the **ATmega128**.

The system controls:

- WEST route
- EAST route
- NORTH Route 1
- NORTH Route 2

The traffic sequence is timer controlled.

Main timing:

```text
Green → 15 seconds
Yellow → 3 seconds
Red → controlled by traffic phase
```

The project also implements a pedestrian-crossing system using external interrupts.

When a pedestrian request is triggered:

1. NORTH green lights blink
2. NORTH traffic is stopped
3. Red lights are activated
4. A pedestrian crossing period begins
5. A 7-segment display counts down from 9 to 0
6. Normal traffic operation resumes

The project uses:

- Timer0
- Timer1
- External interrupts
- GPIO
- 7-segment display
- AVR Assembly
- Proteus simulation

---

### Project 3 – Traffic Light Controller with LCD

Project 3 extends the traffic-light system with a **16×2 LCD interface**.

The LCD displays the current state of the intersection during each traffic phase.

Example display:

```text
WEST/EAST GO
NORTH1/2 STOP
```

Other states include:

```text
WEST/EAST SLOW
NORTH1/2 READY
```

```text
WEST/EAST STOP
NORTH1/2 GO
```

```text
WEST/EAST READY
NORTH1/2 SLOW
```

The final system combines:

- Traffic light sequencing
- AVR timers
- External interrupts
- Pedestrian crossing
- 7-segment countdown
- 16×2 LCD interfacing
- GPIO control
- AVR Assembly

## Repository Structure

```text
atmega128-embedded-projects/
│
├── project-1-calculator/
│   ├── Project1/
│   └── Project1.atsln
│
├── project-2-traffic-light/
│   ├── project2task1/
│   │   ├── project2task1/
│   │   └── project2task1.atsln
│   │
│   └── project2task2/
│
├── project-3-traffic-light-lcd/
│   ├── proje3/
│   └── proje3.atsln
│
├── README.md
└── .gitignore
```

## Technologies

- AVR Assembly
- ATmega128
- Atmel Studio / Microchip Studio
- Proteus Professional
- Embedded Systems
- Microcontroller Programming

## Concepts Practiced

- GPIO programming
- AVR registers
- Assembly language
- SRAM access
- Arithmetic operations
- Conditional branching
- Timers
- Interrupt Service Routines
- External interrupts
- Traffic-control state sequencing
- 7-segment display interfacing
- LCD interfacing
- Embedded system simulation

## Development Progression

The three projects demonstrate increasing embedded-system complexity:

```text
Project 1
Basic AVR Assembly
I/O + Arithmetic
        ↓
Project 2
Timers + Interrupts
Traffic Control + Pedestrian Crossing
        ↓
Project 3
LCD Interfacing
Extended Traffic Control System
```

## Academic Context

These projects were developed as part of:

**CNG336 – Introduction to Embedded Systems Development / EEE347 – Introduction to Microprocessors**

at **METU Northern Cyprus Campus**.

## Contributors

- Furkan Sağlam
- Fatih Sağlam

## Keywords

`AVR` `ATmega128` `Assembly` `Embedded Systems` `Microcontroller` `Timers` `Interrupts` `LCD` `7-Segment` `Proteus`
