#!/usr/bin/env bash
# Teste de fila.sh (RN01). Roda com: bash fila.test.sh
# Sai com código 0 se todos os cenários passarem; != 0 e mensagem em caso de falha.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILA="$HERE/fila.sh"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

fail() {
  echo "FALHOU: $1" >&2
  echo "--- saída obtida ---" >&2
  echo "$2" >&2
  exit 1
}

# Fixture: specs/ com tamanhos distintos, empate de tamanho, pasta sem
# spec.md, e concluidos/ + template/ que devem ser ignoradas.
mkdir -p "$TMP/specs"/{spec-grande,b-empate,a-empate,spec-pequena,sem-spec,concluidos/feita,template}
printf 'l\n%.0s' {1..50} >"$TMP/specs/spec-grande/spec.md"
printf 'l\n%.0s' {1..20} >"$TMP/specs/b-empate/spec.md"
printf 'l\n%.0s' {1..20} >"$TMP/specs/a-empate/spec.md"
printf 'l\n%.0s' {1..5}  >"$TMP/specs/spec-pequena/spec.md"
printf 'l\n%.0s' {1..3}  >"$TMP/specs/concluidos/feita/spec.md"
printf 'l\n%.0s' {1..3}  >"$TMP/specs/template/spec.md"
touch "$TMP/specs/sem-spec/plan.md"

out="$(bash "$FILA" "$TMP/specs")"

esperado="$(printf '5\tspec-pequena\n20\ta-empate\n20\tb-empate\n50\tspec-grande')"
[[ "$out" == "$esperado" ]] || fail "ordenação por linhas + desempate alfabético + exclusões" "$out"

# Fila vazia: diretório só com concluidos/template/pasta sem spec.md
mkdir -p "$TMP/vazia"/{concluidos,template,sem-spec}
out_vazia="$(bash "$FILA" "$TMP/vazia")"
[[ -z "$out_vazia" ]] || fail "fila vazia deveria não imprimir nada" "$out_vazia"

# Diretório inexistente: erro com exit != 0
if bash "$FILA" "$TMP/nao-existe" 2>/dev/null; then
  fail "diretório inexistente deveria falhar" "(exit 0)"
fi

echo "OK: todos os cenários de fila.test.sh passaram"
