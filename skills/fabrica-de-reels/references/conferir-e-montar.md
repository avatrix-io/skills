# Fase 3: conferir, montar e entregar (passos 8 a 10)

**LÊ do estado:** o reel atual (`maximo`, `gasto`, `previsto`, `palavra`, `cenas`), `personagem` (fotos_fixas, voz); na pasta do reel: `cenas/`, `falas/`, `imagens/`, `viral/`, `roteiro.md`.
**GRAVA no estado:** `passo` e `gasto` do reel (e o taskId de cena refeita, na hora). Na pasta do reel: `conferencia.md`, `legendas.json`, `reel.mp4`, `ficha-postagem.md`.
**PRONTO QUANDO:** o reel passou na rodada 3 de crítica (S/references/criticos.md) e o aluno viu o reel e o viral e aprovou ("ok").

## 8. Conferir cada cena e refazer só o que mata o reel (0 crédito, salvo refação)
**Pelo som** (medido, não no olho), em cada `cenas/NN.mp4`:
- Tom: `python3 S/scripts/medir_voz.py reel cenas/*.mp4` compara cada cena com a **mediana das cenas do próprio reel** (a mesma voz varia por cena: comparar com uma fala de teste reprova cena boa). Até 2,5 semitons passa; de 2,5 a 4 avisa (o aluno ouve essa cena); acima de 4 mata. No Persona Pro o som é cópia da fala: se a fala passou no passo 5, a cena passa.
- Fala: no Persona Pro o som é a nossa fala; confira que a duração do som (`ffprobe`) bate com a de `falas/NN.json` (diferença maior que 0,3 s: a fala foi comida ou esticada; mata). No Avatar Pro a fala foi inventada e pode trocar palavra: **o aluno ouve essa cena** antes de aprovar.

**Pelos quadros** (só rosto e lugar):
- **Folha de rostos das cenas, lado a lado:** `python3 S/scripts/montar.py rostos fabrica/<p>/reels/<r>/cenas --ref <foto do rosto> --saida fabrica/<p>/reels/<r>/rostos-cenas.jpg` (1 quadro do meio de cada cena ao lado do rosto de referência). Cena com outro rosto é a que mata; uma cena olhada sozinha não mostra o desvio.
- Em cada cena, tire 3 quadros (início, meio, fim: `ffmpeg -ss <t> -i cenas/NN.mp4 -frames:v 1 conferir/NN-a.jpg`) e olhe ao lado do quadro do viral da mesma cena.
- Mata: outra pessoa (o rosto mudou), alguém a mais na cena, outro lugar (o cenário trocou no meio).
- Não mata (detalhe): objeto que muda um pouco de lugar, anel que aparece e some, tempero mais grosso, mão no meio do movimento.

- Reprovada: refaça uma vez (a imagem, se o erro veio dela; senão só o vídeo), com o custo somado ao gasto. Falhou de novo: pare e mostre as duas tentativas.
- Grave em `conferencia.md` uma linha por cena: passou, ou o que matou e o que foi refeito.
- Linha pro aluno: "<N> de <N> cenas aprovadas · voz dentro do tom em todas · <N> refeitas".

## 9. Montar o reel (passo fixo, 0 crédito)
1. **Legenda:** monte com `python3 S/scripts/montar.py legendas fabrica/<p>/reels/<r>/cenas falas.json --saida legendas.json`. O `falas.json` leva, por cena:
   - **Persona Pro:** as palavras com o tempo que a fala devolveu (`{"palavras": [{"texto", "de", "ate"}], "desloc": 0}`). `desloc` = quanto somar pra cair no tempo do vídeo: o atraso de entrada do vídeo em relação ao MP3 (compare o 1º som dos dois), ou negativo quando a cena é um pedaço do meio de uma fala maior (menos o ponto do corte).
   - **Avatar Pro** (sem tempo por palavra): só o texto (`{"texto": "..."}`). O script acha os trechos com som da cena e espalha os blocos por eles, na proporção das letras de cada bloco. É aproximado (pode escorregar uns 0,5 s dentro da frase): olhe a emenda.
   - Blocos de 1 a 3 palavras que **nunca terminam em palavra de ligação** ("e", "de", "o", "a", "que", "y", "el"...): ela passa pro bloco seguinte. O script já faz isso.
