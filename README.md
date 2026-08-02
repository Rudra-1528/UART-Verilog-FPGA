# UART Transmitter and Receiver in Verilog

## Overview
This project implements a complete Universal Asynchronous Receiver-Transmitter (UART) from scratch using Verilog. The design includes a customizable Baud Rate Generator, a Transmitter FSM, and a Receiver FSM featuring middle-of-bit sampling for noise reduction.

## Key Features
* **Baud Rate Generator:** Custom clock divider to synchronize the fast FPGA clock down to standard UART speeds (e.g., 9600 baud).
* **Transmitter (TX):** Finite State Machine that packages 8-bit data with Start and Stop bits and shifts it out serially.
* **Receiver (RX):** Finite State Machine that detects the Start bit drop, waits half a bit duration to sample the data directly in the middle of the pulse, and reconstructs the byte.
* **Loopback Testbench:** Verified using a self-checking testbench where the TX pin is physically wired to the RX pin. 

## Simulation Results
<img width="1619" height="1019" alt="Screenshot 2026-08-02 010924" src="https://github.com/user-attachments/assets/4a75708b-be05-4165-b7dc-9b47d6a902b6" />

## RTL Schematic

<img width="1576" height="933" alt="Screenshot 2026-08-02 012436" src="https://github.com/user-attachments/assets/b61c43ed-e305-4e2e-93bf-8da843661906" />
