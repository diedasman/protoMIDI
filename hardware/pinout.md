# protoMIDI Rev A Pinout

This is the final firmware pinout for the first full Rev A build.

## ZMK Target

- Current board target: `nice_nano_v2`
- Current shield: `protomidi`
- Firmware path: `firmware/config/boards/shields/protomidi`

## Matrix

Diode direction: `col2row`

| Matrix position | Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- | --- |
| Row 0 | PB86-1/PB86-2 encoder push row | `115` | `&gpio1 15` |
| Row 1 | PB86-3/PB86-4 row | `011` | `&gpio0 11` |
| Col 0 | PB86-1/PB86-3 | `002` | `&gpio0 02` |
| Col 1 | PB86-2/PB86-4/unused column | `111` | `&gpio1 11` |
| Col 2 | Encoder push column | `029` | `&gpio0 29` |

Logical matrix:

| | COL0 | COL1 | COL2 |
| --- | --- | --- | --- |
| ROW0 | PB86-1 | PB86-2 | ENC_PUSH |
| ROW1 | PB86-3 | PB86-4 | unused |

## Encoder

| Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- |
| Encoder A | `024` | `&gpio0 24` |
| Encoder B | `022` | `&gpio0 22` |
| Encoder common | GND | GND |

## OLED Display

The current full build enables the 2.42 inch 128x64 SSD1309 OLED using Zephyr's
SSD1306-compatible I2C display driver.

| Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- |
| OLED SDA | `106` | `NRF_PSEL(TWIM_SDA, 1, 6)` |
| OLED SCL | `104` | `NRF_PSEL(TWIM_SCL, 1, 4)` |

The shield overlay overrides the `nice_nano_v2` I2C defaults and uses
`P1.06`/`P1.04` for the OLED.

## Validation Notes

- Confirm the chosen board target exposes all selected GPIOs as usable pins.
- Confirm `P1.15` is physically available and not reserved on the selected board
  variant.
- Confirm the matrix diode orientation matches `col2row` before soldering Rev A.
- Confirm encoder direction after flashing; swap A/B in firmware if rotation is
  inverted.
- Confirm the final OLED address is `0x3c`; update the `ssd1306@3c` node if a
  module uses a different address.
