---
name: fabrica-de-reels
description: Fábrica de reels de um personagem 100% IA na Avatrix, de ponta a ponta. Cria o personagem do jeito certo (com ofício, marca, jeito, lugar, voz, um porquê e um inimigo, nunca um rosto sorteado), clona um reel viral pra ele (link do viral → reel montado, com legenda, gancho e a palavra pra comentar escritos), agenda pelo Piloto Automático, liga a DM automática e mede no dia seguinte. Imagem, voz e vídeo saem só da Avatrix, com os modelos de vídeo Persona Pro (primeiro) e Avatar Pro (só quando o primeiro não pode gerar). Use quando o aluno disser "cria meu personagem", "cria um personagem igual esse perfil", "clona esse reel pro meu personagem", "faz um reel desse viral", "agenda o reel", "liga a DM", "fabrica dm", "como foi o reel de ontem", "fabrica continua", "continua o reel". NÃO use pra novelinha com vários personagens em partes (skill novelinha), anúncio de produto do Studio, carrossel nem foto solta do personagem.
---

# Fábrica de reels

S = a pasta deste arquivo. A versão está em S/VERSION. A pasta de trabalho é `fabrica/<nome-do-personagem>/` no projeto do aluno (no site do Claude, no ambiente da conversa). O estado fica em `fabrica/<nome-do-personagem>/estado.json` (modelo no fim); cada reel tem a pasta `reels/<AAAA-MM-DD>-<tema>/`.

## Primeira mensagem
- **Onde você está.** Site do Claude (claude.ai) ou app no modo conversa, e não Claude Code (sinal: a pasta S fica em `/mnt/` e o aluno subiu a skill em Personalização > Skills): siga também "No site do Claude". No site, nunca mande o aluno abrir terminal, rodar comando, instalar programa nem editar configuração.
- **Versão nova (só no site, uma vez por conversa, sem atrasar nada):** se esta conversa tem ferramenta pra abrir página da web, abra https://raw.githubusercontent.com/avatrix-io/skills/main/skills/fabrica-de-reels/VERSION. Número maior que o de S/VERSION: diga numa linha só "Saiu a fábrica de reels v<número>. Pra atualizar, baixe o fabrica-de-reels.zip em https://github.com/avatrix-io/skills/releases/latest e suba de novo em Personalização > Skills." e siga. Sem essa ferramenta, ou se a página não abrir, siga sem falar disso. No Claude Code, pule este passo.
- Diga "fábrica de reels v" + o número de S/VERSION e "eu te mostro o preço antes e só gasto crédito quando você responder sim".
- No site, diga também: "O site vai pedir vários cliques de 'Permitir uma vez' enquanto eu gero. Faz o reel inteiro nesta conversa."
- Teste a Avatrix: `get_credits` e `list_influencers`. Sem resposta: no site, o passo 1 de "No site do Claude"; no Claude Code, S/COMO-INSTALAR.md, passo 2.
- **Saldo antes de tudo.** O saldo que vale é o comum de `get_credits` (o "saldo" que aparece na cotação soma o bônus, que não paga geração; e a leitura do viral no Chat IA prende até 15 do saldo comum na hora e devolve o que sobrar). Compare com o pedido (estimativa; a cotação manda): o que falta no personagem (criar do zero ~50; com a foto do próprio aluno ~10; só ficha e voz ~10) + o reel (~75 num viral de ~30 s; entre ~130 e ~200 num de ~1 minuto). Faltando: diga a faixa e quanto falta, e `show_plans` ANTES de começar ficha ou download. Com saldo que cobre, não mostre planos. Se `get_credits` disser que a conta tem geração de prova, ofereça usar pra mostrar uma imagem de exemplo, como a regra da conexão manda (uma `generate_image`, sem mudar modelo nem resolução). Ela não entra no personagem (a foto fixa precisa do rosto salvo); o personagem começa quando houver saldo.
- Teste `ffmpeg -version`. No site ele já vem; se não vier, avise e siga. No Claude Code, sem ffmpeg: S/COMO-INSTALAR.md, passo 3.
- **Antes de atender o pedido, se há post agendado com DM desligada** (no estado, na ficha do reel colada ou nos posts do Piloto): rode a Volta da DM (S/references/postar-dm-medir.md). Depois atenda o pedido.
- Uma pergunta por vez, com a sua sugestão. Pergunta que não é de dinheiro pede "ok" ou "segue" ("Sugiro X. Ok?"), nunca "sim": **"sim" é só pra gastar**.

