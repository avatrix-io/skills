# Skills da Avatrix para o Claude

**Português** · [Español](README.es.md) · [English](README.en.md)

Duas skills que fazem o Claude criar vídeo com IA na sua conta da [Avatrix](https://avatrix.io), do link de um viral até o vídeo pronto pra postar. Elas mostram o preço antes e só gastam crédito depois que você responde "sim".

| Skill | O que faz | Você digita | Você recebe |
|---|---|---|---|
| **novelinha** | Faz uma novelinha com IA: série curta vertical, em partes, com os mesmos personagens. Em português, espanhol ou inglês. | "faz uma novelinha" + o link de uma novelinha que está viralizando | A temporada de 3 a 5 partes esboçada, o roteiro pra aprovar, os personagens criados na sua conta e cada parte montada em mp4, uma de cada vez |
| **fabrica-de-reels** | Cria um personagem 100% IA e clona reels virais pra ele. | "cria meu personagem" e depois "clona esse reel pro meu personagem" + o link do viral | O personagem pronto, o reel em mp4 com legenda, gancho e a palavra pra comentar e, se a sua conta tiver o Piloto Automático, o post agendado com a DM ligada |

## O que você precisa
- **O Claude**: o site [claude.ai](https://claude.ai), o aplicativo no modo conversa ou o Claude Code (no terminal).
- **Uma conta na Avatrix** com crédito.

## Instalar: copie uma mensagem e cole no Claude

A mesma mensagem serve no Claude Code e no site ou no app do Claude. Abra o Claude (no Claude Code, na pasta onde você quer trabalhar), cole a mensagem da skill que você quer e responda o que ele perguntar. No Claude Code ele baixa, instala, liga a Avatrix e te diz o que digitar. No site, ele te guia clique por clique: baixar o zip, subir a skill, ligar a Avatrix e liberar a internet que ela precisa. Você só entra na sua conta da Avatrix quando ele pedir.

**Novelinha:**
```text
Instala pra mim a skill novelinha da Avatrix. O passo a passo está em https://raw.githubusercontent.com/avatrix-io/skills/main/INSTALL.md: lê e segue. No Claude Code, faz tudo sozinho. No site ou no app do Claude, me guia nos cliques, um por vez: baixar https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip, subir em Personalização > Skills e ligar o conector da Avatrix com o endereço https://avatrix.io/mcp. No fim, me diz o que eu digito pra começar.
```

**Fábrica de reels:**
```text
Instala pra mim a skill fabrica-de-reels da Avatrix. O passo a passo está em https://raw.githubusercontent.com/avatrix-io/skills/main/INSTALL.md: lê e segue. No Claude Code, faz tudo sozinho. No site ou no app do Claude, me guia nos cliques, um por vez: baixar https://github.com/avatrix-io/skills/releases/latest/download/fabrica-de-reels.zip, subir em Personalização > Skills e ligar o conector da Avatrix com o endereço https://avatrix.io/mcp. No fim, me diz o que eu digito pra começar.
```

**As duas:**
```text
Instala pra mim as duas skills da Avatrix, novelinha e fabrica-de-reels. O passo a passo está em https://raw.githubusercontent.com/avatrix-io/skills/main/INSTALL.md: lê e segue. No Claude Code, faz tudo sozinho, cada skill na sua pasta. No site ou no app do Claude, me guia nos cliques, um por vez: baixar https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip e https://github.com/avatrix-io/skills/releases/latest/download/fabrica-de-reels.zip, subir os dois em Personalização > Skills e ligar o conector da Avatrix com o endereço https://avatrix.io/mcp. No fim, me diz o que eu digito pra começar em cada uma.
```

O que o Claude faz com a mensagem está no [INSTALL.md](INSTALL.md): no Claude Code, baixa este repositório, instala a skill (pelo sistema de plugins, que já traz a trava do "sim" e o aviso de versão nova), liga a conexão da Avatrix e para pra você fazer o login; no site, te passa os cliques abaixo, um de cada vez. Ele não pede senha.

Prefere fazer sozinho? Os cliques estão logo abaixo.

### No site ou no aplicativo do Claude, modo conversa (zip)
1. Baixe o arquivo da skill: [novelinha.zip](https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip) ou [fabrica-de-reels.zip](https://github.com/avatrix-io/skills/releases/latest/download/fabrica-de-reels.zip).
2. No Claude, vá em Personalização > Skills > Adicionar skill > Fazer upload e escolha o zip, sem abrir.
3. Ligue a Avatrix em Personalização > Conectores > Adicionar conector > personalizado: nome `Avatrix`, endereço `https://avatrix.io/mcp`. Clique em Vincular e entre na sua conta.
4. Abra uma conversa nova e escreva "faz uma novelinha" ou "cria meu personagem".

O passo a passo completo, com o ajuste de internet que a skill precisa, está no `COMO-INSTALAR.md` de cada skill: [novelinha](skills/novelinha/COMO-INSTALAR.md) · [fábrica de reels](skills/fabrica-de-reels/COMO-INSTALAR.md).

### Ou faça na mão, no terminal
Na pasta do projeto (uma pasta pra cada skill, por exemplo `minhas-novelas` e `meus-reels`):

```bash
claude plugin marketplace add avatrix-io/skills
claude plugin install novelinha@avatrix-skills --scope project
claude mcp add --transport http avatrix https://avatrix.io/mcp
```

Pra fábrica de reels, troque `novelinha` por `fabrica-de-reels`. Depois, dentro do Claude Code, `/mcp` > avatrix > login, e instale o ffmpeg (`brew install ffmpeg` no Mac, `winget install ffmpeg` no Windows). Na fábrica de reels, junte também ao `.claude/settings.json` do projeto o bloco `permissions` do passo 4 do [COMO-INSTALAR.md dela](skills/fabrica-de-reels/COMO-INSTALAR.md) (o plugin não traz) e confira o `python3 --version`.

## Atualizar
- **Claude Code (instalado pelo plugin):** quando sai versão nova, aparece uma linha no começo da sessão com o comando: `claude plugin update novelinha@avatrix-skills` (ou `fabrica-de-reels@avatrix-skills`). Depois abra o Claude Code de novo. Instalou copiando a pasta? Não aparece aviso: cole de novo a mensagem de instalação.
- **Site do Claude:** a skill avisa no começo da conversa, quando a conversa tem acesso à web. Pra atualizar, baixe o zip de novo (links acima) e suba no lugar do antigo em Personalização > Skills.

## Perguntas comuns
**Quanto custa?** A skill cota cada geração na Avatrix e mostra o preço em créditos antes. Sem o seu "sim", ela não gera nada.

**Preciso saber programar?** Não. No Claude Code você cola a mensagem e ele faz o resto; no site do Claude é tudo clicando.

**Posso instalar as duas?** Pode, cada uma na sua pasta de projeto. Cada skill tem a própria trava do "sim", e as duas no mesmo projeto se atrapalham.

**A skill disse que a Avatrix não respondeu.** O conector não está ligado ou entrou com outra conta. Refaça o passo 3 (site) ou o `/mcp` (Claude Code).

**Parou no meio.** Escreva "novelinha continua" ou "fabrica continua" na mesma conversa. Numa conversa nova, cole a ficha que a skill mostra no fim de cada etapa.

**O que muda em cada versão?** Está no [CHANGELOG](CHANGELOG.md).

## Quem fez
Essas skills são do João Pedro (@joaopedroiaa). Quando quiser transformar o perfil em venda, o próximo passo é o Sistema Influencer IA: https://sistema-influencer-ia.vercel.app
