# protoMIDI Firmware

This directory is a nested ZMK user config inside the larger protoMIDI hardware
repo. The preferred build path is local, so builders can compile firmware from
the open-source files in this repository entirely on their own machine.

The first firmware target is the Rev A full-feature starting point:

- Board: `nice_nano_v2`
- Shield: `protomidi`
- Inputs: 2x3 key matrix with five populated positions
- Encoder: one EC11-compatible quadrature encoder
- Display: 2.42 inch 128x64 SSD1309 OLED over I2C using Zephyr's SSD1306-compatible driver

## Current Hardware Support

This build is the first full protoMIDI firmware baseline: switches, encoder,
OLED display, USB HID, and Bluetooth HID. Pin assignments match the final Rev A
pinout in `hardware/pinout.md`.

Supported now:

- `nice_nano_v2` compatible nRF52840 board target
- 2x3 GPIO switch matrix
- Four PB86 momentary buttons
- Encoder push switch as the fifth matrix key
- One unused matrix position at row 1, column 2
- `col2row` matrix diode direction
- EC11-style rotary encoder on separate A/B GPIOs
- 128x64 SSD1309 OLED on I2C
- Custom animated monochrome protoMIDI OLED graphic
- USB HID keyboard
- Bluetooth HID keyboard through the selected ZMK board target
- UF2 firmware output for drag-and-drop flashing

Default key behavior:

| Control | Binding |
| --- | --- |
| PB86-1 | Play/pause |
| PB86-2 | none |
| PB86-3 | Previous track |
| PB86-4 | Next track |
| Encoder push | Mute |
| Encoder clockwise | Volume up |
| Encoder counter-clockwise | Volume down |

Not supported yet:

- PB86 LED/backlight control
- Per-button LED state
- Confirmed battery sensing for the exact nRF52840 clone board
- GPIO VCC cutoff or external power switching
- Final hardware pinout validation

The OLED pin choice is intentional for this build: the shield overrides the
`nice_nano_v2` I2C defaults and places the SSD1309 module on `P1.06`/`P1.04`.

## Quick Build

Install Docker, then run this from the repository root:

```sh
./firmware/build-local.sh
```

The default output path is:

```text
firmware/build-out/protomidi-nice_nano_v2.uf2
```

Double-tap reset on the nRF52840 board to enter the UF2 bootloader, then copy
that `.uf2` file to the mounted bootloader drive.

You can also pass a different ZMK board and shield:

```sh
./firmware/build-local.sh nice_nano_v2 protomidi
```

The script keeps the ZMK checkout in `firmware/.zmk/workspace`, which is ignored
by git. The first run downloads the ZMK and Zephyr dependencies, so it can take a
while. Later runs reuse that workspace.

## Dependencies

Default path:

- Docker
- Internet access on the first build, and when updating ZMK dependencies

The script uses the official `zmkfirmware/zmk-build-arm:stable` container image,
so builders do not need to install Zephyr SDK, `west`, or Python packages on the
host system.

## Manual Build Sketch

If you already maintain your own ZMK/Zephyr toolchain, build with:

```sh
west build -s zmk/app -b nice_nano_v2 -- \
  -DSHIELD=protomidi \
  -DZMK_CONFIG=/absolute/path/to/protoMIDI/firmware/config
```

The selected board may change after hardware validation. If it does, update the
build command and any board-specific overlay notes.
