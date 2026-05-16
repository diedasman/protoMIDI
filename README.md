# protoMIDI

protoMIDI is a compact DIY macropad with the physical language of a small MIDI
controller: four large illuminated push buttons, one rotary encoder with push
action, and a small monochrome OLED status display.

Despite the controller-style hardware, the firmware target is ZMK keyboard
firmware. The device presents as a keyboard/HID macropad, not as a MIDI device.
DAW, transport, clip, track, or effects labels are default keymap choices and
enclosure styling, not a dedicated MIDI protocol layer.

## Current Status

This repository is in Rev A bring-up. The physical component set has been chosen,
but the final pinout may still change during hardware validation.

Current firmware support:

- `nice_nano_v2` compatible nRF52840 board target
- `protomidi` ZMK shield
- 3x2 GPIO switch matrix
- Four PB86 momentary buttons
- Encoder push switch as the fifth matrix key
- EC11-style rotary encoder
- USB HID keyboard
- Bluetooth HID keyboard through the selected ZMK board target
- Local UF2 firmware build

Deferred until the input path is proven:

- OLED display
- PB86 LED/backlight control
- Battery sensing validation
- GPIO VCC cutoff / external power switching
- Final pinout freeze
- Case and PCB refinement

## Hardware

Selected Rev A parts:

- nRF52840 Pro Micro style development board
- Four PB86-B1 momentary switches with single-color LEDs
- One EC11 vertical rotary encoder with push switch
- One 2.42 inch 128x64 SSD1309 I2C OLED display
- One 3.7 V 1200 mAh protected LiPo battery with JST-PH connector
- FR4 protoboard or simple custom PCB
- 3D printed case with panel-mount styling

Useful docs:

- [Implementation plan](./PLAN.md)
- [Working pinout](./hardware/pinout.md)
- [Component resources](./resources)

## Firmware

Firmware lives under [firmware](./firmware) as a nested ZMK user config inside
this larger hardware repository.

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
| PB86-1 | `F13` |
| PB86-2 | `F14` |
| PB86-3 | `F15` |
| PB86-4 | `F16` |
| Encoder push | `F17` |
| Encoder clockwise | Volume up |
| Encoder counter-clockwise | Volume down |

See [firmware/README.md](./firmware/README.md) for build dependencies and
firmware details.

## Repository Layout

```text
firmware/   ZMK config, local build script, and generated UF2 output
hardware/   Pinout and Rev A hardware notes
resources/  Source references, images, datasheets, and component notes
PLAN.md     Full implementation plan and open questions
```

## Design Intent

protoMIDI should be reproducible from off-the-shelf parts and simple fabrication.
Equivalent parts are welcome when they preserve the same electrical interfaces:
momentary SPST switches, single-color LEDs, quadrature encoder, 3.3 V I2C OLED,
and a Pro Micro compatible nRF52840 board supported by ZMK.

