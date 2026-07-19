# protoMIDI v1.1 DFM Pack

This folder is the current manufacturing handoff for protoMIDI. It contains the
v1.1 PCB fabrication files and revised two-piece enclosure exports. The
[v1.0 DFM pack](../protoMIDI-DFM-PACK-v1.0/README.md) remains available as the
original release.

## v1.1 Changes

- Refined PCB silkscreen and exported a new Gerber set
- Increased enclosure wall thickness
- Increased USB-C connector clearance
- Increased switch clearance
- Added a slight angle to the bottom enclosure

The supported firmware paired with this release is the
[v1.1 ZMK Studio USB build](../../firmware/README.md).

## Files

| Path | Contents |
| --- | --- |
| [PCB-GERBERS](./PCB-GERBERS/) | v1.1 PCB copper, mask, paste, silkscreen, edge cuts, PTH drill, and NPTH drill files |
| [ENCLOSURE](./ENCLOSURE/) | Revised enclosure top and bottom as STEP and STL |

Enclosure exports:

- [protoMIDI ENCLOSURE TOP v1.1.step](./ENCLOSURE/protoMIDI%20ENCLOSURE%20TOP%20v1.1.step)
- [protoMIDI ENCLOSURE TOP v1.1.stl](./ENCLOSURE/protoMIDI%20ENCLOSURE%20TOP%20v1.1.stl)
- [protoMIDI ENCLOSURE BOTTOM v1.1.step](./ENCLOSURE/protoMIDI%20ENCLOSURE%20BOTTOM%20v1.1.step)
- [protoMIDI ENCLOSURE BOTTOM v1.1.stl](./ENCLOSURE/protoMIDI%20ENCLOSURE%20BOTTOM%20v1.1.stl)

The KiCad source project and local CAD reference files remain ignored in
`hardware/protoMIDI-KiCAD/` and `hardware/CAD/`.

## BOM

The electronic BOM is unchanged from v1.0; v1.1 changes the PCB silkscreen and
enclosure geometry.

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
| 2 | ENC knobs | ROTARY_ENCODER_KNOB | Encoder knobs; see local v1.1 CAD assembly for fit/details |
| 1 | Enclosure top | protoMIDI ENCLOSURE TOP v1.1 | Revised STEP/STL export in `ENCLOSURE/` |
| 1 | Enclosure bottom | protoMIDI ENCLOSURE BOTTOM v1.1 | Revised STEP/STL export in `ENCLOSURE/` |
| 4 | Mounting screws | EDDT-M2.5-L6 | M2.5 L6 screw reference |
| 4 | Threaded inserts | EMLZ-M2.5-L3 | M2.5 L3 threaded insert reference |

## Visual References

> **Asset version:** The repository images currently show v1.0. They are useful
> as general assembly references but do not show the v1.1 silkscreen or
> enclosure geometry. Updated screenshots will be added later.

![protoMIDI v1.0 assembly reference](../../assets/protomidiassembly.png)

![protoMIDI v1.0 PCB assembly reference](../../assets/protoMIDIPCBAssy.png)

![protoMIDI v1.0 exploded enclosure reference](../../assets/exploded-front.png)
