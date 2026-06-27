# protoMIDI Prototype

This folder contains the Rev A protoMIDI prototype files. The prototype is the
earlier display-equipped build used to prove the physical controls, ZMK firmware,
CAD assembly, and HID behavior before the v1.0 custom PCB update.

The prototype is kept as a reference implementation. It is not the final v1.0
hardware direction.

## Contents

| Path | Purpose |
| --- | --- |
| `firmware/` | ZMK user config and local build script for the Rev A prototype |
| `CAD/protoMIDI ASSEMBLY.step` | Exported STEP assembly for the bare prototype build |
| `assembly-proto-bare-sm.png` | Assembly preview image |
| `protoMIDI.gif` | Prototype demo media used by the main README |

## Prototype Hardware

The Rev A prototype uses:

- nRF52840 Pro Micro style development board compatible with `nice_nano_v2`
- Four PB86-B1 illuminated momentary switches
- One EC11-style rotary encoder with push switch
- 2.42 inch 128x64 SSD1309 I2C OLED display
- 3.7 V LiPo battery
- ZMK firmware configured as a HID keyboard/macropad

The PB86 LEDs are hardwired to 3V3 in the prototype. Firmware does not dim them,
turn them off individually, or represent per-button LED state.

## Using The Firmware

Build from the repository root:

```sh
./prototype/firmware/build-local.sh
```

The default firmware output is:

```text
prototype/firmware/build-out/protomidi-nice_nano_v2.uf2
```

Double-tap reset on the nRF52840 board to enter the UF2 bootloader, then copy the
generated `.uf2` file to the mounted bootloader drive.

See [prototype/firmware/README.md](./firmware/README.md) for firmware details,
dependencies, pinout notes, and manual build commands.

## Using The CAD And Media

Use `CAD/protoMIDI ASSEMBLY.step` as a mechanical reference for the old prototype
enclosure-free assembly. The image and GIF are project-owned media for showing
the prototype layout and behavior in documentation.

When updating docs from the repository root, link to these files with paths like:

```md
![protoMIDI prototype demo](./prototype/protoMIDI.gif)
![Prototype assembly](./prototype/assembly-proto-bare-sm.png)
```

## Relationship To v1.0

v1.0 moves the project toward a custom PCB with no display, more switches, and
more rotary encoders. Use this prototype folder for historical reference,
behavior checks, and migration comparisons while the v1.0 DFM files are prepared.
