# Board-Specific Overlays

Keep this directory for board-specific shield overlays once the exact nRF52840
Pro Micro clone behavior is validated.

Likely candidates:

- `nice_nano_v2.overlay`
- `nrfmicro_nrf52840.overlay`
- `supermini_nrf52840.overlay`

The initial shield overlay uses direct nRF GPIO controller references so the
pinout remains easy to compare with the physical board silkscreen.

