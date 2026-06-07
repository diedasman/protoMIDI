# ZMK Config

## Table of Contents

- [Current Assumptions](#current-assumptions)
- [Files To Update When Pins Change](#files-to-update-when-pins-change)

`boards/shields/protomidi` contains the protoMIDI shield definition.

## Current Assumptions

- The controller is compatible enough with ZMK's `nice_nano_v2` board target
  for the first build.
- Pin labels in the hardware plan are nRF GPIO labels: `002` means `P0.02`,
  `115` means `P1.15`, and so on.
- Matrix diode direction is `col2row`.
- OLED display support is enabled through Zephyr's SSD1306-compatible driver for
  the 128x64 SSD1309 module.
- PB86 LED/backlight and per-button LED state control are not planned because
  the PB86 LEDs are hardwired to 3V3.
- Any future peripheral power control will be through the hardware switch that
  cuts 3V3 to the OLED and PB86 LEDs.

## Files To Update When Pins Change

When the physical pinout changes, update:

- `boards/shields/protomidi/protomidi.overlay`
- `hardware/README.md`
- `firmware/README.md`
- the board argument passed to `./firmware/build-local.sh`, if the board target
  changes