## Fases: leia o estado, abra SÓ a referência da fase

| Fase | Quando | Abra |
|---|---|---|
| 0. Personagem | o aluno ainda não tem personagem pronto (`personagem.pronto` não é true) | S/references/personagem.md |
| 1. Viral e roteiro (passos 1 a 4) | personagem pronto e o aluno mandou um viral ou pediu um reel | S/references/viral-e-roteiro.md |
| 2. Geração (passos 5 a 7) | roteiro aprovado e "sim" pro gasto do reel | S/references/geracao.md (prompts em S/references/prompts.md) |
| 3. Conferir e montar (passos 8 a 10) | todas as cenas geradas | S/references/conferir-e-montar.md |
| 4. Postar, DM e medir (passos 11 a 15) | reel aprovado, post agendado, "fabrica dm", ou 24 h depois do post | S/references/postar-dm-medir.md |

**`fabrica continua` / `continua o reel`:** leia o estado e siga do `passo` gravado no reel. Antes de gerar qualquer coisa, cruze o `cenas` do reel com `list_tasks` (`taskIds`): o que está pronto ou ainda gerando não se gera de novo. Sem estado (no site, conversa nova): "Conversa nova no site".
**`fabrica dm`:** só a Volta da DM (S/references/postar-dm-medir.md), sem o cabeçalho da primeira mensagem: confere, liga o que falta e responde em 1 linha (ou nada, se não havia o que ligar). Nunca retoma geração.
**"Usa o Avatar Pro primeiro"** (ou outra ordem): reescreva `motores` no estado, leia de volta e diga a ordem nova. Personagem sem voz da galeria no idioma dele já nasce com o Avatar Pro (S/references/personagem.md, passo E).

## No site do Claude
1. **Avatrix sem resposta:** "Vamos ligar a Avatrix, só clicando: na barra do lado, clica em Personalização > Conectores > Adicionar conector > personalizado. No nome, escreve Avatrix; no endereço, cola https://avatrix.io/mcp. Clica em Adicionar e em Vincular, entra na sua conta da Avatrix e clica em Permitir. Depois abre uma conversa nova e escreve: fabrica continua." Não aparece o personagem que o aluno já criou: ele entrou com outra conta; mande desconectar e vincular de novo com a conta certa.
2. **Rede (pra baixar imagens, falas e cenas e montar o reel):** "Clica no seu nome > Configurações > Recursos. Confere que a criação de arquivos está ligada. Liga o 'Permitir acesso de rede externo', escolhe 'Só gerenciadores de pacotes' e, nos domínios permitidos, cola *.avatrix.io. Depois abre uma conversa nova, porque a rede só vale em conversa nova." Se um download falhar com o `*.avatrix.io` já colado, mostre o domínio da URL e peça pra colar ele também. Sem o campo dos domínios, a conta do Claude dele ainda não tem a opção: diga isso, sem mandar instalar nada.
3. **A trava no site é o "sim" + o "Permitir uma vez".** O script da trava não roda no site. Na 1ª vez que o site pedir licença: "Pra gerar imagem, voz ou vídeo, clica em Permitir uma vez, nunca em Sempre permitir. Pra ler a sua conta (créditos, personagens, posts) e pras ferramentas que não gastam (subir arquivo, confirmar o upload, tirar quadro de vídeo), pode Sempre permitir."
4. **Um reel por conversa.** O ambiente começa vazio a cada conversa. Ao fim de cada passo, mostre a **ficha do reel**, um bloco curto pra copiar: personagem (nome, id e as 3 marcas), voz (nome, id, tom e palavras por segundo), a ordem dos modelos de vídeo, o link do viral, o roteiro em uma linha por cena, o id de cada fala, imagem e cena já prontas, a palavra pra comentar, o texto da DM, o link do botão, a grade do perfil com o fuso, e de cada post: rede, id e horário. Diga: "Guarde isso. Se a conversa travar ou ficar cheia, abre uma nova, cola essa ficha e escreve fabrica continua." Aviso de limite do Claude: "Espera a hora que ele mostra e escreve continua, nesta mesma conversa."
5. **Conversa nova no site** (sem estado): remonte antes de gastar. (1) Ficha colada: use. (2) Sem ficha: `list_influencers` + `get_influencer`, `list_tasks` com `limit: 50` (falas, imagens e cenas prontas, com a mídia) e `list_posts` com `limit: 50` (os posts; a legenda dá a palavra pra comentar já usada). O link do botão: peça uma vez. O texto da DM sai do passo 12 a partir da legenda do post, é mostrado ao aluno e só liga com o ok dele: nunca ligue DM com texto que o aluno não viu. Mostre o que achou e pergunte de onde seguir. O `list_tasks` não diz de qual personagem nem de qual cena é cada tarefa: case pelo rosto nas referências e pela duração (a cena do Persona Pro sai com a duração da fala, mais uns 0,3 s), e grave o que achou. O tempo de cada palavra só volta no `wait_for_task` (uma fala por vez, `timeoutSeconds: 0`), nunca no `wait_for_tasks`. Baixe de novo o que está pronto; nunca gere de novo o que já está pronto.
6. **A DM no site:** não há rotina. Ao agendar, diga: "Volte NESTA conversa depois do horário do post e escreva: fabrica dm. É aí que eu ligo a DM." Toda vez que a conversa abrir, a primeira coisa é a Volta da DM.

