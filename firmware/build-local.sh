#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE_DIR="${ROOT_DIR}/firmware/.zmk/workspace"
OUTPUT_DIR="${ROOT_DIR}/firmware/build-out"
BOARD="nice_nano_v2"
SHIELD="protomidi"
DEFAULT_BUILD="all"

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
Usage: ./firmware/build-local.sh [all|standard|studio-usb]

The default is "${DEFAULT_BUILD}", which builds both firmware variants.

Outputs:
  firmware/build-out/protomidi-standard.uf2
  firmware/build-out/protomidi-studio-usb.uf2
EOF
  exit 0
fi

if (( $# > 1 )); then
  echo "Expected at most one build name. See --help." >&2
  exit 2
fi

BUILD_SELECTION="${1:-${DEFAULT_BUILD}}"
case "${BUILD_SELECTION}" in
  all | standard | studio-usb) ;;
  *)
    echo "Unknown build '${BUILD_SELECTION}'. See --help." >&2
    exit 2
    ;;
esac

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
  -e BUILD_SELECTION="${BUILD_SELECTION}" \
  -v "${ROOT_DIR}:/work" \
  -w /work/firmware/.zmk/workspace \
  zmkfirmware/zmk-build-arm:stable \
  sh -lc '
    case "${BUILD_SELECTION}" in
      all) variants="standard studio-usb" ;;
      *) variants="${BUILD_SELECTION}" ;;
    esac

    # Initialize/update west from either manifest; both pin the same ZMK version.
    rm -rf config
    cp -R /work/firmware/builds/standard/config ./config

    if [ ! -d .west ]; then
      west init -l config
    fi

    west update --fetch-opt=--filter=tree:0
    west zephyr-export

    mkdir -p /work/firmware/build-out

    for variant in ${variants}; do
      rm -rf config
      cp -R "/work/firmware/builds/${variant}/config" ./config

      if [ "${variant}" = "studio-usb" ]; then
        west build -p always -s zmk/app -d "build/${SHIELD}-${variant}" \
          -b "${BOARD}" -S studio-rpc-usb-uart -- \
          -DZMK_CONFIG=/work/firmware/.zmk/workspace/config \
          -DSHIELD="${SHIELD}"
      else
        west build -p always -s zmk/app -d "build/${SHIELD}-${variant}" \
          -b "${BOARD}" -- \
          -DZMK_CONFIG=/work/firmware/.zmk/workspace/config \
          -DSHIELD="${SHIELD}"
      fi

      cp "build/${SHIELD}-${variant}/zephyr/zmk.uf2" \
        "/work/firmware/build-out/${SHIELD}-${variant}.uf2"
    done
  '

if [[ "${BUILD_SELECTION}" == "all" ]]; then
  echo "Wrote firmware/build-out/protomidi-standard.uf2"
  echo "Wrote firmware/build-out/protomidi-studio-usb.uf2"
else
  echo "Wrote firmware/build-out/protomidi-${BUILD_SELECTION}.uf2"
fi
