# protoMIDI

protoMIDI is a compact DIY HID macropad with the physical language of a small
MIDI controller. The current repository is being scaffolded for the v1.0
hardware update: a custom PCB design with no display, more switches, and more
rotary encoders.

![protoMIDI prototype demo](./prototype/protoMIDI.gif)

Despite the controller-style hardware, protoMIDI currently targets ZMK keyboard
firmware. The device presents as a keyboard/HID macropad, not as a USB MIDI or
BLE MIDI controller. DAW, transport, clip, track, or effects labels are keymap
choices, not a dedicated MIDI protocol layer.

## Table of Contents

- [Status](#status)
- [v1.0 Direction](#v10-direction)
- [Prototype](#prototype)
- [Hardware](#hardware)
- [Firmware](#firmware)
- [Repository Layout](#repository-layout)
- [Design Intent](#design-intent)

## Status

This repo is in transition from the Rev A prototype to the v1.0 custom PCB
layout. The prototype files have been moved into [prototype](./prototype/README.md)
so they remain available as a working reference while v1.0 is scaffolded.

The repository tracks the design-for-manufacturing handoff files:
Gerbers, drill files, placement data, BOM exports, or other DFM outputs needed
to fabricate the board.

## v1.0

v1.0 changes protoMIDI from the display-equipped Rev A prototype into a custom
PCB-based controller. The planned hardware direction is:

- Custom PCB as the main hardware artifact
- No OLED display
- More switch positions than the prototype
- More rotary encoders than the prototype
- nRF52840 Pro Micro style controller retained as the current firmware target
- ZMK HID firmware as the baseline behavior
- DFM outputs tracked in git instead of the local KiCad project folder

The current v1.0 source design mostly lives in the local `protoMIDI-KiCAD`
working directory. Treat that folder as design-source workspace, not repository
content.

## Prototype

The Rev A prototype is documented in [prototype/README.md](./prototype/README.md).
That folder contains the previous firmware config, CAD assembly export, assembly
preview, and demo media.

Use the prototype folder when you need to:

- Build or inspect the old display-equipped ZMK firmware
- Compare the v1.0 PCB design against the working prototype
- Review the original five-control layout
- Reuse the prototype media in documentation

## Hardware

Hardware documentation is being reshaped around the v1.0 PCB handoff. See
[hardware/README.md](./hardware/README.md) for the current repository-level
hardware notes.

Useful component references remain in [resources](./resources/README.md).

## Firmware

The tracked firmware currently belongs to the Rev A prototype and lives in
[prototype/firmware](./prototype/firmware/README.md). It targets a
`nice_nano_v2` compatible nRF52840 board with the `protomidi` ZMK shield.

Build the prototype firmware from the repository root:

```sh
./prototype/firmware/build-local.sh
```

The default output is:

```text
prototype/firmware/build-out/protomidi-nice_nano_v2.uf2
```

The v1.0 firmware will need to be updated after the custom PCB pinout and control
count are finalized.

## Repository Layout

```text
hardware/    Repository-level hardware notes and DFM handoff files
prototype/   Rev A prototype firmware, CAD export, preview image, and demo GIF
resources/   Source references and component notes
```

Local-only working area:

```text
hardware/protoMIDI-KiCAD/   Active KiCad design source; not intended for git
```

## Design Intent

protoMIDI should be reproducible from documented parts and fabrication outputs.
For v1.0, the public repository should make the manufacturing handoff clear while
keeping bulky or local KiCad working files out of git.

The prototype remains useful as a proof of behavior, but v1.0 is the main path:
a cleaner custom PCB design with a denser control surface and no display.
