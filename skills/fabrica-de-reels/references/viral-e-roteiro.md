# Fase 1: viral e roteiro (passos 1 a 4 da rodada)

**LÊ do estado:** `personagem` (pronto, voz, fotos_fixas), `motores`, `palavras_usadas`, `reels` (últimos 14 dias), `dinheiro`.
**GRAVA no estado:** um item novo em `reels` (pasta, viral, palavra, previsto, maximo, `passo`, `personagem_id`, `leitura`). Na pasta do reel: `viral.md`, `roteiro.md`, `viral/viral.mp4`, `viral/quadros/`.
**PRONTO QUANDO:** o roteiro passou na rodada 1 de crítica (S/references/criticos.md), o aluno aprovou ("ok") e respondeu "sim" pro máximo do reel.

Sumário: 1. Conferir antes de tudo · Onde achar o viral · 2. Ler o viral (1ª parada de dinheiro), com mecanismo e casca · 3. Roteiro fiel no ritmo da voz, com a rodada 1 de crítica · 4. O reel inteiro (2ª parada de dinheiro).

## 1. Conferir antes de tudo (0 crédito)
- `get_influencer` do personagem: ficha, voz salva; fotos fixas no estado. `get_credits`: saldo comum (o bônus não paga geração). A ordem dos modelos de vídeo no estado.
- **O rosto salvo no personagem e as fotos fixas são a MESMA pessoa?** Ponha lado a lado (`python3 S/scripts/montar.py rostos <pasta das fotos fixas> --ref <rosto salvo> --saida rostos-fixas.jpg`) e olhe. Não são (outra idade, outro bigode, outro cabelo): pare e pergunte ao aluno qual vale, sem gastar; o que valer vira a referência de toda imagem.
- A voz do estado aparece em `list_voices`? Não aparece: pare e diga; nunca troque por outra.
- Falta algo (sem voz, sem fotos fixas, personagem não pronto): pare e diga o que falta. Não gaste nada. Personagem não pronto: S/references/personagem.md.
- **O ritmo da voz é medido, nunca estimado.** `personagem.voz.palavras_por_segundo` vazio ou zero (personagem que veio pronto, conversa nova): antes do roteiro, gere UMA fala de teste do tamanho de uma cena, 6 a 8 s, na voz do personagem (~3 créditos, entra no "sim" da leitura do viral), e meça `python3 S/scripts/medir_voz.py ritmo`. Roteiro escrito em cima de ritmo chutado sai corrido ou estoura o tempo, e o conserto custa o reel inteiro.
- Linha pro aluno: "<Nome> · voz <nome> (<N> palavras por segundo) · 4 fotos fixas ok · vídeo: 1º Persona Pro, 2º Avatar Pro · saldo <N> créditos".

## Onde achar o viral (sem link)
A Avatrix baixa um link, mas não acha o viral. Isso é com o aluno, no navegador dele, com você guiando:
- Perfis do mesmo tipo do personagem (os da criação) e a busca da rede pelo assunto do nicho.
- **Só dos últimos 2 dias** (no máximo 7). Viral velho já passou da onda.
- **Os 3 sinais:** (1) muita view em pouco tempo, bem acima dos outros posts do mesmo perfil; (2) o 1º quadro mostra um objeto ou uma ação que se entende sem som; (3) muito comentário, salvo ou compartilhamento.
- Peça 2 ou 3 links e ajude a escolher 1: o de gancho mais simples de entender nos 3 primeiros segundos. Com as medições anteriores (S/references/postar-dm-medir.md, passo 15), prefira o tipo de gancho que puxou mais no perfil.

## 2. Ler o viral (1ª parada de dinheiro, pequena)
- **Já postado?** O estado e `list_posts` (`limit: 50`, filtre pelo perfil na resposta): o tema (o objeto e o assunto) saiu no perfil nos últimos 14 dias? Saiu: avise antes de seguir. Sem Piloto (o aluno posta à mão), pergunte: "Você já postou sobre isso nos últimos 14 dias?"
- **Preço antes, um "sim" só pras duas coisas:** baixar o vídeo (`download_social` com `get_cost: true`; vale o preço que a cotação devolver) + a leitura no Chat IA (~2,5 a ~5 créditos, uma ou duas mensagens; sai do saldo comum, e a Avatrix prende até 15 na hora e devolve o que sobrar, então precisa de pelo menos 15 livres). "Pra ler o viral: ~<N> créditos. Posso? Responde sim." (N = o download cotado + a leitura) Esse valor entra na conta do reel desde a 1ª estimativa.
- **O vídeo:** `download_social` e baixe a URL pra `viral/viral.mp4` na hora. Com ffmpeg:
  - trocas de cena: `ffmpeg -i viral/viral.mp4 -vf "select='gt(scene,0.2)',showinfo" -f null - 2>&1 | grep pts_time` (limite 0,2: troca no mesmo cenário pontua baixo e escapa num limite maior);
  - 1 quadro de cada cena em `viral/quadros/` (`ffmpeg -ss <t> -i viral/viral.mp4 -frames:v 1 viral/quadros/c01.jpg`).
  - Pra usar o quadro como referência na Avatrix: `extract_video_frame` com a URL do vídeo e `atSeconds` (de graça). Ele devolve uma URL que vale 5 minutos (use na hora) e um fileId que não vence (guarde no `viral.md`).
