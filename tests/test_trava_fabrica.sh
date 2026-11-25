#!/bin/bash
# Teste da trava do "sim" da fábrica de reels: bash tests/test_trava_fabrica.sh (sai 1 se algum caso falhar)
# Confere que "sim", "pode gerar" e "pode gastar" no começo da mensagem abrem a janela (2 h, ou até 23:59 com o máximo do dia),
# que o resto não abre (mensagem com "?" também não), que um "sim" depois não encurta a janela do dia,
# que toda ferramenta paga é barrada fora da janela (no script e no matcher do plugin)
# e que cotação e ferramenta que não gasta passam.
cd "$(dirname "$0")/.." || exit 1
H="$PWD/skills/fabrica-de-reels/scripts/trava-sim.sh"
P=$(mktemp -d); trap 'rm -rf "$P"' EXIT
F="$P/.claude/ok-do-aluno"
falhas=0
PAGAS="generate_image generate_video generate_voice generate_influencer generate_batch change_voice download_social send_message confirm_card edit_image enhance_image transfer_motion cut_video"
GRATIS="join_audio list_influencers get_influencer get_credits wait_for_task wait_for_tasks list_tasks update_influencer"

diz() { printf '{"hook_event_name": "UserPromptSubmit", "prompt": "%s"}' "$1" | CLAUDE_PROJECT_DIR="$P" bash "$H" >/dev/null 2>&1; echo $?; }
usa() {  # usa <ferramenta> [tool_input em JSON]: devolve o código de saída do hook (0 passa, 2 barra)
  local ti="${2:-}"; [ -n "$ti" ] || ti='{}'
  printf '{"hook_event_name": "PreToolUse", "tool_name": "%s", "tool_input": %s}' "$1" "$ti" | CLAUDE_PROJECT_DIR="$P" bash "$H" >/dev/null 2>&1; echo $?; }
confere() { if [ "$2" = "$3" ]; then echo "ok   $1"; else echo "FALHOU $1: esperado [$3], veio [$2]"; falhas=$((falhas+1)); fi; }
fecha() { rm -rf "$P/.claude"; }

# 1. Sem "sim", toda ferramenta paga barra, com o nome do terminal e o do conector do app do Claude
fecha
for t in $PAGAS; do
  confere "sem sim barra $t" "$(usa "mcp__avatrix__$t")" 2
  confere "sem sim barra $t (conector do app)" "$(usa "mcp__claude_ai_Avatrix__$t")" 2
done
for t in $GRATIS; do confere "não gasta, passa: $t" "$(usa "mcp__avatrix__$t")" 0; done
confere "cotação (get_cost) passa sem sim" "$(usa mcp__avatrix__generate_video '{"get_cost": true, "model": "avatrix-persona-pro"}')" 0
confere "ferramenta de fora da Avatrix passa" "$(usa Bash)" 0

# 2. O que abre e o que não abre
for m in "sim" "Sim, pode gerar as 3 cenas" "  sim." "pode gerar" "Pode gastar" "SIM!"; do
  fecha; diz "$m" >/dev/null; confere "[$m] abre" "$(usa mcp__avatrix__generate_video)" 0
done
for m in "ok" "segue" "pode ser" "pode não" "gostei" "acho que sim" "não, sim só depois" "simples assim" "simulação primeiro" "quanto custa?" "sim, mas quanto custa?" "pode gerar?"; do
  fecha; diz "$m" >/dev/null; confere "[$m] não abre" "$(usa mcp__avatrix__generate_video)" 2
done
fecha; confere "a mensagem do aluno nunca é barrada" "$(diz "ok")" 0

# 3. A janela: um "sim" vale pra várias chamadas por 2 h; com o máximo do dia, até 23:59
fecha; diz "sim" >/dev/null
confere "o mesmo sim libera a 2ª chamada paga" "$(usa mcp__avatrix__generate_image)" 0
confere "e a 3ª" "$(usa mcp__avatrix__change_voice)" 0
d=$(( $(cat "$F") - $(date +%s) )); confere "janela de 2 h" "$([ $d -ge 7190 ] && [ $d -le 7200 ] && echo sim || echo "não ($d s)")" "sim"
fim_do_dia=$(( $(date -d 'tomorrow 00:00' +%s 2>/dev/null || date -v+1d -v0H -v0M -v0S +%s) - 1 ))
for m in "sim, até 600 por dia" "Sim, até 1.200 créditos por dia"; do
  fecha; diz "$m" >/dev/null; confere "[$m] abre até 23:59" "$(cat "$F")" "$fim_do_dia"
done
fecha; diz "sim, até 600 por dia" >/dev/null; diz "sim" >/dev/null
confere "um sim depois não encurta a janela do dia" "$([ "$(cat "$F")" -ge "$fim_do_dia" ] && echo sim || echo não)" "sim"
fecha; diz "sim, até 600 nesse reel" >/dev/null
d=$(( $(cat "$F") - $(date +%s) )); confere "máximo do reel (sem 'por dia') fica nas 2 h" "$([ $d -le 7200 ] && echo sim || echo não)" "sim"
fecha; mkdir -p "$P/.claude"; echo $(( $(date +%s) - 1 )) > "$F"
confere "janela vencida barra" "$(usa mcp__avatrix__generate_video)" 2
echo lixo > "$F"; confere "arquivo da trava estragado barra" "$(usa mcp__avatrix__generate_video)" 2

# 4. Falha fechada
fecha; diz "sim" >/dev/null
confere "evento desconhecido barra" "$(printf '{"hook_event_name": "Outro", "tool_name": "mcp__avatrix__generate_video"}' | CLAUDE_PROJECT_DIR="$P" bash "$H" >/dev/null 2>&1; echo $?)" 2
confere "ferramenta sem nome barra" "$(printf '{"hook_event_name": "PreToolUse"}' | CLAUDE_PROJECT_DIR="$P" bash "$H" >/dev/null 2>&1; echo $?)" 2
fecha
confere "o recado da trava vai pro Claude" "$(printf '{"hook_event_name": "PreToolUse", "tool_name": "mcp__avatrix__generate_video"}' | CLAUDE_PROJECT_DIR="$P" bash "$H" 2>&1 >/dev/null | grep -c 'TRAVA DO OK')" 1

# 5. O matcher do plugin pega as mesmas ferramentas pagas que o script, e nenhuma que não gasta
confere "matcher do plugin igual ao script" "$(python3 - "$PAGAS" "$GRATIS" <<'EOF'
import json, re, sys
m = json.load(open(".claude-plugin/marketplace.json"))
p = next(x for x in m["plugins"] if x["name"] == "fabrica-de-reels")
rx = re.compile(p["hooks"]["PreToolUse"][0]["matcher"])
erros = [t for t in sys.argv[1].split() for n in ("mcp__avatrix__" + t, "mcp__claude_ai_Avatrix__" + t) if not rx.search(n)]
erros += [t for t in sys.argv[2].split() if rx.search("mcp__avatrix__" + t)]
print("ok" if not erros else "fora do lugar: " + " ".join(sorted(set(erros))))
EOF
)" ok

[ $falhas -eq 0 ] && echo "teste ok: trava da fábrica de reels" || { echo "$falhas falha(s)"; exit 1; }