2. **Gancho escrito** (o do roteiro, **até 18 letras por linha, no máximo 2 linhas**; o script recusa acima disso e diz o porquê; pra 2 linhas de propósito, quebre com `\n`: "Unha fraca\nque descasca") nos 3 primeiros segundos e **a palavra pra comentar escrita** no fim ("Comenta <PALAVRA>"): a mesma falada e a mesma da legenda do post.
3. **Escolha a posição do gancho e da palavra pra comentar olhando os quadros** (não há posição padrão; o script recusa montar sem `--gancho-y` e `--cta-y`). Tire 5 quadros dos 3 primeiros segundos e 5 dos 3 últimos e veja onde ficam o rosto e o objeto. **Texto NUNCA em cima do rosto**: chapéu ou boina baixa conta como rosto, e o título do livro ou do objeto também não se tampa. Onde costuma caber: no peito ou na roupa; na cena em que o personagem segura o objeto no peito, na parte de baixo do objeto (nunca no título). Rode:
   ```
   python3 S/scripts/montar.py fabrica/<p>/reels/<r>/cenas --legendas fabrica/<p>/reels/<r>/legendas.json --gancho "<gancho>" --gancho-y <px> --cta "Comenta <PALAVRA>" --cta-y <px> --saida fabrica/<p>/reels/<r>/reel.mp4
   ```
   **Depois de montar, abra a folha `reel-textos.jpg`** que o script gera (5 quadros do começo e 5 do fim, com os textos). Encostou no rosto, no chapéu baixo ou no título em QUALQUER quadro: mude o y e monte de novo. Só mostre ao aluno depois disso.
   O script junta só os arquivos `NN.mp4` de `cenas/`, em ordem numérica. Em cada cena ele **mede o som do próprio vídeo** (não o texto: corte pelo texto come palavra) e: começa um instante antes da 1ª palavra, termina logo depois da última e **encolhe pausa maior que 0,4 s pra 0,24 s**, cortando só o miolo do silêncio. A legenda acompanha os cortes. Deixa todas as cenas no mesmo volume e sai em 1080x1920. Cena que precisa de corte à mão: `--cortes` com os trechos.
   - **Ritmo igual ao do viral.** Monte, veja a duração e compare com a do viral: se o nosso ficou mais longo, monte de novo com `--ritmo <nossa duração ÷ duração do viral>`, no máximo `1.15` (acelera som e imagem juntos, sem mudar o tom). Reel lento, com pausa larga, perde gente no meio.
   - **Ficou mais curto que 85% do viral?** Não acelere nem aceite: a pausa do conteúdo foi comida ou a fala está corrida. Reel com reza, ritual ou fala pausada: monte com `--pausa-max 1.2` (mantém pausa de até 1,2 s em vez de encolher tudo acima de 0,4 s). Continua curto: o defeito está nas falas (S/references/geracao.md, passo 5, `speed`), e a montagem não conserta.
   - **Texto só na área que o Instagram não cobre.** Num reel 1080x1920 a barra de cima cobre até uns 270 px e o nome do perfil, a legenda do post e o áudio cobrem de 1340 px pra baixo; os botões ficam na coluna da direita. O script recusa texto fora da faixa de 270 a 1340 px. Posições (centro do texto, em px): `--gancho-y` e `--cta-y` (sem padrão: você escolhe olhando os quadros) e `--legenda-y` (padrão 1210).
   - **Estilo do texto.** Gancho e palavra pra comentar saem em letra amarela com contorno preto (`--estilo amarelo`, o padrão). `--estilo caixa` (caixa branca, letra preta) só quando o aluno pedir ou quando o viral usa caixa. Não troque o estilo de um reel pro outro do mesmo personagem sem o aluno pedir. A legenda é sempre branca com contorno, em blocos curtos e sem pontuação.
   - **Um quadro só não basta:** o personagem se mexe; por isso 5 do começo e 5 do fim.
   - **Sem faixa livre:** nunca o rosto, o chapéu baixo nem o título. O que pode ceder, nesta ordem: 1º a roupa ou o peito; 2º o cabelo ou o alto de um chapéu alto (que não encosta na testa); por último a parte de baixo do objeto, a menos importante.
