# ZMK Config

`boards/shields/protomidi` contains the protoMIDI shield definition.

Current assumptions:

- The controller is compatible enough with ZMK's `nice_nano_v2` board target
  for the first build.
- Pin labels in the hardware plan are nRF GPIO labels: `002` means `P0.02`,
  `115` means `P1.15`, and so on.
- Matrix diode direction is `col2row`.
- OLED display support is enabled through Zephyr's SSD1306-compatible driver for
  the 128x64 SSD1309 module.
- PB86 LED/backlight control is intentionally left out of this firmware pass.

When the physical pinout changes, update:

- `boards/shields/protomidi/protomidi.overlay`
- `hardware/pinout.md`
- the board argument passed to `./firmware/build-local.sh`, if the board target
  changes
