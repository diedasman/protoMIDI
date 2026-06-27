# protoMIDI DFM Pack

This folder is the intended handoff package for the protoMIDI v1.0 custom PCB.
It should contain the exported files needed to review, quote, fabricate, and
assemble the board.

The KiCad project source lives in the local `../protoMIDI-KiCAD/` workspace and
is not intended to be part of the git repository. Commit exported DFM files here
instead.

## Expected Files

- Gerber files
- Drill files
- Board outline or mechanical exports
- Pick-and-place or placement files, if assembly is used
- BOM exports or BOM notes
- Fabrication or assembly notes

Do not use this folder for KiCad project source, KiCad backups, generated caches,
vendor archives, or copied third-party assets.

## BOM

Generated from `../protoMIDI-KiCAD/protoMIDI-KiCAD.kicad_sch` with KiCad CLI:

```sh
kicad-cli sch export bom ../protoMIDI-KiCAD/protoMIDI-KiCAD.kicad_sch \
  --fields Reference,Value,Footprint,Description,QUANTITY,DNP \
  --labels References,Value,Footprint,Description,Qty,DNP \
  --group-by Value,Footprint,Description \
  --sort-field Reference \
  --exclude-dnp
```

Note: the schematic currently uses the placeholder value `R` for `R1-R9`.
Finalize those resistor values before fabrication or assembly.

| Qty   | References  | Value         | Description                           |
| ---:  | ---         | ---           |                                   --- |
| 1     | BT1         | LiPo-Battery  | Single-cell 800mAh 3.7V LiPo battery  |
| 10    | D1-D10      | 1N4148        | _ |
| 1     | D11         | LED           | Power indidcator LED                                            |
| 2     | E1,E2       | EC11R         | Rotary encoder button switch. 15mm shaft                        |
| 1     | J1          | _             | Generic JST-PH connector, single row, 01x02 2mm pitch           |
| 9     | R1-R9       | R             | Resistor                                                        |
| 8     | SW1-SW8     | PB_86_B1      | PB86-B1 Momentary Switch, single pole double throw with RED LED |
| 1     | SW9         | SW_DPDT/SPDT  | MTS Toggle Switch, dual pole double throw                       |
| 1     | SW10        | SW_Push       | Push button switch, generic 6x6mm, four pins                    |
| 1     | U1          | nRF ProMicro  | nRF52840 Pro Micro                                              |
