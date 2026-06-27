# Board-Specific Overlay Directory

## Table of Contents

- [Purpose](#purpose)
- [Tracked Board Target](#tracked-board-target)

## Purpose

This directory is available for board-specific shield overlays. The tracked Rev
A build uses the base `protomidi.overlay` file in the parent shield directory.

## Tracked Board Target

The firmware build target is `nice_nano_v2`. The base shield overlay uses direct
nRF GPIO controller references so the pinout remains easy to compare with the
physical board silkscreen.
