# Fase 2: geração (passos 5 a 7)

**LÊ do estado:** `personagem.voz` (voiceId, palavras_por_segundo, tom_hz, clonada), `personagem.fotos_fixas`, `motores`, o reel atual (`maximo`, `gasto`, `tarefas`) e `roteiro.md` / `viral.md` da pasta do reel.
**GRAVA no estado:** em `cenas.NN` do reel (que diz de qual cena e, com `personagem_id`, de qual personagem), o taskId de cada fala, imagem, vídeo, upload do áudio e troca de voz, e a duração da fala, **na hora em que manda** (não no fim), o `gasto` e o `passo` do reel. Na pasta do reel: `falas/NN.mp3` + `falas/NN.json` (texto, duração, tempo de cada palavra, URL), `imagens/NN.png`, `cenas/NN.mp4` (só o vídeo final de cada cena), `avatar/NN.mp4` (o original do Avatar Pro, antes da troca de voz), `cenas/modelos.json` (qual modelo fez cada cena), `gasto.jsonl`.
**PRONTO QUANDO:** cada cena do roteiro tem um `cenas/NN.mp4` com a voz do personagem.

Sumário: Ordem e espera · 5. Fala primeiro · 6. Imagem de partida · 7. Vídeo no modelo da vez · Avatar Pro: trocar a voz · Gasto.

## Ordem e espera
**Com Persona Pro: fala → imagem → vídeo.** A fala fecha a duração do reel antes do gasto grande (o vídeo é a maior parte do custo). **Com Avatar Pro** (o modelo da vez quando não há voz da galeria no idioma do personagem): **imagem → vídeo → troca de voz**, sem gerar fala antes. A fala gerada não entraria no vídeo (o Avatar Pro fala o que está escrito no prompt) e sairia em outro idioma: a duração vem do número de palavras (passo 7). Antes de mandar qualquer coisa, olhe `cenas` do reel: o que já tem id não se manda de novo (`list_tasks` com os `taskIds` diz se está pronto, gerando ou falhou).
- Mande as gerações de um mesmo passo juntas, com `wait: false`, e grave cada taskId no estado assim que voltar.
- Espere em lote com `wait_for_tasks` (até 12 ids, 30 s por chamada) ou uma com `wait_for_task` (até 180 s por chamada). Cena de vídeo leva de 3 a 5 minutos: chame de novo até terminar. **Nunca gere de novo pra "tentar de novo".**

## 5. Fala primeiro, na voz salva (só Persona Pro)
- Uma fala por cena, de **5 a 8 s** (uma ideia por cena; o teto da ferramenta é 15 s, mas cena longa vira plano parado e deixa o reel lento): `generate_voice` com `text` (a fala da cena, como se fala, até 2000 caracteres) e **sempre** o `voiceId` do estado (a ferramenta não lê a voz da ficha; sem `voiceId` sai outra voz). `speed` fica 1 na 1ª tentativa.
- **A voz é a que o aluno escolheu e está no estado** (`personagem.voz.voiceId`). Se ela não aparece em `list_voices` ou a ferramenta recusa o id, PARE e diga isso ao aluno; nunca troque por outra voz "parecida" nem siga com a voz padrão.
- Baixe cada MP3 pra `falas/NN.mp3` na hora. Guarde em `falas/NN.json` a duração e o tempo de cada palavra que a resposta trouxe (servem pra conferir o ritmo, cortar e legendar).
- **Confira cada fala:**
  - Duração: alvo de 5 a 8 s; **acima de 15 s o Persona Pro recusa**. Passou de 8: divida em 2 cenas (cada uma com a sua imagem) e gere de novo só essas.
  - Tom: `python3 S/scripts/medir_voz.py reel falas/*.mp3` compara cada fala com a **mediana das falas do próprio reel** (a mesma voz varia de uma fala pra outra). Até 2,5 semitons passa; de 2,5 a 4 avisa (o aluno ouve na conferência); acima de 4, refaça só essa (até 2 vezes).
  - **Fala fora do tom se REGRAVA, nunca se edita.** Nada de baixar ou subir o tom, mudar a velocidade ou o timbre do MP3 em programa de áudio: fica outra voz e o aluno ouve. Gere outra tomada do mesmo texto e fique com a mais perto da mediana. Voz clonada varia mais de uma tomada pra outra: gere 2 e escolha.
  - **Antes de refazer mais devagar,** faça a conta: palavras ÷ (palavras por segundo × `speed`) tem que dar até 15 s. Passa: corte texto em vez de baixar o `speed`.
  - Texto: as palavras que voltaram com tempo batem com o texto mandado? Faltou ou sobrou palavra: refaça.
  - **Aperte as pausas antes do vídeo.** Fala gerada sai lenta pela pausa, não pela velocidade: 18 a 25% de silêncio, com 1 a 1,5 s entre frases, contra 7% num viral que fala 3 palavras por segundo. Em cada fala: `python3 S/scripts/apertar_pausas.py falas/NN.mp3 falas/NN-apertada.mp3 --json falas/NN.json` (silêncio de 0,42 s ou mais vira 0,28 s; o tempo das palavras é ajustado no json). Suba a apertada com `upload_file` (`purpose: reference`; no site, 1 arraste do aluno por fala) e pegue a URL em `list_uploads` na hora de mandar o vídeo (a URL assinada vence): é ela que vai como `audioUrl`, não a do `generate_voice`. Encurtar depois, na montagem, não conserta: o personagem já ficou parado no vídeo durante a pausa. Pausa que é do conteúdo (reza, suspense marcado no roteiro): não aperte essa fala.
  - Soma: as durações + 0,25 s por cena cabem no tamanho do roteiro (até 15% a mais que o viral)? Passou: gere de novo as falas mais longas com `speed` = duração ÷ alvo (0,7 a 1,2; não muda o preço) ou corte texto, e diga o que cortou. Nunca corte o gancho nem o fecho.
  - **Soma curta também reprova:** as durações somadas deram menos de 85% do viral? A voz está mais rápida que o roteiro previa. Regrave as falas com `speed` menor (até 0,7; não muda o preço) ANTES de gerar imagem e vídeo: fala custa pouco, vídeo em cima de fala corrida custa o reel.
