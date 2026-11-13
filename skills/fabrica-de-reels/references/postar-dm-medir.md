# Fase 4: postar, DM e medir (passos 11 a 15)

**LÊ do estado:** `personagem.id`, `perfis` (accountId, fuso, grade, posts_com_ok, pergunta_sempre, link_do_botao), o reel atual (`palavra`, `posts`), a `ficha-postagem.md` e o `reel.mp4` da pasta do reel.
**GRAVA no estado:** `perfis` (na 1ª vez), `posts` do reel (postId, accountId, horário, `dm_ligada`, `medido`), `posts_com_ok` + 1 a cada ok, `passo` do reel. Na pasta do reel: `resultado.md` (passo 15).
**PRONTO QUANDO:** o post saiu, a DM está ligada e lida de volta, e o resultado de 24 h foi mostrado ao aluno.

Sumário: 11. Perfil ligado · 12. Ficha de postagem · 13. Agendar · 14. Ligar a DM (Volta da DM) · 15. Medir · O que o Piloto ainda não faz.

Tudo aqui é o Piloto Automático da Avatrix e não gasta crédito. **Publicar não tem ensaio:** `schedule_post` e `republish_post` executam de verdade.

## 11. Perfil ligado (só na primeira vez)
- `list_social_accounts`: rede, @, se está ligado e se a autorização está saudável.
- **A conta não tem Piloto** (a resposta diz que ainda não tem o Piloto Automático): não trave. O reel e a ficha de postagem já estão prontos. Ofereça as duas saídas, com a sua sugestão: (A) ligar o Piloto: `get_seat_checkout_link` e o aluno decide se compra (os planos Creator e Pro não incluem lugar; o Ultimate inclui um); (B) postar à mão: ele baixa o `reel.mp4` e cola a legenda da ficha. No caminho B não há DM automática nem medição pela skill: diga isso.
- **Tem Piloto e falta o perfil:** `get_seats` (lugar livre?) e `get_connect_url` com a rede. Mande o link pro aluno abrir no navegador em que o perfil certo está logado (o Instagram liga o que estiver logado). Rode `list_social_accounts` de novo até aparecer ligado.
- **Amarre o perfil ao personagem:** `link_influencer_to_account` com o `accountId` e o id do personagem, pra nunca postar no perfil errado.
- **Grave em `perfis`** o `accountId`, a rede, o @ e, perguntando uma vez só:
  - a **grade** (horários do dia em que o perfil posta; sugira 3 e deixe ele mudar) e o **fuso** (padrão `America/Sao_Paulo`);
  - o **link do botão da DM** (a página pra onde a DM leva). Mora aqui; nunca é digitado na hora de ligar a DM. Sem link ainda: siga sem DM (passo 14) e diga que ela liga quando ele tiver o link.

## 12. A ficha de postagem (0 crédito)
- **Confira o reel antes:** sem gancho e a palavra pra comentar escritos no vídeo, não agenda (volte ao passo 9).
- Legenda, primeiro comentário, título e DM no idioma do personagem (`voz.idioma` da ficha).
- **Legenda** na voz do personagem: a dor ou a curiosidade numa frase + "Comenta <PALAVRA> que eu te mando." A palavra é IGUAL à escrita no vídeo e à falada.
- **Primeiro comentário** (`firstComment`): no Instagram, a chamada pra comentar a palavra ("Comenta <PALAVRA> aqui embaixo que eu te mando no direct"); no Facebook, a chamada + o link do botão, com `likeFirstComment: true` (a página curte o próprio comentário). **Título do YouTube** (obrigatório lá).
- **DM curta com botão** (DM curta com botão clica mais que DM longa): saudação + UMA frase (o que é e pra que serve, sem medida, lista nem passo a passo) + "👇 Toca no botão aqui embaixo". Até ~280 caracteres, 1 a 3 emojis. Botão com emoji e o que a pessoa ganha, até 20 caracteres ("📖 Ver as receitas", "▶️ Ver o passo a passo"), nunca a compra ("Quero comprar"). Link sempre no botão, nunca solto no texto.
  > Exemplo (Dona Cida, inventada): "Oi, minha flor! 💅 É o truque do óleo morno que segura o esmalte uma semana inteira. 👇 Toca no botão aqui embaixo" · botão "💅 Ver o truque".

## 13. Agendar
- **Subir o reel pra Avatrix:** `upload_file` com `purpose: reference`.
  - **No Claude Code (automático):** `filename`, `sha256`, `sizeBytes`; PUT na URL que voltar com os cabeçalhos como vieram; `confirm_upload` com `etag` e `fileId`.
  - **No site do Claude:** a ferramenta abre o cartão de upload. Entregue o `reel.mp4` na conversa e diga com honestidade: "Agora é 1 arraste seu: baixa o reel aqui e arrasta pro cartão." (No site, subir o reel pede 1 arraste, e cada cena que caiu no Avatar Pro pediu mais 1, o áudio da troca de voz.) Nunca invente sha256.
