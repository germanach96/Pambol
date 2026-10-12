#!/bin/bash
# Instala el plugin Impeccable en sesiones en la nube (cada sesión empieza en un contenedor nuevo).
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if grep -q '"impeccable@impeccable"' "$HOME/.claude/plugins/installed_plugins.json" 2>/dev/null; then
  exit 0
fi

claude plugin marketplace add pbakaus/impeccable >/dev/null 2>&1 || true
claude plugin install impeccable@impeccable >/dev/null
echo "Impeccable instalado. Si impeccable:impeccable no aparece en la lista de skills, reinicia la sesión."
