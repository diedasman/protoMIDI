# Board-Specific Overlays

## Table of Contents

- [Likely Candidates](#likely-candidates)
- [Current Approach](#current-approach)

Keep this directory for board-specific shield overlays once the exact nRF52840
Pro Micro clone behavior is validated.

## Likely Candidates

- `nice_nano_v2.overlay`
- `nrfmicro_nrf52840.overlay`
- `supermini_nrf52840.overlay`

## Current Approach

The initial shield overlay uses direct nRF GPIO controller references so the
pinout remains easy to compare with the physical board silkscreen.
