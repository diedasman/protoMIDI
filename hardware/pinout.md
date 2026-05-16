# protoMIDI Rev A Pinout

This is the working firmware pinout from `PLAN.md`. It is expected to change
while the physical board is validated.

## ZMK Target

- Current board target: `nice_nano_v2`
- Current shield: `protomidi`
- Firmware path: `firmware/config/boards/shields/protomidi`

## Matrix

Diode direction: `col2row`

| Matrix position | Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- | --- |
| Row 0 | PB86-1/PB86-2 row | `006` | `&gpio0 6` |
| Row 1 | PB86-3/PB86-4 row | `008` | `&gpio0 8` |
| Row 2 | Encoder push row | `017` | `&gpio0 17` |
| Col 0 | PB86-1/PB86-3/encoder push column | `020` | `&gpio0 20` |
| Col 1 | PB86-2/PB86-4/unused column | `100` | `&gpio1 0` |

Logical matrix:

| | COL0 | COL1 |
| --- | --- | --- |
| ROW0 | PB86-1 | PB86-2 |
| ROW1 | PB86-3 | PB86-4 |
| ROW2 | ENC_PUSH | unused |

## Encoder

| Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- |
| Encoder A | `022` | `&gpio0 22` |
| Encoder B | `024` | `&gpio0 24` |
| Encoder common | GND | GND |

## Deferred Signals

| Function | Planned GPIO label | Status |
| --- | --- | --- |
| Shared LED PWM | `115` or other PWM-capable free pin | Deferred until input firmware works |
| OLED SDA | board I2C SDA pin | Deferred until board target is confirmed |
| OLED SCL | board I2C SCL pin | Deferred until board target is confirmed |
| VCC cutoff | `P0.13` | Reserved; do not use as normal I/O |

## Validation Notes

- Confirm the chosen board target exposes all selected GPIOs as usable pins.
- Confirm `P1.00` is physically available and not reserved on the selected
  board variant.
- Confirm the matrix diode orientation matches `col2row` before soldering Rev A.
- Confirm encoder direction after flashing; swap A/B in firmware if rotation is
  inverted.

