# Instalação feita pelo agente

Este arquivo é pra você, agente. O usuário colou uma mensagem pedindo pra instalar uma skill da Avatrix. Fale com ele no idioma em que ele escreveu (português, espanhol ou inglês), simples.

**Onde você está?** Tem terminal (Claude Code, no terminal ou no app)? Pule pra "Regras" e siga os passos 0 a 7, dizendo antes o que cada comando faz. Está no site do Claude (claude.ai) ou no app no modo conversa, sem terminal? Siga só a parte "No site ou no app do Claude", logo abaixo. Você não consegue instalar skill no site sozinho: o usuário clica, você guia.

## No site ou no app do Claude (sem terminal)
Mande um passo por mensagem e espere ele dizer "feito" (ou o que apareceu na tela) antes do próximo. Se o nome de um botão na tela dele for outro, siga o que ele vê. Português abaixo; em espanhol a Personalização é "Personalizar" e Skills é "Habilidades"; em inglês, "Customize" e "Skills".
1. **Baixar a skill:** "Clica neste link e salva o arquivo, sem abrir: https://github.com/avatrix-io/skills/releases/latest/download/<skill>.zip". Pedido das duas skills: os dois links (`novelinha.zip` e `fabrica-de-reels.zip`).
2. **Subir a skill:** "Na barra do lado, clica em Personalização > Skills > Adicionar skill > Fazer upload e escolhe o zip que baixou, do jeito que veio." Duas skills: um zip de cada vez. Tem que aparecer a skill ligada. Se não aparecer Skills no menu, a criação de arquivos está desligada: passo 4 primeiro.
3. **Ligar a Avatrix:** "Ainda em Personalização, clica em Conectores > Adicionar conector > personalizado. No nome, escreve Avatrix; no endereço, cola https://avatrix.io/mcp. Clica em Adicionar e em Vincular, entra na sua conta da Avatrix e clica em Permitir. Tem que aparecer Conectado." Sem conta: ele cria uma em https://avatrix.io e volta.
4. **Liberar a internet pra Avatrix:** "Clica no seu nome > Configurações > Recursos. Confere que a criação de arquivos está ligada. Liga o Permitir acesso de rede externo, escolhe Só gerenciadores de pacotes e, nos domínios permitidos, cola *.avatrix.io." Sem o campo dos domínios, a conta do Claude dele ainda não tem essa opção: diga isso e siga.
5. **Fechar:** "Agora abre uma conversa nova (a internet liberada só vale em conversa nova) e escreve: faz uma novelinha" (novelinha; em espanhol `haz una novelinha`, em inglês `make a novelinha`) ou "cria meu personagem" (fábrica de reels). Diga também que, ao gerar, o site pede "Permitir uma vez": é o certo pra imagem, voz e vídeo; pra ler a conta pode "Sempre permitir".

Nunca mande abrir terminal, rodar comando ou instalar programa no site. O passo a passo com mais detalhe está no `COMO-INSTALAR.md` de cada skill, parte "No site do Claude".

## No Claude Code

### Regras
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
Pare aqui e diga a ele, com estas palavras (ou as mesmas no idioma dele): "Agora é com você: digite /mcp, escolha avatrix e entre na sua conta da Avatrix no navegador que abrir. Eu não vejo nem digito a sua senha."

## 6. ffmpeg
`ffmpeg -version` responde? Pule. Senão, diga o comando e pergunte se pode rodar: Mac `brew install ffmpeg`; Windows `winget install ffmpeg`; Linux `sudo apt install ffmpeg`. Só rode com o ok dele.

## 7. Fechar
Apague a cópia temporária (`rm -rf "${TMPDIR:-/tmp}/avatrix-skills"`) e diga ao usuário, numa mensagem curta:
- o que ficou instalado e em qual pasta;
- que precisa abrir uma sessão nova do Claude Code nessa pasta (e fazer o login do passo 5, se ainda não fez);
- o que digitar pra começar: `faz uma novelinha` (novelinha; em espanhol `haz una novelinha`, em inglês `make a novelinha`) ou `cria meu personagem` (fábrica de reels).
