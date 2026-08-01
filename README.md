# UART Transmitter and Receiver in Verilog

## Overview
This project implements a complete Universal Asynchronous Receiver-Transmitter (UART) from scratch using Verilog. The design includes a customizable Baud Rate Generator, a Transmitter FSM, and a Receiver FSM featuring middle-of-bit sampling for noise reduction.

## Key Features
* **Baud Rate Generator:** Custom clock divider to synchronize the fast FPGA clock down to standard UART speeds (e.g., 9600 baud).
* **Transmitter (TX):** Finite State Machine that packages 8-bit data with Start and Stop bits and shifts it out serially.
* **Receiver (RX):** Finite State Machine that detects the Start bit drop, waits half a bit duration to sample the data directly in the middle of the pulse, and reconstructs the byte.
* **Loopback Testbench:** Verified using a self-checking testbench where the TX pin is physically wired to the RX pin. 

## Simulation Results


## RTL Schematic
Screenshot 2026-08-02 012436.png
