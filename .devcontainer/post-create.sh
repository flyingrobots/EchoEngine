#!/usr/bin/env bash
set -euo pipefail

echo "[devcontainer] Installing default toolchain (1.71.1 via rust-toolchain.toml) and MSRV (1.68.0)..."
if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 --retry 10 --retry-connrefused --location --silent --show-error --fail https://sh.rustup.rs | sh -s -- --default-toolchain none -y
  export PATH="$HOME/.cargo/bin:$PATH"
fi

rustup toolchain install 1.71.1 --profile minimal
rustup toolchain install 1.68.0 --profile minimal
# Do not override default; let rust-toolchain.toml control selection for this repo.
# Ensure components/targets are available for the default toolchain (1.71.1).
rustup component add --toolchain 1.71.1 rustfmt clippy || true
rustup target add --toolchain 1.71.1 wasm32-unknown-unknown || true

echo "[devcontainer] Priming cargo registry cache (optional)..."
cargo fetch || true

echo "[devcontainer] Done. Run 'cargo test -p rmg-core' or 'make ci-local' to validate."
