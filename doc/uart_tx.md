# Basic UART Transmitter

A basic exaple of a UART transitter.

## Requirements

* the system shall be a simple demonstration of a UART Hardware Interface

* The System shall transmit the current value of a 8-bit register once a second

* with each transmission the value of the register transmitted shall increment by one

* if 0xFF is reached, the register shall return to 0 and continue from the beginning

## Design

### Inputs

rst; data:8 bit; config

### Output

uart_tx_pin

### Transmission Statemachine

| State | Val |
|---|---|
| IDLE | 0 |
| BUSY | 1 |
| ERROR | 2 |
| DONE | 3 |

A Bitcounter is used to keep track of where to transmit

### Transmission logic


IDLE -> wait for transmission start bit to be set

reset transmission start bit

BUSY -> send bit, increment counter -> BUSY

if counter >= 8 set DONE

DONE -> send stop bit; zero counter -> IDLE

----

rst -> TSM IDLE; CONFIG DONE = 0



### Clock

We want to implement UART with 9600 baud

This means, that a clock-divider is needed as the base clock speed is 12MHz.

Thereby a clockdiverder is needed with size of 32 bit

The `clock_divider` module provides the clock-dividing function

### Configuration Register

8-bit register

| 0     | 1    | 2   | 3    | 4| 5| 6| 7|
|-------|------|-----|------|--|--|--|--|
| Start | TSM0 | TSM1| DONE |  |  |  |  |