## Regras (valem em todas as fases)
1. **Preço antes, gasto só com "sim".** Toda chamada paga (`generate_influencer`, `generate_image`, `generate_voice`, `generate_video`, `change_voice`, `download_social`, `send_message`) vai antes com `get_cost: true`. São 2 paradas de dinheiro por reel: (1) ler o viral (baixar + a leitura no Chat IA, um gasto pequeno) e (2) o reel inteiro, depois do roteiro, até o máximo aprovado. Com um máximo por dia já combinado, nenhuma parada dentro dele. Fora do reel (personagem, rosto extra), um "sim" por geração. Passou do máximo: pare e pergunte. A janela do "sim" venceu (a trava barrou): repita quanto falta do máximo aprovado e peça "sim" de novo. No Claude Code isso é travado por máquina (S/COMO-INSTALAR.md, passo 4).
2. **Grave o id de cada geração no estado na hora em que mandar**, por cena (em `cenas.NN` do reel, que já diz de qual personagem e de qual cena é: o `list_tasks` não diz), não no fim. Nunca repita uma chamada paga "pra tentar de novo": "ainda gerando" é `wait_for_task` de novo (espera até 180 s por chamada); id perdido é `list_tasks`. Só depois de ver que falhou, refaça (e isso conta no máximo).
3. **Imagem, voz e vídeo só pela Avatrix.** O que a Avatrix não faz (achar o viral, conferir a cena, montar, escrever legenda, gancho e a palavra no vídeo) roda aqui no Claude, com ffmpeg e os scripts de S/scripts. No site, subir o reel pede 1 arraste do aluno, e cada cena que cair no Avatar Pro pede mais 1 (o áudio da troca de voz) (S/references/postar-dm-medir.md, passo 13; S/references/geracao.md). Fora isso, o aluno nunca move arquivo.
4. **O personagem é dele, com rosto novo.** Copia tipo e mecanismo de quem viraliza, nunca a cara nem o nome de uma pessoa real. Foto de pessoa de verdade só se for do próprio aluno (a Avatrix exige autorização do dono). Sem pessoa famosa, sem marca de terceiro, sem +18. Nunca prometa views nem dinheiro.
5. **O que o aluno não disse, você não inventa.** Ficha inventada é pior que vazia: pergunte numa rodada só, com 3 sugestões pra cada coisa que falta.
6. **Mostre as opções, não descarte por gosto seu.** Quem escolhe rosto, voz e versão é o aluno. **A voz é a que o aluno escolheu e está no estado** (`personagem.voz`). Se ela não aparece em `list_voices` ou a ferramenta recusa o id, PARE e diga isso ao aluno; nunca troque por outra voz "parecida" nem siga com a voz padrão.
7. **Para só no que mata o reel.** Detalhe que não muda o entendimento não reprova cena.
8. **Publicar não tem ensaio.** `schedule_post`, `republish_post`, `send_dm` e `reply_comment` executam de verdade, sem cotação: perfil, legenda e horário confirmados antes (S/references/postar-dm-medir.md, passo 13).
9. **Português simples com o aluno**, frase curta. Nada de id, JSON, log nem URL de mídia crua quando há cartão na tela, exceto dentro da ficha do reel, que é pra copiar e colar. Fale "a palavra pra comentar" (não "CTA"), "o máximo que eu posso gastar" (não "teto"), "o modelo de vídeo" (não "motor"). Sem gênero pro aluno: "a regra que está na ficha", nunca "que você mesma pôs".
10. **Conta sem Piloto Automático** (`list_posts`, `list_social_accounts`, `list_dm_automations`, `get_seats` e `get_piloto_results` devolvem "ainda não tem o Piloto Automático"): não é falha. Pule as checagens que dependem deles, use só o estado e a ficha, e siga.
11. **Pergunta de dinheiro.** Se o aluno perguntar, por conta própria, como ganhar dinheiro com o personagem, o que vender ou que oferta pôr no link, responda curto e feche com a frase de S/references/proximo-passo.md §Quando o aluno perguntar de dinheiro. Fora disso, o assunto só aparece uma vez, depois do primeiro reel aprovado (passo 10). Já é aluno do curso: não fale disso.

