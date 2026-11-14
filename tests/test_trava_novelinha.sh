#!/bin/bash
# Teste da trava do sim da novelinha: 7 casos, com e sem a pasta .claude no projeto (14 no total).
# bash tests/test_trava_novelinha.sh (sai 1 se algum caso falhar)
cd "$(dirname "$0")/.." || exit 1
TRAVA="$PWD/skills/novelinha/scripts/trava-sim.sh"
falhas=0
fala() { printf '{"hook_event_name":"UserPromptSubmit","prompt":"%s"}' "$1" | CLAUDE_PROJECT_DIR="$P" bash "$TRAVA" >/dev/null 2>&1; }
gera() { printf '{"hook_event_name":"PreToolUse","tool_name":"mcp__avatrix__%s"}' "$1" | CLAUDE_PROJECT_DIR="$P" bash "$TRAVA" >/dev/null 2>&1; echo $?; }
caso() { local nome="$1" esperado="$2" veio="$3"
  if [ "$veio" = "$esperado" ]; then echo "ok   [$modo] $nome"; else echo "FALHOU [$modo] $nome: esperado $esperado, veio $veio"; falhas=$((falhas+1)); fi; }
novo() { rm -rf "$P"; mkdir -p "$P"; [ "$modo" = "com .claude" ] && mkdir -p "$P/.claude"; }
P=$(mktemp -d); trap 'rm -rf "$P"' EXIT
for modo in "com .claude" "sem .claude"; do
  novo; caso "imagem sem sim bloqueia" 2 "$(gera generate_image)"
  novo; fala "sim"; caso "sim libera uma imagem" 0 "$(gera generate_image)"
  caso "o mesmo sim não libera a segunda" 2 "$(gera generate_video)"
  novo; fala "não, sim só depois"; caso "mensagem que começa com não não libera" 2 "$(gera generate_image)"
  novo; fala "pode gerar"; caso "pode gerar libera um vídeo" 0 "$(gera generate_video)"
  novo; fala "gostei"; caso "gostei não libera" 2 "$(gera generate_image)"
  novo; caso "ferramenta que não gasta passa" 0 "$(gera list_tasks)"
done
[ $falhas -eq 0 ] && echo "teste ok: trava da novelinha (14 casos)" || { echo "$falhas falha(s)"; exit 1; }
