#!/usr/bin/env bash
# Fila de specs pendentes (RN01 de agente-execucao-sequencial-specs-pendentes).
#
# Uso: fila.sh [caminho-para-.ai/specs]
#
# Saída: uma linha por spec pendente, "<n-linhas><TAB><nome-da-pasta>",
# ordenada por número de linhas do spec.md (crescente) e, no empate, por
# ordem alfabética do nome da pasta. Pastas sem spec.md, "concluidos" e
# "template" ficam de fora.
set -euo pipefail

SPECS_DIR="${1:-.ai/specs}"

if [[ ! -d "$SPECS_DIR" ]]; then
  echo "erro: diretório não encontrado: $SPECS_DIR" >&2
  exit 1
fi

for dir in "$SPECS_DIR"/*/; do
  name="$(basename "$dir")"
  [[ "$name" == "concluidos" || "$name" == "template" ]] && continue
  [[ -f "$dir/spec.md" ]] || continue
  lines="$(wc -l <"$dir/spec.md")"
  printf '%d\t%s\n' "$lines" "$name"
done | sort -t $'\t' -k1,1n -k2,2
