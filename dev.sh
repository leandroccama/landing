#!/usr/bin/env sh
set -e

# calcula hash del lockfile (si existe)
LOCK_HASH_FILE="node_modules/.install-hash"
CALC_LOCK_HASH="$(sha256sum package-lock.json 2>/dev/null | awk '{print $1}')"

NEEDS_INSTALL="false"
if [ ! -d node_modules ]; then
  NEEDS_INSTALL="true"
elif [ -f package-lock.json ] && [ "$CALC_LOCK_HASH" != "$(cat "$LOCK_HASH_FILE" 2>/dev/null || echo 'x')" ]; then
  NEEDS_INSTALL="true"
fi

if [ "$NEEDS_INSTALL" = "true" ]; then
  echo "→ Instalar dependencias…"
  if [ -f package-lock.json ]; then
    npm ci --prefer-offline --no-audit --no-fund
  else
    npm install --prefer-offline --no-audit --no-fund
  fi
  # guarda hash para evitar reinstalar en próximos arranques
  [ -n "$CALC_LOCK_HASH" ] && echo "$CALC_LOCK_HASH" > "$LOCK_HASH_FILE" || true
else
  echo "→ Dependencias OK (sin cambios)."
fi

# corre astro dev
exec npm run dev -- --host 0.0.0.0
