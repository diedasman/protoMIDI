# protoMIDI

## Sponsor

**THIS PROJECT IS SPONSORED BY [PCBWAY](https://www.pcbway.com/)**

protoMIDI is a compact DIY HID macropad with the control language of a small
MIDI controller. The current v1.1 design uses a custom PCB in a two-piece
enclosure with eight illuminated push buttons, two rotary encoders, a toggle,
a small utility push button, and an nRF52840 Pro Micro style controller.

> **Asset version:** The screenshots, renders, photographs, and GIFs in
> [`assets/`](./assets/) currently show v1.0 hardware. Updated v1.1 assets will
> be added later.

![protoMIDI v1.0 assembly reference](./assets/protomidiassembly.png)

Despite the controller-style hardware, protoMIDI currently targets ZMK keyboard
firmware. It presents as a keyboard/HID macropad, not as a USB MIDI or BLE MIDI
controller. DAW, transport, clip, track, or effects labels are keymap choices,
not a dedicated MIDI protocol layer.

## Status

v1.1 is the active design. Both manufacturing handoffs remain available:

| Version | Status | DFM pack |
| --- | --- | --- |
| v1.1 | Current | [hardware/protoMIDI-DFM-PACK-v1.1](./hardware/protoMIDI-DFM-PACK-v1.1/README.md) |
| v1.0 | Historical release | [hardware/protoMIDI-DFM-PACK-v1.0](./hardware/protoMIDI-DFM-PACK-v1.0/README.md) |

The Rev A prototype remains in [prototype](./prototype/README.md) as historical
reference for the earlier display-equipped build.

## v1.1 Update

v1.1 retains the v1.0 control layout and updates the manufacturing files:

- PCB silkscreen refinements and newly exported v1.1 Gerbers
- Increased enclosure wall thickness
- Increased USB-C connector clearance
- Increased switch clearance
- A slight angle added to the bottom enclosure
- A supported v1.1 ZMK firmware build with ZMK Studio over USB

The design scope remains:

- Custom PCB as the main electronics artifact
- 8x PB86-B1 illuminated momentary switches
- 2x EC11/PEC11R style rotary encoders with knobs
- 1x MTS-style toggle switch
- 1x 6 mm utility push button
- 1x nRF52840 Pro Micro style controller
- 1x single-cell LiPo battery connection
- Two-piece enclosure: top and bottom
- M2.5 mounting hardware with threaded inserts, matched to the CAD references

The local KiCad source folder, `hardware/protoMIDI-KiCAD/`, and local CAD
reference folder, `hardware/CAD/`, are intentionally ignored. The tracked
manufacturing handoffs are the versioned DFM packs.

## Images

All project-owned images below are v1.0 references.

| Bare PCB | PCB assembly |
| --- | --- |
| ![protoMIDI v1.0 bare PCB](./assets/PCB-bare.png) | ![protoMIDI v1.0 PCB assembly](./assets/protoMIDIPCBAssy.png) |

| Front assembly | Back assembly |
| --- | --- |
| ![protoMIDI v1.0 assembly](./assets/protomidiassembly.png) | ![protoMIDI v1.0 back assembly](./assets/assemblyback.png) |

| Front exploded view | Back exploded view |
| --- | --- |
| ![protoMIDI v1.0 front exploded view](./assets/exploded-front.png) | ![protoMIDI v1.0 back exploded view](./assets/exploded-back.png) |

Prototype media lives in [prototype](./prototype/README.md):

![protoMIDI prototype demo](./prototype/protoMIDI.gif)

![protoMIDI prototype assembly](./prototype/assembly-proto-bare-sm.png)

## Hardware

Start with [hardware/README.md](./hardware/README.md) for version differences,
tracked exports, ignored source folders, and DFM pack links. Component source
notes live in [resources](./resources/README.md).

## Firmware

The supported v1.1 firmware lives in [firmware](./firmware/README.md). It targets
the `nice_nano_v2` compatible nRF52840 board and `protomidi` shield, includes
both encoders and all eight PB86 switches, and supports live keymap editing in
ZMK Studio over USB. The repository intentionally ships only this Studio build.

Build it from the repository root:

```sh
./firmware/build-local.sh
```

The ignored output is:

```text
firmware/build-out/protomidi-v1.1-studio-usb.uf2
```

The Rev A display-equipped firmware remains available in
[prototype/firmware](./prototype/firmware/README.md).

## Repository Layout

```text
assets/       Project-owned v1.0 visual references (v1.1 update pending)
firmware/     Supported v1.1 USB Studio ZMK build
hardware/     Versioned v1.0 and v1.1 DFM handoffs and hardware notes
prototype/    Rev A prototype firmware, CAD export, preview image, and demo GIF
resources/    Source references and component notes
```

Local-only ignored working areas:

```text
hardware/protoMIDI-KiCAD/     Active KiCad design source and BOM CSV
hardware/CAD/                 Local CAD assemblies and reference exports
firmware/builds/standard/     Optional local-only non-Studio configuration
firmware/build-out/           Firmware build output
prototype/firmware/build-out/ Prototype firmware build output
```
