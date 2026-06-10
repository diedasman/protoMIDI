# protoMIDI Firmware

This directory is a nested ZMK user config inside the larger protoMIDI hardware
repo. The preferred build path is local, so builders can compile firmware from
the open-source files in this repository entirely on their own machine.

## Table of Contents

- [Hardware Support](#hardware-support)
- [Pinout](#pinout)
- [Quick Build](#quick-build)
- [Dependencies](#dependencies)
- [Manual Build Sketch](#manual-build-sketch)

The firmware target is the Rev A bare controller:

- Board: `nice_nano_v2`
- Shield: `protomidi`
- Inputs: 2x3 key matrix with five populated positions
- Encoder: one EC11-compatible quadrature encoder
- Display: 2.42 inch 128x64 SSD1309 OLED over I2C using Zephyr's SSD1306-compatible driver

## Hardware Support

This build is the protoMIDI firmware baseline: switches, encoder, OLED display,
USB HID, and Bluetooth HID. Pin assignments match the Rev A pinout documented
below and in `hardware/README.md`.

Supported:

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

The PB86 LEDs are hardwired to 3V3. Firmware does not provide LED/backlight or
per-button LED state control.

The OLED pin choice is intentional for this build: the shield overrides the
`nice_nano_v2` I2C defaults and places the SSD1309 module on `P1.06`/`P1.04`.

## Pinout

This is the firmware pinout for the Rev A bare controller.

ZMK target:

- Board target: `nice_nano_v2`
- Shield: `protomidi`
- Firmware path: `firmware/config/boards/shields/protomidi`

Matrix diode direction: `col2row`

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

Encoder:

| Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- |
| Encoder A | `024` | `&gpio0 24` |
| Encoder B | `022` | `&gpio0 22` |
| Encoder common | GND | GND |

OLED display:

| Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- |
| OLED SDA | `106` | `NRF_PSEL(TWIM_SDA, 1, 6)` |
| OLED SCL | `104` | `NRF_PSEL(TWIM_SCL, 1, 4)` |

The shield overlay overrides the `nice_nano_v2` I2C defaults and uses
`P1.06`/`P1.04` for the OLED.

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

The build script also accepts explicit board and shield arguments:

```sh
./firmware/build-local.sh nice_nano_v2 protomidi
```

The script keeps the ZMK checkout in `firmware/.zmk/workspace`, which is ignored
by git. The first run downloads the ZMK and Zephyr dependencies, so it can take a
while. Later runs reuse that workspace.

## Dependencies

Default path:

- Docker
- Internet access for dependency downloads

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

The build command above matches the tracked `nice_nano_v2` and `protomidi`
configuration.