- **A leitura no Claude Code com ferramenta de transcrição instalada** (ex.: whisper): transcreva o áudio do `viral/viral.mp4` aqui, com o tempo de cada frase, e pule o Chat IA (mais rápido e sem custo). Sem ela, e sempre no site do Claude:
- **A leitura no Chat IA:** `list_agents` (o oficial "Clonar Vídeo"), `start_conversation` com o `agentId` e `send_message` com o link em `socialUrl`, pedindo só a leitura, já na 1ª mensagem: a transcrição inteira, palavra por palavra, com o tempo de cada frase (se vier só o assunto, peça a fala numa 2ª mensagem, com texto diferente), cada troca de cena com o tempo, o que aparece no 1º quadro e o que prende. Grave o id da conversa em `leitura`. **Nunca chame `confirm_card` nessa conversa** (o agente propõe gerar; aqui não gera). Não reenvie a mesma mensagem: resposta demorou, `get_turn`.
- Grave em `viral.md`: link, perfil, data, views, curtidas, comentários, duração, a tabela "cena (de-até) → fala → o que aparece → quadro" e o que prende (o objeto do 1º quadro e o mecanismo).
- **Mecanismo ou casca (o teste de tirar).** Pra cada coisa do viral (o objeto do 1º quadro, a pergunta da abertura, a ordem dos passos, a virada, o exagero, o inimigo, a música, a cor, o enfeite na tela), pergunte: "tiro isso e o vídeo ainda prende?". Ainda prende: é casca, não precisa copiar. Para de prender: é mecanismo, vai pro roteiro, no mesmo lugar e no mesmo tempo. Grave no `viral.md` as duas listas, "Mecanismo (fica)" e "Casca (pode trocar)". O valor do outro (a receita exata dele, o produto dele) não se copia: o personagem entrega o dele.

## 3. Roteiro fiel, já no ritmo da voz (0 crédito)
- **Mantém o que prende:** a lista "Mecanismo (fica)" do `viral.md`: o objeto do 1º quadro, o que acontece e em que ordem, a câmera de perto, a ordem das cenas, o tamanho do viral (até 15% a mais ou a menos). É a mesma arquitetura do viral, com o personagem, o lugar e o valor dele. Mecanismo não se amacia: gancho, promessa, objeto, exagero e inimigo do viral ficam fortes.
- **A abertura não conta como se faz.** Os 3 primeiros segundos mostram o que a pessoa ganha ou o problema (o prêmio pode aparecer: "isso tira o mofo da parede"); o como (o ingrediente, o passo, o nome do método) fica pro meio. Quem recebe o método na 1ª frase já levou o que queria e passa o dedo. Exceção: em tutorial, dizer que existe um passo a passo é o gancho, mas executar o passo na 1ª frase não.
- **Troca:** a pessoa (o personagem), o lugar (o da ficha), a língua (a do personagem, `voz.idioma` da ficha, falada do jeito que ele fala; nunca traduzir pra português por padrão), número e nome que são do outro (o nosso número real, ou sai). Link, bandeira, marca e texto de tela do original saem.
- **Cena sem gente no viral** (só o objeto, só a página) vira cena com o personagem segurando o objeto: os modelos de vídeo fazem personagem falando e não partem bem de foto sem ninguém.
- **Tamanho pela voz salva:** palavras do roteiro ≤ duração do viral × `personagem.voz.palavras_por_segundo`. Escreva já com esse número de palavras, contando antes de mostrar (voz mais lenta que a do viral estoura o tempo se o texto for traduzido do mesmo tamanho). Estourou: corte primeiro o que repete, depois a frase menos importante do meio; nunca o gancho nem o fecho.
- **O ritmo é o do viral, não o da voz solta.** Conte as palavras do viral ÷ a duração dele. A voz do personagem fala mais rápido que isso (ou mais rápido que o `timbreRitmo` da ficha manda): grave no roteiro `speed` = ritmo do viral ÷ ritmo da voz (de 0,7 a 1,2) e use esse `speed` em TODAS as falas. O reel pronto fica entre 85% e 115% do viral: mais curto que isso é fala corrida e pausa comida, e o clone fica raso. Pausa que é do conteúdo (a reza, o gesto feito em silêncio, o suspense antes da frase) é marcada na coluna "Na tela" e se mantém.
- **Cada cena: fala de 5 a 8 s e UMA imagem própria.** Uma ideia por cena; cena longa com plano parado deixa o reel lento, e nunca 2 cenas da mesma imagem. O teto da ferramenta é 15 s de áudio (maior é recusado) e o vídeo cobra no mínimo 5 s: fala de menos de ~3 s sobra; junte frases curtas na mesma cena quando a tela deixar.
- **A fala não desmente a imagem e não inventa.** Leia cada fala junto com a coluna "Na tela": dizer "a parede fica limpa" com a parede manchada na tela é o espectador vendo que é mentira. Número, prazo e fato ("há mais de 10 anos", "9 em cada 10") só entram se o viral tem e você conferiu; senão, sai. Resultado nunca garantido.
- **A mesma palavra na fala e na tela.** O gancho escrito diz a palavra que o personagem fala (fala "energia", a tela não diz "entidade"). A palavra pra comentar é igual na fala, no texto do fim, na legenda do post e na DM.
- **Toda pergunta feita na fala tem resposta na fala seguinte** ("sabe pra que os antigos usavam?" → a fala seguinte diz pra quê). Antes de mostrar, leia só as falas em ordem, como quem nunca viu o viral: pergunta sem resposta é buraco; conserte antes do "sim" do gasto.
- **O fecho vende a oferta do TEMA do viral.** Leia `estrategia.regras` da ficha: personagem com mais de uma oferta diz ali qual fecha cada assunto (ex.: vídeo de prosperidade fecha com a oração; vídeo de receita fecha com o livro). O produto da ficha é de outro assunto e a ficha não diz o que fecha este: PARE e pergunte "esse vídeo é de <tema>; o que eu entrego pra quem comentar?". Nunca feche um vídeo de um assunto com o produto de outro, nem por sugestão sua.
- **O objeto do fecho (o livro, o produto) aparece só na cena do fecho.** Nas outras cenas o objeto é o do viral. Marque no roteiro em qual cena ele entra.
- **Gancho escrito** (até 18 letras por linha, no máximo 2 linhas, nos 3 primeiros segundos, no idioma do personagem) e **o fecho**: "Comenta <PALAVRA> que eu te mando…" na voz do personagem, com uma palavra no idioma do personagem (até 18 letras com o "Comenta") que o perfil ainda não usou (`palavras_usadas`). A mesma palavra vai escrita no fim do vídeo, na legenda do post e na DM.
- Número em dígito no roteiro; no texto que vai pra voz, escreva por extenso quando o gênero importa ("uma colherzinha", não "1 colherzinha").
- **Rodada 1 de crítica antes de mostrar** (S/references/criticos.md): os 3 críticos leem o roteiro; conserte o que mata e grave em `criticas.md`. Ao mostrar, diga numa linha o que a crítica mudou.
- Mostre a tabela e pergunte "Sigo com esse roteiro? Responde ok.":