## Quando ela para e chama o aluno
- O "sim" pra ler o viral e o "sim" pro reel (ou o máximo do dia), e qualquer passo que passe do máximo.
- O ok da postagem nos 3 primeiros posts de cada perfil.
- Perfil não ligado no Piloto, autorização caída ou conta sem Piloto.
- Personagem sem voz salva; saldo menor que o reel.
- A mesma cena falhou duas vezes: mostra as duas tentativas.
- O viral é um tema que o perfil postou nos últimos 14 dias.
- Personagem com voz clonada e o Persona Pro não pode gerar (S/references/geracao.md).

## O estado (`fabrica/<personagem>/estado.json`)
```json
{
  "versao": "0.3.9",
  "personagem": {"id": "", "nome": "", "pronto": false, "passo": "A", "idioma": "pt-BR",
    "marcas": ["", "", ""], "objeto": "", "lugar": "",
    "fotos_fixas": {"rosto": "", "corpo": "", "lugar": "", "objeto": ""},
    "voz": {"voiceId": "", "nome": "", "clonada": false, "palavras_por_segundo": 0, "tom_hz": 0, "troca_no_fim": false}},
  "motores": ["avatrix-persona-pro", "avatrix-avatar-pro"],
  "dinheiro": {"reels_com_sim": 0, "maximo_por_dia": null},
  "perfis": [{"accountId": "", "rede": "", "arroba": "", "fuso": "America/Sao_Paulo",
    "grade": ["07:00", "12:00", "19:00"], "posts_com_ok": 0, "pergunta_sempre": false, "link_do_botao": ""}],
  "palavras_usadas": [],
  "reels": [{"pasta": "reels/2026-11-10-tema", "passo": 3, "viral": "", "palavra": "",
    "maximo": 0, "previsto": 0, "gasto": 0,
    "personagem_id": "", "leitura": "", "troca_final": {"upload_audio": "", "troca_de_voz": ""},
    "cenas": {"01": {"fala": "", "imagem": "", "video": "", "modelo": "", "upload_audio": "", "troca_de_voz": "", "dur_fala": 0}},
    "posts": [{"postId": "", "accountId": "", "horario": "", "dm_ligada": false, "medido": false}]}]
}
```
Grave só o que já aconteceu. Campo não decidido fica vazio, nunca chutado. No site, o estado vive só na conversa: a ficha do reel é o que sobrevive.
