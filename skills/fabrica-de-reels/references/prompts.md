# Modelos de prompt

Sumário: Regras · §Voz (bloco escrito) · §Fotos fixas · §Imagem de partida · §Vídeo Persona Pro · §Vídeo Avatar Pro.

Na ficha, o bloco §Voz se divide: altura, textura, ritmo, volume e fim de frase em `timbreRitmo` (até 200 caracteres); a mecânica do sotaque e a cidade em `sotaque` (até 120).

## Regras que valem em todo prompt
- Prompt de imagem e vídeo em inglês; a fala no idioma do personagem, entre `<d>[<Idioma>] ... </d>`.
- **Idioma, sotaque e país saem da ficha** (`voz.idioma`), nunca fixos. `<Idioma>` / `<nacionalidade>` / `<idioma em chinês>` por ficha: pt-BR = Portuguese / Brazilian / 巴西葡萄牙语 · es-MX = Spanish / Mexican / 墨西哥西班牙语 · es-ES = Spanish / Spanish (from Spain) / 西班牙西班牙语 · en-US = English / American / 美式英语. Vale pra imagem, vídeo, roteiro, legenda e a palavra pra comentar.
- **A string de identidade** (as 3 marcas + o figurino, em substantivos: "short red nails, flowered apron, reading glasses on the tip of the nose") entra palavra por palavra em todo prompt do personagem.
- Emoção como o que o corpo faz ("smile with the mouth only, eyebrows raised"), nunca adjetivo ("happy", "angry").
- Luz com fonte e lugar ("soft overcast daylight from the window on the right"). Nunca "cinematic", "8K", "beautiful", "perfect": não rendem.
- **Sem negação do que você não quer na cena, na imagem E no vídeo**: negação desenha o substantivo. Afirme o quadro limpo ("clean frame"). No vídeo vale igual pro rosto: "does not laugh, no wide smile" saiu com sorriso largo; "lips rest together, relaxed" diminuiu o sorriso. Descreva o que a boca e o rosto FAZEM. A única lista de "no" que funciona é a de texto e marca no fim ("No captions, no subtitles, no watermark, no logo").
- **Só entra no prompt o que está naquela cena.** O "Prop na mão" e o objeto fixo da ficha (livro, produto) vão só na cena do fecho que o roteiro marcou. Em `<Subject 2>` do vídeo, liste só os objetos que estão em `<Picture 1>`.
- Proibições da ficha (luz proibida, palavras proibidas, regras) nunca entram no prompt de imagem.

## §Voz (bloco escrito, pra ficha e pro Avatar Pro)
Escreva a voz em mecânica, pelo menos 5 destas 6: altura (grave, sentada no peito), textura (rouca, limpa, gasta na borda), ritmo (sem pressa, em rajadas curtas), volume (nunca levanta a voz, sobe só em [palavra]), fim de frase (cai no fim e fica lá; fala de anúncio sobe, fala de gente cai) e sotaque pela boca e por uma CIDADE do país do personagem, nunca só "voz brasileira" ou "voz mexicana" (R enrolado pra trás no fim da sílaba; S chiado; T antes de I chiando). Nenhuma palavra de emoção (feliz, brava, empolgada).
> Exemplo: "Voz de mulher de 54 anos, média pra grave, gasta na borda. Sem pressa, as palavras se amontoam quando conta um erro que viu. Toda afirmação cai no fim e fica lá. Sotaque de Belo Horizonte: R do fim da sílaba enrolado pra trás, vogal átona final fechada, come o fim das palavras ('cê põe', 'ocê')."

## §Fotos fixas (generate_image, `model: gpt-image-2.5-sunburst`, `quality: 1K`, 9:16, rosto em referenceImages)
Sempre mande `model` e `quality`: sem eles a Avatrix usa o modelo padrão, que custa ~18 créditos por foto em vez de ~4. Vale também pras 2 imagens da prova.
```
Raw vertical 9:16 phone photo of the same <idade> <nacionalidade> <who> from the face reference: <string de identidade>, <figurino>. <QUADRO>. Natural matte skin with real pores and small marks, no beautification. <luz da ficha>. Clean frame, no text.
```
Os 4 quadros (`<QUADRO>`):
1. Rosto: "Head and shoulders, facing the camera, neutral mouth, plain light grey wall behind".
2. Corpo: "Full body standing, arms relaxed, plain light grey wall behind, feet visible".
3. No lugar: "Waist-up in <lugar da ficha>, <ação do ofício no meio do gesto>, eyes on <o que ela faz>".
4. Com o objeto: "Chest-up holding <o objeto> toward the lens with both hands, <lugar da ficha> softly behind".

