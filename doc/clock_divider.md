# Clock Divider

## Requirements

* The module shall provide a devided clock
* on and off times should be equal
* the divisor shall be configurable with a 32-bit value

## Design

### Inputs

* clock
* reset
* divisor[0:31]

### Outputs

* clock_new

### Internals

32 bit counter incrementing on clk posflank

## Testbench

testbench demonstrating requirements

