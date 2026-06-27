# protoMIDI Hardware

This directory is the repository-level hardware area for the v1.0 update. The
project is moving from the Rev A display-equipped prototype to a custom PCB with
more switches, more encoders, and no OLED display.

## Table of Contents

- [Status](#status)
- [Repository Boundary](#repository-boundary)
- [v1.0 Hardware Direction](#v10-hardware-direction)
- [DFM Handoff](#dfm-handoff)
- [Prototype Reference](#prototype-reference)
- [Component References](#component-references)

## Status

The active v1.0 PCB work is currently in a local KiCad workspace. The hardware
docs are being scaffolded ahead of the final exported manufacturing package.

The previous Rev A hardware notes, firmware config, CAD assembly, preview image,
and demo GIF now live in [prototype](../prototype/README.md).

## Repository Boundary

`hardware/protoMIDI-KiCAD/` is the local KiCad design-source folder for the v1.0
PCB. It is not intended to be included in the git repository.

Only exported DFM handoff files should be committed for the v1.0 hardware once
they are ready. Put them in
[protoMIDI-DFM-PACK](./protoMIDI-DFM-PACK/README.md). This keeps the public
repository focused on the files needed to review, quote, fabricate, and assemble
the board.

## v1.0 Hardware Direction

The planned v1.0 board changes the project shape:

- Custom PCB replaces the bare prototype wiring approach
- OLED display is removed
- Switch count increases from the Rev A prototype
- Rotary encoder count increases from the Rev A prototype
- nRF52840 Pro Micro style controller remains the current baseline
- ZMK HID behavior remains the current firmware direction
- LED outputs are expected to be active-high where wired as GPIO -> LED ->
  resistor -> GND

The v1.0 firmware and docs should be updated after the PCB pinout is finalized.

## DFM Handoff

The tracked hardware files in
[protoMIDI-DFM-PACK](./protoMIDI-DFM-PACK/README.md) should be manufacturing
outputs such as:

- Gerber files
- Drill files
- Board outline/mechanical exports
- Pick-and-place or placement files, if assembly is used
- BOM or fabrication notes
- Any review screenshots or PDFs that are safe and useful to publish

Avoid committing KiCad backups, local project state, generated caches, vendor
archives, or copied third-party assets.

## Prototype Reference

The Rev A prototype remains available as a working reference:

- [Prototype overview](../prototype/README.md)
- [Prototype firmware](../prototype/firmware/README.md)
- [Prototype STEP assembly](../prototype/CAD/protoMIDI%20ASSEMBLY.step)
- [Prototype assembly preview](../prototype/assembly-proto-bare-sm.png)

## Component References

Useful component notes remain in [resources](../resources/README.md). Some of
those references describe prototype parts, including the OLED display, and may
not all carry forward to v1.0.