## §Imagem de partida (generate_image, gpt-image-2.5-sunburst, 1K, 9:16)
`referenceImages` = [rosto do personagem, corpo, objeto]. O quadro do viral não entra como referência: o enquadramento, a câmera e a posição do objeto vão descritos em texto, olhando o quadro. Molde:
```
The person is the <who> from reference image 1 (face) with the body of reference image 2: <idade>, <string de identidade>, <figurino>. Keep the face exactly as in reference image 1. Place: <lugar da ficha, 1 frase concreta com 3 ou 4 objetos e a luz>. Framing, copied from the source shot: <enquadramento e altura da câmera do quadro do viral, ex.: chest-up shot from slightly above, centered>, <onde está o objeto no quadro>. <O que as mãos fazem, no meio do gesto, com o objeto do viral descrito de verdade (material, cor, tamanho)>. <Para onde olha>, mouth open mid-sentence. Hands well formed with five fingers each. Raw vertical 9:16 phone photo, natural flat daylight, everything in focus, real skin texture, no studio gloss. No captions, no subtitles, no watermark, no logo, no flag.
```
Cena que no viral não tem gente: "<who> holds <o objeto> in front of the chest, <o objeto> fills the lower half of the frame".

## §Vídeo Persona Pro (generate_video, avatrix-persona-pro, audio_to_video)
Formato em 6 blocos (é o que faz o modelo manter rosto, lugar e a fala do áudio):
```
subject_definitions:
<Subject 1> is the <who> in <Picture 1> (<Nome>): <idade>, <string de identidade>, <figurino>.
<Subject 2> is the <lugar> in <Picture 1>: <3 ou 4 objetos do lugar>.
<Picture 1> is the first frame of [Shot 1].
<Audio 1> is the complete speech track of <Subject 1> (S1) and is reused as the final audio.

summary:
[keyframe completion + reference generation + audio reuse] The target video is one handheld shot of <Subject 1> in <Subject 2> starting from <Picture 1>, speaking the line carried by <Audio 1>.

retention_analysis:
<Subject 1> (appears in [Shot 1]): fully_preserved - facial identity, <marcas> and clothes stay exactly the same for the whole shot.
<Subject 2> (appears in [Shot 1]): fully_preserved - the place, the props and the light stay frozen, with no invented elements.
<Picture 1> ([Shot 1] first frame): fully_preserved - the shot starts from this exact frame.
<Audio 1>: fully_copy - <Audio 1> is reused 1:1 as the target video's complete final audio track.

detailed_description:
The target video has a raw, realistic phone-camera look with natural daylight, real skin texture and no studio gloss. The phone is held by a relative standing in front of <him|her>, with a slight natural handheld sway and no cuts.
[Shot 1] <Enquadramento>. <Subject 1> <a ação da cena em 3 ou 4 batidas que acompanham a fala: "on '<palavra>' <he|she> lifts the <objeto>; on '<palavra>' <he|she> taps it; ...">, while <he|she> keeps talking to the lens. On the last line <he|she> points at the lens. <Subject 1> (S1) says with natural synchronized mouth movement, in the exact voice and timing of <Audio 1>, <d>[<Idioma>] <a fala, igual ao texto do áudio>.</d> After the last word <he|she> closes <his|her> mouth and keeps the action going in silence until the end of the shot. There is no readable text in the frame. Hands are well formed with five fingers each. No subtitles, no captions, no watermark.

overall_soundscape:
The quiet room tone copied from <Audio 1> continues throughout; no added sounds.

non_diegetic_music:
N/A
```
Por que câmera na mão e ação em batidas: em teste, a câmera parada no tripé, com a ação descrita de uma vez só, saiu devagar, monótona e com cara de IA. Passou com a câmera na mão de um parente, balançando de leve, o gesto com o objeto marcado em 3 ou 4 palavras da fala e o fecho apontando pra lente. Se o viral é claramente gravado com o celular apoiado, siga o viral, mas mantenha as batidas.

## §Vídeo Avatar Pro (generate_video, avatrix-avatar-pro, ref_images)
A fala vai escrita no prompt; a voz é descrita uma vez, igual em todas as cenas (o modelo inventa a voz, e a troca de voz depois põe a do personagem). As instruções vão neste formato; a fala fica no idioma do personagem:
```
<Subject1><Nome>是<Picture 1>中<who em chinês: idade, string de identidade, figurino>，保留参考图中的面部特征、身材比例以及整体外貌。
<Subject1>，S1 始终使用一种固定的声音：<o bloco §Voz, traduzido>；从头到尾同一个音调。只说<idioma em chinês>。

场景、构图、道具位置和光线与<Picture 1>完全一致：<o lugar>。固定机位，三脚架，镜头完全不动，不切镜头，背景不变。

[Shot 1]
<enquadramento e a ação da cena, com o objeto>，边做边说：
<Subject 1> (S1) says:
<d>[<Idioma>]<a fala></d>

【禁止项】
字幕/UI/水印/Logo/角标

【强制声明】
无背景音乐，仅保留环境音与人声；台词只说一遍，不重复任何词，说完闭嘴继续动作；双手正常，每只手五根手指。
```
