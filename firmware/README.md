# protoMIDI Firmware

This directory is a nested ZMK user config inside the larger protoMIDI hardware
repo. The preferred build path is local, so builders can compile firmware from
the open-source files in this repository entirely on their own machine.

The first firmware target is a conservative Rev A bring-up:

- Board: `nice_nano_v2`
- Shield: `protomidi`
- Inputs: 3x2 key matrix with five populated positions
- Encoder: one EC11-compatible quadrature encoder
- Deferred: OLED, shared LED backlight, battery sensing, and VCC cutoff

## Quick Build

Install Docker, then run this from the repository root:

```sh
./firmware/build-local.sh
```

The default output path is:

```text
firmware/build-out/protomidi-nice_nano_v2.uf2
```

Double-tap reset on the nRF52840 board to enter the UF2 bootloader, then copy
that `.uf2` file to the mounted bootloader drive.

You can also pass a different ZMK board and shield:

```sh
./firmware/build-local.sh nice_nano_v2 protomidi
```

The script keeps the ZMK checkout in `firmware/.zmk/workspace`, which is ignored
by git. The first run downloads the ZMK and Zephyr dependencies, so it can take a
while. Later runs reuse that workspace.

## Dependencies

Default path:

- Docker
- Internet access on the first build, and when updating ZMK dependencies

The script uses the official `zmkfirmware/zmk-build-arm:stable` container image,
so builders do not need to install Zephyr SDK, `west`, or Python packages on the
host system.

## Manual Build Sketch

If you already maintain your own ZMK/Zephyr toolchain, build with:

```sh
west build -s zmk/app -b nice_nano_v2 -- \
  -DSHIELD=protomidi \
  -DZMK_CONFIG=/absolute/path/to/protoMIDI/firmware/config
```

The selected board may change after hardware validation. If it does, update the
build command and any board-specific overlay notes.
