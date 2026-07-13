# protoMIDI

protoMIDI is a compact DIY HID macropad with the control language of a small
MIDI controller. The current v1.0 design is a custom PCB in a two-piece
enclosure with eight illuminated push buttons, two rotary encoders, a toggle,
a small utility push button, and an nRF52840 Pro Micro style controller.

![protoMIDI v1.0 assembly](./assets/protomidiassembly.png)

Despite the controller-style hardware, protoMIDI currently targets ZMK keyboard
firmware. It presents as a keyboard/HID macropad, not as a USB MIDI or BLE MIDI
controller. DAW, transport, clip, track, or effects labels are keymap choices,
not a dedicated MIDI protocol layer.

## Status

v1.0 is the active design. The repository now includes the public manufacturing
handoff in [hardware/protoMIDI-DFM-PACK](./hardware/protoMIDI-DFM-PACK/README.md):

- PCB Gerbers and drill files packaged as
  [PROTOMIDI-PCB-GERBERS.zip](./hardware/protoMIDI-DFM-PACK/PROTOMIDI-PCB-GERBERS.zip)
- Enclosure STEP and STL exports in
  [ENCLOSURE-STEP-STL](./hardware/protoMIDI-DFM-PACK/ENCLOSURE-STEP-STL/)
- A concise v1.0 BOM in the DFM pack README

The Rev A prototype remains in [prototype](./prototype/README.md) as historical
reference for the earlier display-equipped build.

## v1.0 Design

The v1.0 scope is:

- Custom PCB as the main electronics artifact
- 8x PB86-B1 illuminated momentary switches
- 2x EC11/PEC11R style rotary encoders with knobs
- 1x MTS-style toggle switch
- 1x 6 mm utility push button
- 1x nRF52840 Pro Micro style controller
- 1x single-cell LiPo battery connection
- Two-piece enclosure: top and bottom
- M2.5 mounting hardware with threaded inserts, matched to the CAD references

The local KiCad source folder,
`hardware/protoMIDI-KiCAD/`, is intentionally ignored. The local CAD reference
folder, `hardware/CAD/`, is also ignored. Those folders can be used while working
on the project, but the tracked handoff is the DFM pack.

## Images

The project-owned v1.0 images live in [assets](./assets/).

| Bare PCB  | PCB assembly |
| ---       | --- |
| ![protoMIDI bare PCB](./assets/PCB-bare.png) | ![protoMIDI PCB assembly](./assets/protoMIDIPCBAssy.png) |

| Front Assembly  | Back assembly |
| ---       | --- |
| ![protoMIDI v1.0 assembly](./assets/protomidiassembly.png) | ![protoMIDI back assembly](./assets/assemblyback.png) |

| Front exploded view | Back exploded view |
| --- | --- |
| ![protoMIDI front exploded view](./assets/exploded-front.png) | ![protoMIDI back exploded view](./assets/exploded-back.png) |

Prototype media lives in [prototype](./prototype/README.md):

![protoMIDI prototype demo](./prototype/protoMIDI.gif)

![protoMIDI prototype assembly](./prototype/assembly-proto-bare-sm.png)

## Hardware

Start with [hardware/README.md](./hardware/README.md) for the hardware boundary,
tracked exports, ignored source folders, and links into the DFM pack. Component
source notes live in [resources](./resources/README.md).

## Firmware

The v1.0 custom PCB firmware lives in [firmware](./firmware/README.md). It
targets a `nice_nano_v2` compatible nRF52840 board with the `protomidi` ZMK
shield, includes the two encoders and all eight PB86 switches, and has no
display support.

Build it from the repository root:

```sh
./firmware/build-local.sh
```

The ignored output is written to:

```text
firmware/build-out/protomidi-nice_nano_v2.uf2
```

The Rev A display-equipped firmware remains available in
[prototype/firmware](./prototype/firmware/README.md).

## Repository Layout

```text
assets/       Project-owned v1.0 renders and assembly images
hardware/     v1.0 hardware notes and tracked DFM handoff files
prototype/    Rev A prototype firmware, CAD export, preview image, and demo GIF
resources/    Source references and component notes
```

Local-only ignored working areas:

```text
hardware/protoMIDI-KiCAD/   Active KiCad design source and BOM CSV
hardware/CAD/               Local CAD assembly and hardware reference exports
prototype/firmware/build-out/ Firmware build output
```
