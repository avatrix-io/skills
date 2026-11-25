#!/bin/bash
# Teste do aviso de versão: bash tests/test_aviso_de_versao.sh (sai 1 se algum caso falhar)
cd "$(dirname "$0")/.." || exit 1
H="$PWD/hooks/aviso-de-versao.sh"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
mkdir -p "$T/raiz/skills/x"; echo 1.2.0 > "$T/raiz/skills/x/VERSION"
falhas=0
roda() { CLAUDE_PLUGIN_ROOT="$T/raiz" CLAUDE_PLUGIN_DATA="$T/dados-$1" AVISO_URL="$2" bash "$H" x; }
confere() { if [ "$2" = "$3" ]; then echo "ok   $1"; else echo "FALHOU $1: esperado [$3], veio [$2]"; falhas=$((falhas+1)); fi; }
pub() { echo "$1" > "$T/publicada"; }

pub 1.2.0; confere "versão igual: calado" "$(roda igual "file://$T/publicada")" ""
pub 1.10.0; out=$(roda nova "file://$T/publicada")
confere "versão nova: 1 linha" "$(printf '%s\n' "$out" | grep -c 'Saiu a x v1.10.0 (você tem a v1.2.0)')" "1"
confere "versão nova: JSON válido" "$(printf '%s' "$out" | python3 -c 'import json,sys;print(bool(json.load(sys.stdin)["systemMessage"]))')" "True"
pub 1.1.9; confere "publicada menor que a instalada: calado" "$(roda menor "file://$T/publicada")" ""
pub '<html>404</html>'; confere "página de erro: calado" "$(roda lixo "file://$T/publicada")" ""

ini=$(date +%s); out=$(roda semrede "http://10.255.255.1/VERSION"); st=$?; dur=$(( $(date +%s) - ini ))
confere "sem rede: calado" "$out" ""; confere "sem rede: sai 0" "$st" "0"
confere "sem rede: até 3 s" "$([ $dur -le 3 ] && echo sim || echo "não ($dur s)")" "sim"

pub 1.3.0; roda cache "file://$T/publicada" >/dev/null; pub 9.9.9
confere "cache: 2ª chamada no mesmo dia não consulta" "$(roda cache "file://$T/publicada" | grep -o 'v1.3.0' | head -1)" "v1.3.0"

confere "endereço que não existe: calado" "$(roda d0 "file://$T/nao-existe")" ""
confere "skill inexistente: calado" "$(CLAUDE_PLUGIN_ROOT="$T/raiz" CLAUDE_PLUGIN_DATA="$T/d1" AVISO_URL="file://$T/publicada" bash "$H" nada)" ""

[ $falhas -eq 0 ] && echo "teste ok: aviso de versão" || { echo "$falhas falha(s)"; exit 1; }
