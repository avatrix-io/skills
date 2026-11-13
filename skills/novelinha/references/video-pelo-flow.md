# Clipes pelo Flow

Arquivo de apoio da skill `novelinha`, Fase 4, caminho B. O Flow (flow.google.com) gasta o crédito do Google do aluno (plano Google AI), não o da Avatrix. Na Avatrix ficam só a foto do 1º quadro de cada clipe e a troca de voz. É o caminho mais barato e o mais demorado: cada clipe passa pelo navegador, um por vez.

## 1. A foto do 1º quadro (na Avatrix)
Igual ao caminho A: `generate_image` com a foto de cada personagem em `referenceImages` (S/references/prompts.md §Foto) e a conferência da Regra 4. Salve como `novelinha/<serie>/flow/NN-inicio.png`.

## 2. O prompt de cada clipe
O mesmo do §Vídeo de S/references/prompts.md, com a fala em português entre aspas. No Flow, a imagem de partida já carrega rosto e cenário: do clipe 2 em diante, não descreva de novo o rosto nem o fundo, só a ação, os planos e as falas. Tudo num arquivo, `novelinha/<serie>/ROTEIRO-FLOW.md`, um bloco por clipe:

**CLIPE 03** · salve como `03.mp4` · 8 s · imagem `03-inicio.png`
```
<o prompt do clipe>
```

## 3. Gerar no Flow pelo navegador
Com a extensão Claude in Chrome ligada (S/COMO-INSTALAR.md, passo 5), a skill faz sozinha, numa aba nova:
1. Abre flow.google.com e cria um projeto novo (o aluno loga com a conta Google dele; a skill nunca digita senha).
2. Sobe as imagens de partida.
3. Configura: Vídeo · Frames · 9:16 · o modelo que fala (Veo 3.1 ou o Omni, o que o Flow mostrar com áudio) · 8 s · **x1** (o padrão x2 gasta o dobro).
4. Pra cada clipe: escolhe a imagem em "Início", cola o prompt, gera, espera, baixa e salva em `novelinha/<serie>/clipes/NN.mp4`.
5. Mostra cada clipe ao aluno antes do próximo.

Se um botão não responder 2 vezes, ou o Flow mudar de cara, a skill para e passa pro modo manual (§4). Nunca fica tentando.

## 4. Modo manual (o aluno clica)
Mande a lista do §3 como passos, com o prompt de cada clipe pra copiar. O aluno salva cada vídeo com o nome do bloco em `novelinha/<serie>/clipes/` e escreve "pronto".

## 5. Conferir
- Um arquivo por clipe, com o nome certo.
- `ffprobe -v error -show_entries stream=codec_type,width,height:format=duration -of csv=p=0 clipes/03.mp4`: tem que ter vídeo e áudio, altura maior que a largura e a duração perto da pedida.
- O Veo erra pronúncia em português (tutorial de 05/11: "manipula"). Palavra quebrada: escreva separada ou troque por outra e gere de novo.
- Rosto diferente da foto: gere de novo. Depois segue igual ao caminho A: conferência (Fase 5) e montagem (Fase 6).
- O Flow faz clipes de 8 s e o roteiro pede 9 a 12 s: no roteiro do caminho B, escreva cada clipe com 8 s e no máximo 2 falas (a Parte 1 fica com 1 ou 2 clipes a mais).