| Cena | Do viral (s) | Fala | Na tela | Quadro do viral |
|---|---|---|---|---|

## 4. O reel inteiro (2ª parada de dinheiro)
- Cote antes com `get_cost: true`: 1 fala (`generate_voice` com o texto da maior fala; o preço é por tamanho do texto), 1 imagem de partida (`generate_image` no modelo e qualidade que vai usar), 1 cena no modelo de vídeo da vez, e a leitura do viral do passo 2. Com Avatar Pro não há fala pra cotar (soma a troca de voz, ~1 crédito por segundo). O Persona Pro só cota com áudio real: até ter a 1ª fala, use ~1,6 crédito por segundo de vídeo e diga que é estimativa; o Avatar Pro cota direto.
- Some: falas + imagens + vídeo (+ a troca de voz do reel inteiro, se `personagem.voz.troca_no_fim`: cote com `get_cost`, cobra por segundo) = previsto. O vídeo é a soma dos segundos de cada cena (a fala da cena no ritmo da voz, com pelo menos 5 s por cena) vezes o preço por segundo, não a maior cena vezes o número de cenas. **Máximo = previsto + folga pra refazer 1 cena** (imagem + vídeo de uma cena média).
- Mostre numa linha só e pergunte:
  "<N> cenas · <N> palavras · ~<N> s · fala ~<N> · imagens ~<N> · vídeo ~<N> = ~<N> créditos · o máximo que eu posso gastar, com folga pra refazer cena: <N> · saldo depois: ~<N>. Posso gastar até <N> créditos nesse reel? Responde sim."
- **Saldo comum (de `get_credits`) menor que o máximo:** não comece. `show_plans` e diga quanto falta. Saldo que cobre: não mostre planos.
- **Quem dá o sim:** nos 3 primeiros reels (`dinheiro.reels_com_sim` < 3), o sim é por reel. Depois, ofereça: "Quer me dar um máximo por dia? Aí eu rodo os reels do dia sem perguntar, dentro dele. Responde, por exemplo: sim, até 600 por dia." Com máximo por dia gravado (`dinheiro.maximo_por_dia`), some o gasto do dia (os `gasto` dos reels de hoje) e só pare se este reel passar do que sobra.
- Com o sim: grave `maximo`, `previsto`, some 1 em `reels_com_sim` e grave `passo: 5`. Daqui até o reel montado, você só para se passar do máximo ou se a mesma cena falhar duas vezes.
