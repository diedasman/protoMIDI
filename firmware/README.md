# protoMIDI v1.1 Firmware

This directory contains the supported protoMIDI v1.1 ZMK firmware. It targets
the nRF52840 Pro Micro-compatible `nice_nano_v2` board and the `protomidi`
shield. The custom PCB has no display.

The supported build includes live keymap editing through ZMK Studio over USB.
VIA is a QMK configurator and is not used by this ZMK project.

Only the `studio-usb` configuration is included in the repository. The original
non-Studio configuration is intentionally local-only and excluded by
`.gitignore`, so the public firmware has one supported version.

## Build and Flash

From the repository root, run:

```sh
./firmware/build-local.sh
```

The script builds only the supported Studio configuration and writes one
ignored UF2 file:

```text
firmware/build-out/protomidi-v1.1-studio-usb.uf2
```

The script uses the official ZMK Docker build image. The first build downloads
the ZMK and Zephyr dependencies into the ignored `firmware/.zmk/` workspace;
later builds reuse that workspace.

Double-tap reset on the controller to enter its UF2 bootloader, then copy the
UF2 file onto the mounted bootloader drive.

## USB Keymap Editing

Flash `protomidi-v1.1-studio-usb.uf2`, connect protoMIDI over USB, and open
[ZMK Studio](https://zmk.studio/) in Chrome/Edge or its native app. This build
starts Studio unlocked because configuration access already requires a physical
USB connection.

Studio can edit the two encoder push switches and the eight illuminated push
buttons. Encoder rotation remains defined in `protomidi.keymap`, matching ZMK
Studio's current encoder limitation.

The tracked source configuration lives in:

```text
firmware/builds/studio-usb/config/
```

## PCB Pinout

The switch matrix is `col2row`.

| Signal | nRF52840 GPIO |
| --- | --- |
| ROW0, ROW1, ROW2 | P1.01, P1.02, P1.07 |
| COL0, COL1, COL2, COL3 | P0.02, P1.11, P0.29, P0.31 |
| ENC1 A, B | P1.15, P1.13 |
| ENC2 A, B | P0.10, P0.09 |
| LED1-LED8 | P0.17, P0.20, P0.22, P0.24, P1.00, P0.11, P1.04, P1.06 |

The LEDs run in four vertical pairs: LED1+LED5, LED2+LED6, LED3+LED7, and
LED4+LED8. Each pair is on for 250 ms, giving a one-second chase, followed by
one second with all LEDs off before the chase restarts.
