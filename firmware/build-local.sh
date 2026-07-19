#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE_DIR="${ROOT_DIR}/firmware/.zmk/workspace"
OUTPUT_DIR="${ROOT_DIR}/firmware/build-out"
BOARD="nice_nano_v2"
SHIELD="protomidi"
BUILD_NAME="studio-usb"
OUTPUT_NAME="protomidi-v1.1-studio-usb.uf2"

format_duration() {
  local total_seconds="$1"
  local hours=$((total_seconds / 3600))
  local minutes=$(((total_seconds % 3600) / 60))
  local seconds=$((total_seconds % 60))

  if ((hours > 0)); then
    printf "%dh %02dm %02ds" "${hours}" "${minutes}" "${seconds}"
  elif ((minutes > 0)); then
    printf "%dm %02ds" "${minutes}" "${seconds}"
  else
    printf "%ds" "${seconds}"
  fi
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<EOF
Usage: ./firmware/build-local.sh

Builds the supported protoMIDI v1.1 firmware with ZMK Studio over USB.

Output:
  firmware/build-out/${OUTPUT_NAME}
EOF
  exit 0
fi

if (( $# > 0 )); then
  echo "This script does not accept a build selection. See --help." >&2
  exit 2
fi

START_SECONDS="$(date +%s)"

print_elapsed() {
  local exit_code="$?"
  local end_seconds elapsed status
  end_seconds="$(date +%s)"
  elapsed=$((end_seconds - START_SECONDS))

  if ((exit_code == 0)); then
    status="completed"
  else
    status="failed"
  fi

  echo "Build ${status} in $(format_duration "${elapsed}")"
}

trap print_elapsed EXIT

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required for the default local build path." >&2
  echo "Install Docker, then run: ./firmware/build-local.sh" >&2
  exit 1
fi

mkdir -p "${WORKSPACE_DIR}" "${OUTPUT_DIR}"

docker run --rm \
  --user "$(id -u):$(id -g)" \
  -e BOARD="${BOARD}" \
  -e SHIELD="${SHIELD}" \
  -e BUILD_NAME="${BUILD_NAME}" \
  -e OUTPUT_NAME="${OUTPUT_NAME}" \
  -v "${ROOT_DIR}:/work" \
  -w /work/firmware/.zmk/workspace \
  zmkfirmware/zmk-build-arm:stable \
  sh -lc '
    rm -rf config
    cp -R "/work/firmware/builds/${BUILD_NAME}/config" ./config

    if [ ! -d .west ]; then
      west init -l config
    fi

    west update --fetch-opt=--filter=tree:0
    west zephyr-export

    mkdir -p /work/firmware/build-out

    west build -p always -s zmk/app -d "build/${SHIELD}-${BUILD_NAME}" \
      -b "${BOARD}" -S studio-rpc-usb-uart -- \
      -DZMK_CONFIG=/work/firmware/.zmk/workspace/config \
      -DSHIELD="${SHIELD}"

    cp "build/${SHIELD}-${BUILD_NAME}/zephyr/zmk.uf2" \
      "/work/firmware/build-out/${OUTPUT_NAME}"
  '

echo "Wrote firmware/build-out/${OUTPUT_NAME}"
