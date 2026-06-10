# protoMIDI Hardware

This directory contains the Rev A hardware baseline for protoMIDI: the KiCad
project, exported STEP assembly, wiring reference, and physical configuration
notes.
The hardware is built around a Pro Micro style nRF52840 controller running ZMK as
a `nice_nano_v2` compatible board with a custom `protomidi` shield.

## Table of Contents

- [Configuration](#configuration)
- [BOM](#bom)
- [Assembly Preview](#assembly-preview)
- [Files](#files)
- [Matrix](#matrix)
- [Encoder](#encoder)
- [OLED Display](#oled-display)
- [Power](#power)

## Configuration

Rev A is a bare controller assembly with four illuminated PB86 momentary
buttons, one EC11 rotary encoder with push action, a 2.42 inch 128x64
monochrome OLED, an nRF52840 Pro Micro style controller board, and a LiPo
battery. The controls are wired as a 2x3 diode matrix plus a separate
quadrature encoder pair. Firmware treats the device as a HID macropad, not as a
MIDI controller.

Electrical configuration:

- Controller: nRF52840 Pro Micro style board compatible with `nice_nano_v2`
- Shield path: `firmware/config/boards/shields/protomidi`
- Matrix: 2 rows x 3 columns, five populated positions
- Matrix diode direction: `col2row`
- Encoder: EC11-style A/B quadrature pins plus push switch in the matrix
- Display: SSD1309 128x64 OLED on I2C using Zephyr's SSD1306-compatible driver
- Power: USB-C from the controller board or 3.7 V LiPo through the board battery
  connector
- LEDs: PB86 single-color LEDs are hardwired to 3V3 and are not individually
  firmware-controllable

## BOM

| Qty | Item | Resource | Notes |
| --- | --- | --- | --- |
| 1 | nRF52840 Pro Micro style dev board | [resources/promicro](../resources/promicro/README.md) | `nice_nano_v2` compatible ZMK target with UF2 bootloader |
| 4 | PB86-B1 illuminated momentary switch | [resources/switches](../resources/switches/README.md) | Matrix keys; integrated LEDs are hardwired to 3V3 |
| 1 | EC11 vertical rotary encoder, 15 mm shaft | [resources/encoder](../resources/encoder/README.md) | Quadrature volume control with push switch as the fifth matrix key |
| 1 | 2.42 inch SSD1309 128x64 I2C OLED | [resources/display](../resources/display/README.md) | Runs on 3.3 V I2C at address `0x3c` |
| 1 | 3.7 V 1200 mAh protected LiPo battery | [resources/battery](../resources/battery/README.md) | JST-PH connector |
| As needed | M2.5 8 mm ABS spacers | [resources/mounting](../resources/mounting/README.md) | Project-modeled bare assembly spacing hardware |
| 1 | Custom protoMIDI PCB | [KiCad project](./protoMIDI-KiCAD) | Rev A PCB files are tracked in this directory |
| 1 | Bare mechanical assembly | [STEP assembly](./CAD/protoMIDI%20ASSEMBLY.step) | Exported CAD reference for the assembled controller |

## Assembly Preview

![Bare protoMIDI assembly preview](../resources/assembly-proto-bare-sm.png)

## Files

| Path | Purpose |
| --- | --- |
| `protoMIDI-KiCAD/` | KiCad schematic and PCB files |
| `CAD/protoMIDI ASSEMBLY.step` | Exported bare mechanical assembly |
| `README.md` | Hardware configuration, BOM, and pinout reference |

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

The full Rev A build enables the 2.42 inch 128x64 SSD1309 OLED using Zephyr's
SSD1306-compatible I2C display driver.

| Function | GPIO label | ZMK devicetree pin |
| --- | --- | --- |
| OLED SDA | `106` | `NRF_PSEL(TWIM_SDA, 1, 6)` |
| OLED SCL | `104` | `NRF_PSEL(TWIM_SCL, 1, 4)` |

The shield overlay overrides the `nice_nano_v2` I2C defaults and uses
`P1.06`/`P1.04` for the OLED.

## Power

The controller can be powered over USB-C for build and test work. The selected
nRF52840 Pro Micro style board also exposes a 3.7 V lithium battery connector
for the 1200 mAh LiPo.

The PB86 LEDs are tied directly to 3V3, so firmware cannot dim them, turn them
off individually, or represent per-button state.
