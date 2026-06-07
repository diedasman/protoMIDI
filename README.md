# protoMIDI

protoMIDI is a compact DIY macropad with the physical language of a small MIDI
controller: four large illuminated push buttons, one rotary encoder with push
action, and a small monochrome OLED status display.

## Table of Contents

- [Current Status](#current-status)
- [Hardware](#hardware)
- [Firmware](#firmware)
- [Flashing](#flashing)
- [Known Limitations](#known-limitations)
- [Repository Layout](#repository-layout)
- [Design Intent](#design-intent)

Despite the controller-style hardware, the firmware target is ZMK keyboard
firmware. The device presents as a keyboard/HID macropad, not as a MIDI device.
DAW, transport, clip, track, or effects labels are default keymap choices and
enclosure styling, not a dedicated MIDI protocol layer.

## Current Status

This repository now contains the first full Rev A build baseline. The hardware
design, pinout notes, KiCad project, STEP assembly, and ZMK firmware config are
tracked in the repo. The current firmware is HID-only and targets a
`nice_nano_v2` compatible nRF52840 board with the `protomidi` ZMK shield.

Current firmware support:

- `nice_nano_v2` compatible nRF52840 board target
- `protomidi` ZMK shield
- 2x3 GPIO switch matrix with five populated positions
- Four PB86 momentary buttons
- Encoder push switch as the fifth matrix key
- EC11-style rotary encoder
- 128x64 SSD1309 OLED on I2C using Zephyr's SSD1306-compatible driver
- Custom monochrome protoMIDI OLED status graphic
- USB HID keyboard
- Bluetooth HID keyboard through the selected ZMK board target
- Local UF2 firmware build

Still to validate or implement:

- Battery sensing validation
- Peripheral 3V3 cutoff switch for the OLED and PB86 LEDs during CAD
  finalisation
- Reset-switch access in the enclosure
- Final enclosure refinements

## Hardware

Rev A hardware:

- nRF52840 Pro Micro style development board compatible with the `nice_nano_v2`
  ZMK target
- Four PB86-B1 momentary switches with single-color LEDs
- One EC11 vertical rotary encoder with push switch
- One 2.42 inch 128x64 SSD1309 I2C OLED display
- One 3.7 V 1200 mAh protected LiPo battery with JST-PH connector
- Custom KiCad PCB files and exported STEP assembly
- 3D printed case with panel-mount styling

Useful docs:

- [Hardware configuration](./hardware/README.md)
- [Component resources](./resources)

## Firmware

Firmware lives under [firmware](./firmware) as a nested ZMK user config inside
this larger hardware repository.

The firmware scope is intentionally HID-only:

- USB keyboard/HID output
- Bluetooth keyboard/HID output
- Media-key bindings for playback and volume
- No USB MIDI, BLE MIDI, DAW protocol, sequencer, clock, or control-change layer

Build locally from the repository root:

```sh
./firmware/build-local.sh
```

The default output is:

```text
firmware/build-out/protomidi-nice_nano_v2.uf2
```

Double-tap reset on the nRF52840 board to enter the UF2 bootloader, then copy the
generated `.uf2` file to the mounted bootloader drive.

The default key behavior is:

| Control | Binding |
| --- | --- |
| PB86-1 | Play/pause |
| PB86-2 | none |
| PB86-3 | Previous track |
| PB86-4 | Next track |
| Encoder push | Mute |
| Encoder clockwise | Volume up |
| Encoder counter-clockwise | Volume down |

See [firmware/README.md](./firmware/README.md) for build dependencies and
firmware details.

## Flashing

1. Install Docker.
2. Run `./firmware/build-local.sh` from the repository root.
3. Double-tap reset on the nRF52840 board to enter the UF2 bootloader.
4. Copy `firmware/build-out/protomidi-nice_nano_v2.uf2` to the mounted
   bootloader drive.
5. Let the board reboot, then test the controls over USB HID.
6. Pair the device over Bluetooth through the normal ZMK/nRF52840 host pairing
   flow when wireless testing is needed.

## Known Limitations

- protoMIDI is not a MIDI device. It currently sends keyboard/media HID events.
- PB86 LEDs are hardwired to 3V3. There is no firmware LED/backlight or
  per-button LED state control planned.
- The only planned lighting/display power control is a future board switch that
  cuts 3V3 to the peripherals: the OLED and PB86 LEDs.
- Battery sensing still needs validation on the exact nRF52840 board and LiPo
  combination.
- Reset access and enclosure details are still being refined.

## Repository Layout

```text
firmware/   ZMK config, local build script, and generated UF2 output
hardware/   Pinout, KiCad files, STEP assembly, and Rev A hardware notes
resources/  Source references, images, datasheets, and component notes
ToDo.md     Current project task list
```

## Design Intent

protoMIDI should be reproducible from off-the-shelf parts and simple fabrication.
Equivalent parts are welcome when they preserve the same electrical interfaces:
momentary SPST switches, single-color LEDs, quadrature encoder, 3.3 V I2C OLED,
and a Pro Micro compatible nRF52840 board supported by ZMK.
