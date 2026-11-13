#!/bin/bash
# Aviso de versão nova (SessionStart). Uso: aviso-de-versao.sh <skill>
# Lê a versão instalada em skills/<skill>/VERSION e a publicada no repositório.
# No máximo 1 consulta por dia (cache), 2 s de limite, nada do usuário é enviado
# (só um GET do arquivo público), sem rede ou com erro: sai calado. Nunca bloqueia.
REPO="avatrix-io/skills"   # único lugar com o endereço do repositório (dono/nome no GitHub)
RAMO="main"

s="$1"
raiz="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
dados="${CLAUDE_PLUGIN_DATA:-${TMPDIR:-/tmp}}"
url="${AVISO_URL:-https://raw.githubusercontent.com/$REPO/$RAMO/skills/$s/VERSION}"
cache="$dados/versao-publicada-$s"
local_v=$( { tr -d '[:space:]' < "$raiz/skills/$s/VERSION"; } 2>/dev/null ) || exit 0
[ -n "$local_v" ] || exit 0
case "$REPO" in *'{{'*) [ -z "$AVISO_URL" ] && exit 0;; esac  # endereço ainda não definido

agora=$(date +%s)
pub=""; quando=0
[ -r "$cache" ] && read -r quando pub < "$cache"
case "$quando" in ''|*[!0-9]*) quando=0;; esac
if [ $((agora - quando)) -ge 86400 ]; then
  pub=$(curl -fsS --max-time 2 "$url" 2>/dev/null | tr -d '[:space:]') || pub=""
  mkdir -p "$dados" 2>/dev/null && printf '%s %s\n' "$agora" "$pub" > "$cache" 2>/dev/null
fi
# só aceita algo com cara de versão (1.2.3), pra não repetir página de erro
printf '%s' "$pub" | grep -qE '^[0-9]+(\.[0-9]+)*$' || exit 0
[ "$pub" = "$local_v" ] && exit 0
maior=$(printf '%s\n%s\n' "$local_v" "$pub" | sort -V | tail -n1)
[ "$maior" = "$pub" ] || exit 0
printf '{"systemMessage": "Saiu a %s v%s (você tem a v%s). Pra atualizar, rode no terminal: claude plugin update %s@avatrix-skills e abra o Claude Code de novo."}\n' "$s" "$pub" "$local_v" "$s"
exit 0