- Linha pro aluno: "<N> falas · <N> s no total · <N> refeitas por tom".

## 6. Imagem de partida de cada cena
- **Uma imagem por cena, nunca 2 cenas da mesma imagem** (o plano repetido trava o reel).
- `generate_image`, `model: gpt-image-2.5-sunburst`, `quality: 1K`, `aspectRatio: 9:16` (~4 créditos cada). `referenceImages`, nesta ordem, em TODA cena:
  1. **o rosto do personagem** (a URL do rosto que `list_influencers` devolve, conferido no passo 1 da rodada);
  2. **o corpo** (a foto fixa do corpo, quando existe);
  3. o objeto (a foto fixa do objeto, em cena com ele).
  **O quadro do viral NÃO entra como referência**: o enquadramento, a posição do objeto e a câmera vão descritos em TEXTO, olhando o quadro (`viral/quadros/`). Referência do viral puxa o rosto da outra pessoa e o personagem muda de uma cena pra outra. Se precisar muito do quadro, ele entra por último, nunca em 1º.
  **O objeto do fecho (livro, produto, o objeto fixo da ficha) só entra na cena em que o roteiro põe ele**, como foto e como palavra. Nas outras cenas ele não vai em `referenceImages` nem é citado no prompt da imagem ou do vídeo, nem pra dizer que não aparece: o modelo desenha o que o prompt cita. Medido em 11/11: a capa citada em todas as cenas fez o vídeo inventar um livro falso em 2 delas, e refazer custou 23 créditos.
  O vídeo anima fielmente a imagem de partida: se o rosto muda no reel, o desvio nasceu na imagem. Por isso o portão abaixo é antes do vídeo.
- Prompt: S/references/prompts.md §Imagem de partida. O lugar vai em TEXTO (o da ficha), nunca como foto: referência de imagem arrasta o cenário junto.
- **A imagem já é o meio do gesto, com a mão ocupada.** Foto parada vira cabeça parada com zoom no vídeo.
- **Portão do rosto, antes de pagar o vídeo:** baixe todas pra `imagens/NN.png` e rode `python3 S/scripts/montar.py rostos fabrica/<p>/reels/<r>/imagens --ref <foto do rosto> --saida fabrica/<p>/reels/<r>/rostos-imagens.jpg`. Abra a folha: o rosto de referência (com borda) e o de cada cena **lado a lado**. Imagem que destoa (outro rosto, outra idade, outro bigode, outra cor de cabelo) é refeita antes do vídeo. Uma imagem conferida sozinha não mostra isso: a comparação é sempre lado a lado.
- Confira também, em cada imagem: mesmo enquadramento e mesmo objeto do quadro do viral? Vertical (`ffprobe`: altura maior que a largura)? Errado: refaça só essa imagem (conta no máximo). Nunca gere vídeo de imagem errada.

## 7. Vídeo no modelo da vez
O modelo da vez é o primeiro de `motores` que pode gerar agora. **Desce só quando o de cima não pode** (fora do ar: não aparece no `list_models`; ou a chamada voltou recusada). Nunca desce por demora nem por fila. Não guarda nada: na cena seguinte, tenta o 1º de novo.

