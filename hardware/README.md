# protoMIDI Hardware

This directory documents the v1.0 hardware handoff. v1.0 replaces the Rev A
display-equipped prototype with a custom PCB, a denser control surface, and a
two-piece enclosure.

The tracked public handoff is
[protoMIDI-DFM-PACK](./protoMIDI-DFM-PACK/README.md).

| Path | Purpose |
| --- | --- |
| [protoMIDI-DFM-PACK/PROTOMIDI-PCB-GERBERS.zip](./protoMIDI-DFM-PACK/PROTOMIDI-PCB-GERBERS.zip) | PCB Gerbers, PTH/NPTH drill files, and KiCad job file packaged for fabrication upload |
| [protoMIDI-DFM-PACK/ENCLOSURE-STEP-STL](./protoMIDI-DFM-PACK/ENCLOSURE-STEP-STL/) | Enclosure top and bottom STEP/STL exports |
| [protoMIDI-DFM-PACK/README.md](./protoMIDI-DFM-PACK/README.md) | Handoff notes and v1.0 BOM |

## v1.0 Scope

- Custom PCB with nRF52840 Pro Micro style controller footprint
- 8x PB86-B1 illuminated push buttons
- 2x EC11/PEC11R style rotary encoders
- 2x encoder knobs, referenced in the local enclosure assembly CAD
- 1x MTS-style toggle switch
- 1x 6 mm utility push button
- 1x LiPo battery connector
- Two-piece enclosure: top and bottom
- M2.5 mounting hardware with threaded inserts, referenced by the local CAD

The OLED display is prototype-only and is not part of v1.0.

## BOM

Mechanical items are added from the enclosure/CAD design. The DFM copy of this
table lives in [protoMIDI-DFM-PACK](./protoMIDI-DFM-PACK/README.md).

Note: `R1-R8` are the illuminated switch LED current-limit resistors. `R9` is
the power/status LED current-limit resistor for `D11`.

| Qty | References | Value / Part | Description |
| ---: | --- | --- | --- |
| 1 | BT1 | Battery_Cell | Single-cell LiPo battery, KiCad footprint `Battery_LiPo_802540_800mAh` |
| 10 | D1-D10 | 1N4148 | Signal diodes for switch matrix |
| 1 | D11 | LED | 5 mm power/status indicator LED |
| 2 | E1,E2 | PEC11R-4215F-S0024 | EC11/PEC11R style vertical rotary encoders, 15 mm shaft |
| 1 | J1 | JST PH 1x02 | 2-pin vertical battery connector, 2.00 mm pitch |
| 8 | R1-R8 | 330 ohm | Through-hole resistors for illuminated switch LEDs |
| 1 | R9 | 680 ohm to 1 kOhm | Through-hole resistor for power/status LED `D11` |
| 8 | SW1-SW8 | PB86-B1 | Illuminated momentary push buttons |
| 1 | SW9 | SW_DPDT_x2 / MTS style | Vertical toggle switch |
| 1 | SW10 | SW_Push | 6 x 6 mm utility push button |
| 1 | U1 | nRF ProMicro | nRF52840 Pro Micro style controller module |
| 2 | ENC knobs | ROTARY_ENCODER_KNOB | Encoder knobs; see local `hardware/CAD/protoMIDI Enclosure Assembly.step` for fit/details |
| 1 | Enclosure top | protoMIDI ENCLOSURE TOP | Tracked STEP/STL export in `protoMIDI-DFM-PACK/ENCLOSURE-STEP-STL` |
| 1 | Enclosure bottom | protoMIDI ENCLOSURE BOTTOM | Tracked STEP/STL export in `protoMIDI-DFM-PACK/ENCLOSURE-STEP-STL` |
| 4 | Mounting screws | EDDT-M2.5-L6 | M2.5 L6 screw reference; local CAD file `hardware/CAD/EDDT-M2.5-L6.step` |
| 4 | Threaded inserts | EMLZ-M2.5-L3 | M2.5 L3 threaded insert reference; local CAD file `hardware/CAD/EMLZ-M2.5-L3.step` |

## Media

![protoMIDI PCB assembly](../assets/protoMIDIPCBAssy.png)

![protoMIDI bare PCB](../assets/PCB-bare.png)

![protoMIDI front exploded enclosure view](../assets/exploded-front.png)

![protoMIDI back exploded enclosure view](../assets/exploded-back.png)

## Prototype Reference

The Rev A prototype remains available for comparison:

- [Prototype overview](../prototype/README.md)
- [Prototype firmware](../prototype/firmware/README.md)
- [Prototype STEP assembly](../prototype/CAD/protoMIDI%20ASSEMBLY.step)

![Prototype assembly preview](../prototype/assembly-proto-bare-sm.png)

![Prototype demo GIF](../prototype/protoMIDI.gif)

## Component References

Useful component notes remain in [resources](../resources/README.md). Some notes
are historical prototype references; the display page is not part of v1.0.
