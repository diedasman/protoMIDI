# ZMK Config

## Table of Contents

- [Configuration](#configuration)
- [Files](#files)

`boards/shields/protomidi` contains the protoMIDI shield definition.

## Configuration

- The controller uses ZMK's `nice_nano_v2` board target.
- Pin labels in the hardware docs are nRF GPIO labels: `002` means `P0.02`,
  `115` means `P1.15`, and so on.
- Matrix diode direction is `col2row`.
- OLED display support is enabled through Zephyr's SSD1306-compatible driver for
  the 128x64 SSD1309 module.
- PB86 LED/backlight and per-button LED state control are not configured because
  the PB86 LEDs are hardwired to 3V3.

## Files

- `boards/shields/protomidi/protomidi.overlay`
- `boards/shields/protomidi/protomidi.keymap`
- `boards/shields/protomidi/protomidi.conf`
- `boards/shields/protomidi/custom_status_screen.c`
- `west.yml`