4. **Voz por troca no fim** (só quando `personagem.voz.troca_no_fim` é `true`): a voz do personagem entra por cima do reel montado (a voz lendo o texto costuma sair fora do tom do personagem; depois da troca fica no tom, com a mesma sincronia e o mesmo texto).
   - `ffmpeg -y -i reel.mp4 -vn -ac 1 -ar 44100 vozes/reel-original.wav`; suba com `upload_file` (`purpose: source_audio`; no site, 1 arraste do aluno) e grave o id em `troca_final.upload_audio` do reel.
   - `change_voice` com `audio` = esse id e `voiceId` = `personagem.voz.voiceId` (`get_cost: true` antes; já entrou no máximo do reel). Grave o taskId em `troca_final.troca_de_voz` na hora. Na retomada, com os dois gravados, não suba nem pague de novo: `list_tasks` e baixe.
   - Volte a voz pro vídeo, com +5 dB (a troca sai uns 6 dB mais baixa): `ffmpeg -y -i reel.mp4 -i vozes/reel-nova.mp3 -map 0:v -map 1:a -c:v copy -af volume=5dB -c:a aac -shortest reel-voz.mp4`, e daqui em diante o reel é o `reel-voz.mp4`.
   - Confira: `python3 S/scripts/medir_voz.py tom reel-voz.mp4 --ref <personagem.voz.tom_hz>` dentro de 1,5 semitom, e ouça uma vez: o texto tem de ser o mesmo.
5. Assista o reel inteiro antes de mostrar: é na emenda que aparece o que uma cena sozinha esconde (palavra cortada, pulo de volume, gancho em cima do rosto).
6. **Rodada 3 de crítica** (S/references/criticos.md): a tabela viral × nosso, os 3 críticos, o quadro 0 à parte e o ritmo da abertura contra o do corpo (corte os 3 primeiros segundos com `ffmpeg -t 3` e o resto com `ffmpeg -ss 3`, e meça os dois com `python3 S/scripts/medir_voz.py ritmo <trecho> "<as palavras que caem nele, de legendas.json>"`). Abertura mais lenta que o corpo mata: aperte ou corte a 1ª cena e monte de novo. Conserte o que mata e grave em `criticas.md`.

## 10. Entregar pra olhar
- **Os dois vídeos na conversa:** o viral (`viral/viral.mp4`) e o reel (`reel.mp4`), um depois do outro, pra ouvir e ver. No site do Claude, os dois como arquivo pra baixar; no Claude Code, abra os dois no player do computador.
- **A conta:** gasto de verdade contra o previsto, parte por parte ("fala <N> · imagens <N> · vídeo <N> = <N> de <máximo>").
- **Ficha de postagem** (`ficha-postagem.md`): legenda, gancho, a palavra pra comentar, primeiro comentário por rede, título do YouTube, texto da DM e o botão. Como escrever: S/references/postar-dm-medir.md, passo 12.
- Linha pro aluno: "Reel pronto: <N> s (o viral tem <N>) · <N> cenas · 3 rodadas de crítica, <N> consertos · gastei <N> de <máximo> créditos · palavra pra comentar: <PALAVRA>. Aprova? Responde ok que eu sigo pra postagem."
- Aprovado: grave a palavra em `palavras_usadas` e siga pra S/references/postar-dm-medir.md. Se é o primeiro reel aprovado nesta conversa, antes de seguir: a frase de S/references/proximo-passo.md §Frase depois do primeiro resultado, uma vez só, com as regras de lá. Pediu mudança: conserte primeiro sem gastar (cortes, legenda, gancho, ordem); só por último refaça cena (com o preço dito e "sim").
