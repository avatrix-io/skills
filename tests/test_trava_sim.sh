#!/bin/bash
# Teste da trava do sim da novelinha: bash tests/test_trava_sim.sh (sai 1 se algum caso falhar)
# Confere que o "sim" no idioma do aluno (sim / sí / yes) libera UMA geração e que o resto não libera.
cd "$(dirname "$0")/.." || exit 1
H="$PWD/skills/novelinha/scripts/trava-sim.sh"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
falhas=0

diz() {  # manda a mensagem do aluno pro hook (UserPromptSubmit)
  printf '{"hook_event_name": "UserPromptSubmit", "prompt": "%s"}' "$1" | CLAUDE_PROJECT_DIR="$T" bash "$H"
}
gera() {  # tenta 1 geração paga (PreToolUse); devolve o código de saída do hook
  printf '{"hook_event_name": "PreToolUse", "tool_name": "mcp__avatrix__generate_video"}' | CLAUDE_PROJECT_DIR="$T" bash "$H" 2>/dev/null
  echo $?
}
caso() {  # caso <nome> <mensagem> <esperado: 0 libera | 2 trava>
  rm -f "$T/.claude/sim-do-aluno"
  diz "$2"
  veio=$(gera)
  if [ "$veio" = "$3" ]; then echo "ok   $1"; else echo "FALHOU $1: mensagem [$2], esperado $3, veio $veio"; falhas=$((falhas+1)); fi
}

caso "pt: sim"                       "sim"                         0
caso "pt: sim, pode gerar"           "Sim, pode gerar o clipe 1"   0
caso "pt: gostei não libera"         "gostei"                      2
caso "pt: não, espera"               "não, espera"                 2
caso "es: sí"                        "sí"                          0
caso "es: Sí, dale"                  "Sí, dale"                    0
caso "es: si sozinho"                "si"                          0
caso "es: si, adelante"              "si, adelante"                0
caso "es: si quieres não libera"     "si quieres cambia el final"  2
caso "es: me gusta não libera"       "me gusta"                    2
caso "es: no, espera"                "no, espera"                  2
caso "es: así não libera"            "así está bien"               2
caso "en: yes"                       "yes"                         0
caso "en: Yes please"                "Yes please, go"              0
caso "en: go ahead"                  "go ahead"                    0
caso "en: nice não libera"           "nice"                        2
caso "en: no, wait"                  "no, wait"                    2
caso "en: eyes não libera"           "her eyes look wrong"         2

# um sim libera UMA geração só
rm -f "$T/.claude/sim-do-aluno"; diz "yes" >/dev/null
a=$(gera); b=$(gera)
if [ "$a$b" = "02" ]; then echo "ok   um yes = uma geração"; else echo "FALHOU um yes = uma geração: veio $a e $b"; falhas=$((falhas+1)); fi

[ $falhas -eq 0 ] && echo "teste ok: trava do sim em pt, es e en" || { echo "$falhas falha(s)"; exit 1; }
