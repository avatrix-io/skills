# Skills da Avatrix para o Claude

Duas skills que fazem o Claude criar vídeo com IA na sua conta da [Avatrix](https://avatrix.io), do link de um viral até o vídeo pronto pra postar. Elas mostram o preço antes e só gastam crédito depois que você responde "sim".

| Skill | O que faz | Você digita | Você recebe |
|---|---|---|---|
| **novelinha** | Faz uma novelinha com IA: série curta vertical, em partes, com os mesmos personagens. | "faz uma novelinha" + o link de uma novelinha que está viralizando | O roteiro pra aprovar, os personagens criados na sua conta e a Parte 1 montada em mp4 |
| **fabrica-de-reels** | Cria um personagem 100% IA e clona reels virais pra ele. | "cria meu personagem" e depois "clona esse reel pro meu personagem" + o link do viral | O personagem pronto, o reel em mp4 com legenda, gancho e a palavra pra comentar e, se a sua conta tiver o Piloto Automático, o post agendado com a DM ligada |

## O que você precisa
- **O Claude**: o site [claude.ai](https://claude.ai), o aplicativo no modo conversa ou o Claude Code (no terminal).
- **Uma conta na Avatrix** com crédito.

## Instalar

### No site ou no aplicativo do Claude (sem terminal)
1. Baixe o arquivo da skill: [novelinha.zip](https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip) ou [fabrica-de-reels.zip](https://github.com/avatrix-io/skills/releases/latest/download/fabrica-de-reels.zip).
2. No Claude, vá em Personalização > Skills > Adicionar skill > Fazer upload e escolha o zip, sem abrir.
3. Ligue a Avatrix em Personalização > Conectores > Adicionar conector > personalizado: nome `Avatrix`, endereço `https://avatrix.io/mcp`. Clique em Vincular e entre na sua conta.
4. Abra uma conversa nova e escreva "faz uma novelinha" ou "cria meu personagem".

O passo a passo completo, com o ajuste de internet que a skill precisa, está no `COMO-INSTALAR.md` de cada skill: [novelinha](skills/novelinha/COMO-INSTALAR.md) · [fábrica de reels](skills/fabrica-de-reels/COMO-INSTALAR.md).

### No Claude Code (terminal)
Abra o terminal na pasta do projeto (uma pasta pra cada skill, por exemplo `minhas-novelas` e `meus-reels`) e rode:

```bash
claude plugin marketplace add avatrix-io/skills
claude plugin install novelinha@avatrix-skills --scope project
```

Pra fábrica de reels, troque `novelinha` por `fabrica-de-reels`. Depois ligue a Avatrix (`claude mcp add --transport http avatrix https://avatrix.io/mcp` e, dentro do Claude Code, `/mcp` > avatrix > login) e instale o ffmpeg (`brew install ffmpeg` no Mac, `winget install ffmpeg` no Windows). A trava do "sim" já vem ligada pelo plugin.

## Atualizar
- **Claude Code:** quando sai versão nova, aparece uma linha no começo da sessão com o comando: `claude plugin update novelinha@avatrix-skills` (ou `fabrica-de-reels@avatrix-skills`). Depois abra o Claude Code de novo.
- **Site do Claude:** a skill avisa no começo da conversa, quando a conversa tem acesso à web. Pra atualizar, baixe o zip de novo (links acima) e suba no lugar do antigo em Personalização > Skills.

## Perguntas comuns
**Quanto custa?** A skill cota cada geração na Avatrix e mostra o preço em créditos antes. Sem o seu "sim", ela não gera nada.

**Preciso saber programar?** Não. No site do Claude é tudo clicando.

**Posso instalar as duas?** Pode, cada uma na sua pasta de projeto. Cada skill tem a própria trava do "sim", e as duas no mesmo projeto se atrapalham.

**A skill disse que a Avatrix não respondeu.** O conector não está ligado ou entrou com outra conta. Refaça o passo 3 (site) ou o `/mcp` (Claude Code).

**Parou no meio.** Escreva "novelinha continua" ou "fabrica continua" na mesma conversa. Numa conversa nova, cole a ficha que a skill mostra no fim de cada etapa.

**O que muda em cada versão?** Está no [CHANGELOG](CHANGELOG.md).

## Quem fez
Essas skills são do João Pedro (@joaopedroiaa). Quando quiser transformar o perfil em venda, o próximo passo é o Sistema Influencer IA: https://sistema-influencer-ia.vercel.app
