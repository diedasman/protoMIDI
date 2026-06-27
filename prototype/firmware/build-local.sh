#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE_DIR="${ROOT_DIR}/firmware/.zmk/workspace"
OUTPUT_DIR="${ROOT_DIR}/firmware/build-out"
DEFAULT_BOARD="nice_nano_v2"
DEFAULT_SHIELD="protomidi"

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
Usage: ./prototype/firmware/build-local.sh [board] [shield]

Defaults:
  board:  ${DEFAULT_BOARD}
  shield: ${DEFAULT_SHIELD}

Output:
  prototype/firmware/build-out/<shield>-<board>.uf2
EOF
  exit 0
fi

BOARD="${1:-${DEFAULT_BOARD}}"
SHIELD="${2:-${DEFAULT_SHIELD}}"
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
  echo "Install Docker, then run: ./prototype/firmware/build-local.sh" >&2
  exit 1
fi

mkdir -p "${WORKSPACE_DIR}" "${OUTPUT_DIR}"

docker run --rm \
  --user "$(id -u):$(id -g)" \
  -e BOARD="${BOARD}" \
  -e SHIELD="${SHIELD}" \
  -v "${ROOT_DIR}:/work" \
  -w /work/firmware/.zmk/workspace \
  zmkfirmware/zmk-build-arm:stable \
  sh -lc '
    rm -rf config
    cp -R /work/firmware/config ./config

    if [ ! -d .west ]; then
      west init -l config
    fi

    west update --fetch-opt=--filter=tree:0
    west zephyr-export
    west build -s zmk/app -d "build/${SHIELD}" -b "${BOARD}" -- \
      -DZMK_CONFIG=/work/firmware/.zmk/workspace/config \
      -DSHIELD="${SHIELD}"

    mkdir -p /work/firmware/build-out
    cp "build/${SHIELD}/zephyr/zmk.uf2" \
      "/work/firmware/build-out/${SHIELD}-${BOARD}.uf2"
  '

echo "Wrote prototype/firmware/build-out/${SHIELD}-${BOARD}.uf2"