**Persona Pro (1º):** recebe a imagem e a fala pronta e devolve o personagem falando com a voz da ficha.
- `generate_video` com: `model: avatrix-persona-pro`, `mode: audio_to_video`, `referenceImages`: a imagem de partida da cena como **1ª foto** (aceita de 1 a 9; se o rosto derivar numa cena, gere de novo somando a foto fixa do rosto como 2ª), `audioUrl`: a URL https da fala apertada (passo 5, saída de `list_uploads`; até 15 s), `prompt` (S/references/prompts.md §Vídeo Persona Pro), `aspectRatio: 9:16`, `resolution: 1080p`, `get_cost: true` antes, `wait: false`.
- A duração é a da fala; fala curta é cobrada como 5 s e a sobra a montagem corta.

**Avatar Pro (2º quando o Persona Pro não pode; 1º quando não há voz da galeria no idioma do personagem):** recebe 1 a 4 fotos e a fala escrita, e inventa a voz.
- `generate_video` com: `model: avatrix-avatar-pro`, `mode: ref_images`, `referenceImages`: a imagem de partida (1 foto basta), `prompt` com a fala escrita no idioma do personagem e a voz descrita (S/references/prompts.md §Vídeo Avatar Pro), `durationSeconds`: palavras da fala ÷ `palavras_por_segundo`, arredondado pra cima, de 5 a 15 (se o passo 5 rodou, a duração da fala), `aspectRatio: 9:16`, `resolution: 720p`, `get_cost: true` antes.
- Grave o resultado em `avatar/NN.mp4` (fora de `cenas/`: o script de montagem só junta `cenas/NN.mp4`).
- A voz sai mais aguda que a do personagem e às vezes troca uma palavra: **sempre troque a voz depois** (abaixo) e peça pro aluno ouvir essa cena antes de aprovar.
- **Personagem com voz clonada (`voz.clonada: true`): o Avatar Pro NÃO entra.** A troca de voz não aceita voz clonada. Pare e avise: "O modelo de vídeo principal está fora agora e o reserva não fala com a sua voz clonada. Tento de novo em alguns minutos, ok?"

## Avatar Pro: trocar a voz pela do personagem
A troca de voz só aceita áudio (MP3 ou WAV), não vídeo:
1. `ffmpeg -y -i avatar/NN.mp4 -vn -ac 1 -ar 44100 vozes/NN-original.wav`
2. Suba o WAV pra Avatrix com `upload_file` e `purpose: source_audio`:
   - **No Claude Code:** `filename`, `sha256` (`openssl dgst -sha256`) e `sizeBytes` (`wc -c`); faça o PUT na URL que voltar com os cabeçalhos como vieram; `confirm_upload` com `etag` e `fileId`.
   - **No site do Claude:** a ferramenta abre o cartão de upload; entregue o WAV na conversa e peça ao aluno UM arraste pro cartão (no site, cada cena do Avatar Pro pede 1 arraste a mais, além do arraste do reel pronto). Nunca invente sha256.
   - Grave o id do upload em `tarefas.upload_audio.NN` assim que voltar.
3. `change_voice` com `audio` = o id do upload e `voiceId` = o do estado (a voz que o aluno escolheu; recusada ou sumida da lista: pare e avise, nunca outra) (`get_cost: true` antes; cobra por segundo). Grave o taskId em `tarefas.troca_de_voz.NN` na hora. Na retomada, com upload e troca já gravados, não suba nem pague a troca de novo: `list_tasks` e baixe.
4. Baixe o MP3 e ponha no vídeo: `ffmpeg -y -i avatar/NN.mp4 -i vozes/NN-nova.mp3 -map 0:v -map 1:a -c:v copy -c:a aac -shortest cenas/NN.mp4`
5. O tom confere no passo 8, contra a mediana das cenas trocadas do reel: a troca mantém a entonação do vídeo original, então a mesma voz varia por cena, e isso não é defeito.
6. Depois da 1ª cena trocada, meça o ritmo dela (`medir_voz.py ritmo cenas/NN.mp4 "<fala>"`) e grave em `palavras_por_segundo`: vale pras próximas cenas.

## Gasto
- Depois de cada geração, some o custo no `gasto` do reel e uma linha em `gasto.jsonl` (`{"tipo","cena","tentativa","creditos","modelo","taskId"}`). O custo de verdade vem do `list_tasks` (créditos da tarefa).
- **A próxima chamada passaria do máximo? Pare e pergunte**, com quanto falta e por quê.
- **Persona Pro falhou em poucos segundos e "o provedor não disse o motivo"** (a geração é estornada): o defeito não é seu. Não troque a fala nem a imagem e não fique repetindo. Espere uns 10 minutos e mande a MESMA cena de novo, uma vez. Falhou de novo: pare e diga ao aluno "o Persona Pro está fora do ar agora; quer esperar ou seguir com o Avatar Pro (reserva)?". Não troque de modelo sem o sim dele.
- Mesma cena falhou duas vezes (erro na geração, ou reprovada duas vezes na conferência): pare e mostre as duas tentativas.
- Linha pro aluno no fim: "<N> cenas prontas · gastei <N> de <máximo> créditos nesse reel".
