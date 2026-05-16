# ZMK Config

`boards/shields/protomidi` contains the protoMIDI shield definition.

Current assumptions:

- The controller is compatible enough with ZMK's `nice_nano_v2` board target
  for the first build.
- Pin labels in the hardware plan are nRF GPIO labels: `006` means `P0.06`,
  `100` means `P1.00`, and so on.
- Matrix diode direction is `col2row`.
- OLED and LED backlight are intentionally left out of the first firmware pass.

When the physical pinout changes, update:

- `boards/shields/protomidi/protomidi.overlay`
- `hardware/pinout.md`
- the board argument passed to `./firmware/build-local.sh`, if the board target
  changes
