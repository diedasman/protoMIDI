# protoMIDI v1.0 Firmware

These are the two ZMK configurations for the v1.0 custom PCB. Both target the
nRF52840 Pro Micro-compatible `nice_nano_v2` board and the `protomidi` shield.
The v1.0 hardware has no display.

| Build | Purpose |
| --- | --- |
| `standard` | The original fixed keymap and behavior |
| `studio-usb` | The same behavior with live keymap editing in ZMK Studio over USB |

VIA is a QMK configurator and its protocol is not supported by ZMK. The
`studio-usb` build uses ZMK Studio, ZMK's equivalent runtime keymap editor.

## Build and flash

From the repository root, run:

```sh
./firmware/build-local.sh
```

The script uses the official ZMK Docker build image and builds both variants by
default:

```text
firmware/build-out/protomidi-standard.uf2
firmware/build-out/protomidi-studio-usb.uf2
```

Build just one variant by passing its name:

```sh
./firmware/build-local.sh standard
./firmware/build-local.sh studio-usb
```

Double-tap reset on the controller to enter its UF2 bootloader, then copy that
file onto the mounted bootloader drive.

## USB keymap editing

Flash `protomidi-studio-usb.uf2`, connect protoMIDI over USB, and open
[ZMK Studio](https://zmk.studio/) in Chrome/Edge or its native app. This build
starts Studio unlocked because configuration access already requires a physical
USB connection.

Studio can edit the two encoder push switches and the eight illuminated push
buttons. Encoder rotation remains defined in `protomidi.keymap`, matching ZMK
Studio's current encoder limitation.

The source configurations live in:

```text
firmware/builds/standard/config/
firmware/builds/studio-usb/config/
```

## PCB pinout

The switch matrix is `col2row`.

| Signal | nRF52840 GPIO |
| --- | --- |
| ROW0, ROW1, ROW2 | P1.01, P1.02, P1.07 |
| COL0, COL1, COL2, COL3 | P0.02, P1.11, P0.29, P0.31 |
| ENC1 A, B | P1.15, P1.13 |
| ENC2 A, B | P0.10, P0.09 |
| LED1–LED8 | P0.17, P0.20, P0.22, P0.24, P1.00, P0.11, P1.04, P1.06 |

The LEDs run in four vertical pairs: LED1+LED5, LED2+LED6, LED3+LED7, and
LED4+LED8. Each pair is on for 250 ms, giving a one-second chase, followed by
one second with all LEDs off before the chase restarts.
