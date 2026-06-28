# protoMIDI DFM Pack

This folder is the tracked v1.0 manufacturing handoff for protoMIDI. It contains
the files needed to review, quote, fabricate, and mechanically inspect the
custom PCB and enclosure.

## Files

| Path | Contents |
| --- | --- |
| [PROTOMIDI-PCB-GERBERS.zip](./PROTOMIDI-PCB-GERBERS.zip) | KiCad Gerbers, PTH/NPTH drills, and job file packaged for fabrication upload |
| [ENCLOSURE-STEP-STL](./ENCLOSURE-STEP-STL/) | Enclosure top and bottom as STEP and STL |

Enclosure exports:

- [protoMIDI ENCLOSURE TOP.step](./ENCLOSURE-STEP-STL/protoMIDI%20ENCLOSURE%20TOP.step)
- [protoMIDI ENCLOSURE TOP.stl](./ENCLOSURE-STEP-STL/protoMIDI%20ENCLOSURE%20TOP.stl)
- [protoMIDI ENCLOSURE BOTTOM.step](./ENCLOSURE-STEP-STL/protoMIDI%20ENCLOSURE%20BOTTOM.step)
- [protoMIDI ENCLOSURE BOTTOM.stl](./ENCLOSURE-STEP-STL/protoMIDI%20ENCLOSURE%20BOTTOM.stl)

The KiCad source project and local CAD reference files remain ignored in
`hardware/protoMIDI-KiCAD/` and `hardware/CAD/`.

## BOM

The electronic BOM is based on the local KiCad CSV at
`hardware/protoMIDI-KiCAD/protoMIDI-KiCAD.csv`, which is intentionally ignored.
Mechanical items are added from the enclosure/CAD design.

Note: the schematic currently uses placeholder value `R` for `R1-R9`. Finalize
those resistor values before fabrication or assembly.

| Qty | References | Value / Part | Description |
| ---: | --- | --- | --- |
| 1 | BT1 | Battery_Cell | Single-cell LiPo battery, KiCad footprint `Battery_LiPo_802540_800mAh` |
| 10 | D1-D10 | 1N4148 | Signal diodes for switch matrix |
| 1 | D11 | LED | 5 mm power/status indicator LED |
| 2 | E1,E2 | PEC11R-4215F-S0024 | EC11/PEC11R style vertical rotary encoders, 15 mm shaft |
| 1 | J1 | JST PH 1x02 | 2-pin vertical battery connector, 2.00 mm pitch |
| 9 | R1-R9 | R | Through-hole resistors; values pending |
| 8 | SW1-SW8 | PB86-B1 | Illuminated momentary push buttons |
| 1 | SW9 | SW_DPDT_x2 / MTS style | Vertical toggle switch |
| 1 | SW10 | SW_Push | 6 x 6 mm utility push button |
| 1 | U1 | nRF ProMicro | nRF52840 Pro Micro style controller module |
| 2 | ENC knobs | ROTARY_ENCODER_KNOB | Encoder knobs; see local `hardware/CAD/protoMIDI Enclosure Assembly.step` for fit/details |
| 1 | Enclosure top | protoMIDI ENCLOSURE TOP | Tracked STEP/STL export in `ENCLOSURE-STEP-STL` |
| 1 | Enclosure bottom | protoMIDI ENCLOSURE BOTTOM | Tracked STEP/STL export in `ENCLOSURE-STEP-STL` |
| 4 | Mounting screws | EDDT-M2.5-L6 | M2.5 L6 screw reference; local CAD file `hardware/CAD/EDDT-M2.5-L6.step` |
| 4 | Threaded inserts | EMLZ-M2.5-L3 | M2.5 L3 threaded insert reference; local CAD file `hardware/CAD/EMLZ-M2.5-L3.step` |

## Visual References

Use the project-owned renders when reviewing the assembly:

![protoMIDI v1.0 assembly](../../assets/protomidiassembly.png)

![protoMIDI PCB assembly](../../assets/protoMIDIPCBAssy.png)

![protoMIDI bare PCB](../../assets/PCB-bare.png)

![protoMIDI back assembly](../../assets/assemblyback.png)

![protoMIDI front exploded view](../../assets/exploded-front.png)

![protoMIDI back exploded view](../../assets/exploded-back.png)
