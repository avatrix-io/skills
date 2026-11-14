# Skills da Avatrix para o Claude

Duas skills que fazem o Claude criar vídeo com IA na sua conta da [Avatrix](https://avatrix.io), do link de um viral até o vídeo pronto pra postar. Elas mostram o preço antes e só gastam crédito depois que você responde "sim".

| Skill | O que faz | Você digita | Você recebe |
|---|---|---|---|
| **novelinha** | Faz uma novelinha com IA: série curta vertical, em partes, com os mesmos personagens. | "faz uma novelinha" + o link de uma novelinha que está viralizando | A temporada de 3 a 5 partes esboçada, o roteiro pra aprovar, os personagens criados na sua conta e cada parte montada em mp4, uma de cada vez |
| **fabrica-de-reels** | Cria um personagem 100% IA e clona reels virais pra ele. | "cria meu personagem" e depois "clona esse reel pro meu personagem" + o link do viral | O personagem pronto, o reel em mp4 com legenda, gancho e a palavra pra comentar e, se a sua conta tiver o Piloto Automático, o post agendado com a DM ligada |

## O que você precisa
- **O Claude**: o site [claude.ai](https://claude.ai), o aplicativo no modo conversa ou o Claude Code (no terminal).
- **Uma conta na Avatrix** com crédito.

## Instalar: cole uma mensagem no Claude

Abra o Claude Code (no terminal ou no app) na pasta onde você quer trabalhar e cole a mensagem da skill que você quer. Ele baixa, instala, liga a Avatrix e te diz o que digitar. Você só entra na sua conta da Avatrix quando ele pedir.

**Novelinha:**
```text
Instala pra mim a skill novelinha da Avatrix: clona https://github.com/avatrix-io/skills, lê o INSTALL.md de lá e segue os passos. No fim, me diz o que eu digito pra começar.
```

**Fábrica de reels:**
```text
Instala pra mim a skill fabrica-de-reels da Avatrix: clona https://github.com/avatrix-io/skills, lê o INSTALL.md de lá e segue os passos. No fim, me diz o que eu digito pra começar.
```

**As duas:**
```text
Instala pra mim as duas skills da Avatrix, novelinha e fabrica-de-reels, cada uma na sua pasta: clona https://github.com/avatrix-io/skills, lê o INSTALL.md de lá e segue os passos. No fim, me diz o que eu digito pra começar em cada uma.
```

O que o Claude faz com a mensagem está no [INSTALL.md](INSTALL.md): baixa este repositório, instala a skill (pelo sistema de plugins do Claude Code, que já traz a trava do "sim" e o aviso de versão nova), liga a conexão da Avatrix e para pra você fazer o login. Ele não pede senha.

**No site do Claude (claude.ai) a mensagem não funciona:** lá o Claude não instala skill sozinho. Use o zip, logo abaixo.

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

Pra fábrica de reels, troque `novelinha` por `fabrica-de-reels`. Depois, dentro do Claude Code, `/mcp` > avatrix > login, e instale o ffmpeg (`brew install ffmpeg` no Mac, `winget install ffmpeg` no Windows).

## Atualizar
- **Claude Code:** quando sai versão nova, aparece uma linha no começo da sessão com o comando: `claude plugin update novelinha@avatrix-skills` (ou `fabrica-de-reels@avatrix-skills`). Depois abra o Claude Code de novo.
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
