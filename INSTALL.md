# Instalação feita pelo agente

Este arquivo é pra você, agente (Claude Code no terminal ou no app). O usuário colou uma mensagem pedindo pra instalar uma skill da Avatrix. Siga os passos na ordem, fale com ele em português simples e diga antes o que cada comando faz.

Regras:
- Não peça senha nem token, e não digite login por ele. O único passo que é dele é entrar na conta da Avatrix (passo 5).
- Rode comandos só pra esta instalação: o clone deste repositório, os comandos `claude plugin` e `claude mcp`, e a cópia da pasta da skill pro projeto. Nada de apagar ou mexer em outros arquivos do usuário.
- Não gere imagem nem vídeo durante a instalação. Ela não gasta crédito.
- Deu erro num passo: diga o erro em uma frase e o que ele pode fazer. Não invente um caminho por fora.

## 0. Qual skill e onde
- `novelinha`: série curta com personagens de IA, em partes.
- `fabrica-de-reels`: personagem 100% IA e reels clonados de virais.
- Pasta de trabalho: a pasta aberta agora. Se ela tiver outra skill da Avatrix instalada (pasta `.claude/skills/novelinha` ou `.claude/skills/fabrica-de-reels`, ou o plugin na lista do passo 2), não ponha a segunda na mesma pasta: cada uma tem a própria trava do "sim" e as duas juntas se atrapalham. Crie uma subpasta (`minhas-novelas` ou `meus-reels`) e instale lá. Pedido das duas: uma em cada subpasta.

## 1. Baixar o repositório
```bash
git clone --depth 1 https://github.com/avatrix-io/skills "${TMPDIR:-/tmp}/avatrix-skills" 2>/dev/null || git -C "${TMPDIR:-/tmp}/avatrix-skills" pull --ff-only
```
Sem `git`: diga que precisa dele (git-scm.com) e pare.

## 2. Instalar a skill
Tem o comando `claude plugin` (`claude plugin --help` responde)? Use o plugin, que já traz a trava do "sim" e o aviso de versão nova. Rode dentro da pasta de trabalho:
```bash
claude plugin marketplace add avatrix-io/skills    # se já existir, rode: claude plugin marketplace update avatrix-skills
claude plugin install <skill>@avatrix-skills --scope project
```
Sem `claude plugin`: copie a skill pro projeto e ligue a trava à mão.
```bash
mkdir -p .claude/skills && cp -R "${TMPDIR:-/tmp}/avatrix-skills/skills/<skill>" .claude/skills/
```
Depois a trava: siga o passo "A trava do sim" do `COMO-INSTALAR.md` da skill (`.claude/skills/<skill>/COMO-INSTALAR.md`). Se `.claude/settings.json` já existir, junte o bloco `hooks` ao que já está lá, sem apagar nada.

## 3. Conferir que carregou
- Plugin: `claude plugin list` mostra `<skill>@avatrix-skills` com status ligado.
- Cópia: `.claude/skills/<skill>/SKILL.md` existe.
A skill aparece numa sessão nova do Claude Code (ou depois de `/reload-plugins`).

## 4. Ligar a Avatrix
`claude mcp list` já mostra `avatrix`? Pule. Senão:
```bash
claude mcp add --transport http avatrix https://avatrix.io/mcp
```

## 5. Login (só o usuário faz)
Pare aqui e diga a ele, com estas palavras: "Agora é com você: digite /mcp, escolha avatrix e entre na sua conta da Avatrix no navegador que abrir. Eu não vejo nem digito a sua senha."

## 6. ffmpeg
`ffmpeg -version` responde? Pule. Senão, diga o comando e pergunte se pode rodar: Mac `brew install ffmpeg`; Windows `winget install ffmpeg`; Linux `sudo apt install ffmpeg`. Só rode com o ok dele.

## 7. Fechar
Apague a cópia temporária (`rm -rf "${TMPDIR:-/tmp}/avatrix-skills"`) e diga ao usuário, numa mensagem curta:
- o que ficou instalado e em qual pasta;
- que precisa abrir uma sessão nova do Claude Code nessa pasta (e fazer o login do passo 5, se ainda não fez);
- o que digitar pra começar: `faz uma novelinha` (novelinha) ou `cria meu personagem` (fábrica de reels).
