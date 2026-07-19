# protoMIDI Prototype

This folder contains the Rev A protoMIDI prototype. It is the earlier
display-equipped build used to prove the physical controls, ZMK firmware, CAD
assembly, and HID behavior before the v1.0 custom PCB release.

The prototype is historical reference. The active design is v1.1 in
[../hardware](../hardware/README.md).

![protoMIDI prototype demo](./protoMIDI.gif)

## Contents

| Path | Purpose |
| --- | --- |
| [firmware](./firmware/README.md) | ZMK user config and local build script for the Rev A prototype |
| [CAD/protoMIDI ASSEMBLY.step](./CAD/protoMIDI%20ASSEMBLY.step) | Exported STEP assembly for the bare prototype build |
| [assembly-proto-bare-sm.png](./assembly-proto-bare-sm.png) | Prototype assembly preview image |
| [protoMIDI.gif](./protoMIDI.gif) | Prototype demo media used by older docs |

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

![protoMIDI prototype assembly](./assembly-proto-bare-sm.png)

## Firmware

Build from the repository root:

```sh
./prototype/firmware/build-local.sh
```

The default firmware output is ignored and written to:

```text
prototype/firmware/build-out/protomidi-nice_nano_v2.uf2
```

Double-tap reset on the nRF52840 board to enter the UF2 bootloader, then copy the
generated `.uf2` file to the mounted bootloader drive.

See [prototype/firmware/README.md](./firmware/README.md) for firmware details,
dependencies, pinout notes, and manual build commands.

## Relationship To v1.1

The v1.0 release removed the display, moved to a custom PCB, increased the
switch count to eight, increased the encoder count to two, and added tracked
enclosure DFM exports. v1.1 refines that PCB silkscreen and enclosure and adds
the supported ZMK Studio firmware build. Use this folder for old behavior checks
and migration comparisons.