- **O horário:** o aluno pediu um ("amanhã 12h")? Use esse. Senão, o próximo horário livre da grade. Nos dois casos, `list_posts` com `limit: 50` (não filtra por perfil: filtre pelo `accountId` na resposta) e confira que não há post desse perfil no mesmo horário. Nunca dois no mesmo horário.
- **Quem dá o ok:** nos 3 primeiros posts de cada perfil, mostre perfil, legenda e horário: "Próximo horário: hoje 19:00 · Instagram e Facebook. Posso agendar? Responde ok." No site sem estado, conte os posts desse perfil pelo `list_posts`, não por contador que some.
  - Depois do 3º ok, avise uma vez: "Daqui pra frente eu agendo sozinha nos horários desse perfil e só te aviso. Os seus 3 oks valem como confirmação pra essa grade. Se quiser que eu volte a perguntar, é só dizer: volta a me perguntar." Isso cumpre o "confirme antes" da Avatrix: a confirmação já foi dada pra esse perfil e essa grade. Horário fora da grade ou perfil novo: pergunta de novo. "Volta a me perguntar": grave `pergunta_sempre: true`.
- `schedule_post` com `accountIds`, `media: {kind: "file", id: <fileId>}`, `caption`, `scheduledFor` (ISO com o fuso do perfil, ex. `2026-11-11T19:00:00-03:00`) **ou** `publishNow: true` se ele pediu "posta agora", `platformSettings` (instagram e facebook com `firstComment`) e `youtubeTitle` se tiver YouTube. Vídeo no feed do Instagram sai como reel. Se o agendamento recusar a mídia, mostre o erro e entregue a ficha pra postar à mão.
- **Leia de volta:** `list_posts`, ache o post e grave `postId`, `accountId` e horário em `posts` do reel. Linha pro aluno: "Agendado pra 19:00 no Instagram e no Facebook · conferido na lista do Piloto."
- **No site, ao agendar:** "Volte NESTA conversa depois das 19:00 e escreva: fabrica dm. É aí que eu ligo a DM. Comentário que chegar antes fica sem DM." E mostre a ficha do reel (S/SKILL.md, "No site do Claude", passo 4).

## 14. Ligar a DM quando o post sai (Volta da DM)
A Avatrix só liga a DM em post **já publicado** pelo Piloto, e só no Instagram e no Facebook.
- **"Posta agora":** com o post publicado (`list_posts`), ligue no mesmo minuto.
- **Agendado:** no Claude Code, a rotina que o aluno ligou (S/COMO-INSTALAR.md, Claude Code, passo 5) roda `fabrica dm`, que faz SÓ a Volta da DM e nunca retoma geração; sem rotina, igual ao site: liga quando o aluno voltar. No site: toda vez que a conversa abrir, e quando ele escrever `fabrica dm`.
- **Volta da DM:** pra cada post do estado (ou da ficha colada) com `dm_ligada: false`: `list_posts` (`limit: 50`, filtre pelo postId).
  - Sem estado e sem ficha: escreva o texto da DM pelo passo 12 a partir da legenda do post, mostre ao aluno com o botão e só ligue com o ok dele. Nunca ligue DM com texto que o aluno não viu.
  - Rodando por `fabrica dm`: sem cabeçalho; confira, ligue o que falta e responda em 1 linha (ou nada, se não havia o que ligar).
  - Publicado e com link do botão: `create_dm_automation` com `postId`, `accountId`, `keywords: [<PALAVRA>]` (mais a variação sem acento, se houver acento), `dmMessage` (a da ficha), `buttons: [{title, url}]` com o `link_do_botao` do perfil. Depois `list_dm_automations` pra provar que ficou ativa e grave `dm_ligada: true`.
  - DM que falhou: `create_dm_automation` de novo (substitui a anterior nesse post e perfil).
  - **Post que falhou** em alguma rede: mostre e pergunte. `republish_post` só com "ok" do aluno e avisando antes: "isso publica NA HORA, mesmo se era agendado". Nunca repita sozinha.
- Linha pro aluno: "19:02 · publicado no Instagram e no Facebook · DM ligada com a palavra <PALAVRA>".

## 15. Medir 24 h depois e devolver o aprendizado
- `refresh_piloto_results` (sincroniza agora; um pedido novo fica travado 15 min) e depois `get_piloto_results` com o `accountId` e o dia do post: views, alcance, curtidas e comentários por rede (até 50 posts por leitura). DMs que saíram: `get_dm_automation_logs` com o id da automação (`list_dm_automations`).
- Compare com os outros reels do mesmo perfil (o mesmo `get_piloto_results` dos últimos 30 dias): acima ou abaixo da mediana, e qual gancho e qual tipo de viral puxou mais.
- Grave em `resultado.md` e `medido: true`. Diga numa linha: "<PALAVRA> em 24 h · <N> views no Instagram · <N> comentários · <N> DMs enviadas · acima/abaixo do normal do perfil". Use isso na escolha do próximo viral (S/references/viral-e-roteiro.md, "Onde achar").
- Número baixo com poucos posts é cedo pra concluir: diga isso em vez de chamar de fracasso.

## O que o Piloto ainda não faz (diga quando o aluno perguntar)
- DM em post agendado: só liga depois de publicado.
- DM em 2 passos ("toca pra liberar", "segue pra receber"): a DM do Piloto é de 1 passo, mensagem e botão.
- Carrossel: é uma mídia por post.
- Clique no botão da DM: nenhuma ferramenta devolve hoje.
