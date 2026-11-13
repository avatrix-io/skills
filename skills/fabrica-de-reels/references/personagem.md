# Fase 0: criar o personagem (passos A a F)

**LÊ do estado:** nada (ou `personagem.id` e `personagem.passo` se já começou).
**GRAVA no estado:** `personagem` inteiro (id, nome, marcas, objeto, lugar, fotos_fixas, voz), o `passo` a cada passo feito, e `pronto: true` no fim.
**PRONTO QUANDO:** o rosto está salvo e conferido, a ficha tem o idioma, a voz está salva e medida (palavras por segundo) e a ordem dos modelos de vídeo está gravada pro idioma dela.

Sumário: A. Entender o que veio · B. Desmontar a referência · C. Ficha e a régua do raso · D. 3 rostos (ou a foto do aluno) · E. Salvar, ficha, fotos fixas e voz · F. Prova · Custo.

Roda uma vez por personagem. Depois, toda rodada começa direto no reel.

## A. Entender o que o aluno trouxe (0 crédito)
- **Trouxe referência** (perfil, reel ou foto): você modela a referência (passo B).
- **Só descreveu** ("quero uma manicure de salão que ensina a cuidar da unha em casa"): monte a ficha pelo pedido (passo C) com as perguntas de 3 sugestões. Avise uma vez: "Se você me mandar o link de 1 a 3 reels de alguém desse tipo que está dando view, eu modelo e o personagem costuma sair mais forte." Não trave esperando o link.
- **Já tem personagem salvo:** `list_influencers` e `get_influencer`. Leia a ficha e a prontidão; complete só o que está vazio (passos C a F do que faltar). Nunca gere rosto novo pra quem já existe.
- **Personagem novo numa conta que já tem outros:** não use a ficha de outro personagem da conta como molde sem perguntar ("Quer que eu parta da ficha da <outro>, ou começo do zero?"). E respeite o que o aluno já disse (idioma, país, marcas, roupa): sugestão nunca contradiz isso; se ele disse bigode preto e espanhol do México, as 3 sugestões partem daí.

## B. Desmontar a referência, com prova
- Não há ferramenta que liste os posts de um perfil. Peça ao aluno **até 3 links de reel** desse perfil (os que ele viu com mais views).
- Leia 1 pelo caminho pago, com o preço dito antes: `download_social` (o preço que a cotação devolver; o mesmo link não cobra de novo em 24 h) e quadros com ffmpeg, ou a leitura do agente "Clonar Vídeo" (S/references/viral-e-roteiro.md, passo 2). Os outros 2 só com "sim". Prints que o aluno mandar são de graça.
- Separe em 2 colunas e **cada item vem com o quadro ou a frase de onde saiu**:
  - **O que prende (copia):** o tipo (quem é), a marca (o que não muda), o jeito (como olha, como se mexe), o lugar e a câmera, a voz (ritmo, bordão), o porquê (por que o público para pra ouvir essa pessoa) e o inimigo (contra o que ela fala).
  - **O que troca:** o rosto e o nome. Sempre.
- **O rosto é sempre novo.** Copia tipo e mecanismo, nunca a cara de uma pessoa real. Foto de pessoa de verdade só se for do próprio aluno, com autorização dele (regra da Avatrix).
- Grave em `fabrica/<personagem>/desmontagem.md` a tabela "item → o que a referência faz → de onde saiu (quadro ou frase)".

## C. A ficha e a régua do raso (0 crédito)
Preencha as 6 linhas, mais o inimigo, o bordão e a palavra pra comentar:

| O que confere | Raso (recusa) | Do jeito certo |
|---|---|---|
| Quem é, numa linha | "criadora de conteúdo de bem-estar" | "manicure de 54 anos de salão de bairro em Belo Horizonte que ensina a cuidar da unha em casa" |
| Por que alguém para pra ouvir | personagem sorteado, sem motivo | um tipo que o público reconhece + um porquê + um inimigo |
| Marca que não muda | "mulher bonita de blusa de tricô" | 3 traços fixos e um objeto: unha vermelha curta, avental florido, óculos na ponta do nariz; a maleta de esmalte |
| Jeito | parada, dura, pose de catálogo | "olhar de quem sabe um segredo", gravando selfie, mão sempre ocupada |
| Lugar e câmera | estúdio bonito, luz dourada | a mesinha do salão, celular apoiado no vidro de acetona, luz do dia |
| Voz | "voz feminina" | escrita em mecânica (S/references/prompts.md §Voz): altura, textura, ritmo, fim de frase, sotaque por cidade, bordão |

(Dona Cida é um exemplo inventado, só pra mostrar o formato.)

**A régua, dura:**
- Recuse "quem é" que cabe em mil perfis: precisa de **ofício concreto + idade + recorte (cidade, bairro ou classe) + um inimigo**.
- Palavra de julgamento ("de sucesso", "moderno", "bonita", "simpática", "estranho", "chamativo", "viral", "lifestyle") não conta como marca, jeito nem lugar: recuse e peça a versão em coisa que se vê ou se ouve ("pinta acima do lábio", "fala baixo e rápido").
- Teste: troque o nome por "uma influencer qualquer". Se o "quem é" e o "por que para pra ouvir" continuam valendo, é raso: refaça antes de mostrar.

**Como a régua se aplica (4 pedidos):**
- "Sofia, 25, criadora de conteúdo de lifestyle, bonita, simpática": **recusa.** Sem ofício, sem recorte, sem inimigo; "lifestyle", "bonita" e "simpática" são julgamento. Pergunte o ofício e de onde ela é, com 3 sugestões.
- "Carlos, empresário de sucesso, terno, escritório moderno": **recusa.** "De sucesso" e "moderno" são julgamento; "empresário" cabe em mil perfis. Peça o que ele vende, pra quem, e contra o quê.
- "Personagem bem estranho e chamativo, cabelo roxo, viral": **recusa.** Só tem visual; "estranho", "chamativo" e "viral" não viram imagem. Peça o ofício, o porquê e o inimigo.
- "Vó Tereza, 70, cozinheira": **não recusa, está incompleta.** Tem ofício e idade; faltam recorte, inimigo, marca e lugar: vão pras perguntas com 3 sugestões cada.

- **O que o aluno não disse, você não inventa.** Pergunte numa rodada só, com 3 sugestões pra cada coisa: "Contra o que ela é? (1) esmalteria cara (2) produto de farmácia (3) dica de internet que estraga a unha". O mesmo pro bordão e pra palavra pra comentar (curta, que dá vontade de comentar, sem ser palavra de venda).
- Mostre a ficha e peça "ok". Nada foi gasto até aqui.

## D. 3 rostos diferentes, o aluno escolhe (10 créditos cada)
- **O aluno tem foto própria pra ser o rosto** (dele mesmo, com autorização): `upload_file` com `purpose: avatar` e `create_influencer` com o `fileId`, de graça. Pule os 3 rostos.
- `generate_influencer` com `get_cost: true` antes: "3 rostos, ~30 créditos. Posso gerar? Responde sim."
- Dimensões do construtor (ids de `list_presets`; nunca texto livre nelas) e o detalhe solto em `appearance`, em fisiologia. **`oficio`, `roupa` e `lugar` são as que mais tiram a cara de manequim.**
- **Idade acima de 60:** o construtor aceita `idade` de 18 a 60. Pra vô ou vó, parta do preset `vo-caipira` ou `vo-cozinheira` e mude só o que precisa; ou use `idade: 60` + `appearance` com a fisiologia ("cabelo branco ralo, rugas fundas na testa, manchas de idade nas mãos"). Se `list_presets` não trouxer esses dois, use `idade: 60` + `appearance` com a fisiologia.
- **3 opções de verdade, não 3 variações da mesma:** mude etnia, cabelo, corpo ou idade entre elas, sempre dentro da ficha. Pele com poro e marca, sem filtro.
- Mostre as 3 lado a lado. Não descarte nenhuma pelo seu gosto. Não gostou de nenhuma: o aluno diz o que mudar e você gera mais uma, com o preço dito antes.
- Sem frase negativa no `appearance` (negação desenha o que nega: "sem chapéu" gera chapéu).

## E. Salvar, ficha, fotos fixas e voz
1. **Salvar o rosto escolhido:** `create_influencer` com o `taskId` do `generate_influencer` já concluído (de graça; não aceita URL). Teto de 20 personagens por conta: cheio, avise; nunca apague personagem do aluno.
2. **Gravar a ficha:** `update_influencer` com `id` (obrigatório) e os 4 blocos (de graça; ele funde; **lista substitui a inteira**, então mande a lista completa). Tetos de cada campo:
   - `identidade`: nome (60), umaLinha (160), nicho (80), publico (160). Mande `name` junto com `identidade.nome`.
   - `imagem`: rosto (200), corpo, figurino, cenarios (até 5, 100 cada), luz, luzProibida (até 3, 60 cada), camera.
   - `voz`: timbreRitmo (200), sotaque (120), bordao (60), proibidosDeFala (até 5, 80 cada), idioma, vozDaGaleria (o voiceId; não existe campo voiceId).
   - `estrategia`: vilao (120), propAncora (o objeto, 120), palavraCta (30), regras (até 5, 100 cada).
   O bloco escrito da voz (S/references/prompts.md §Voz) não cabe num campo só: altura, textura, ritmo e fim de frase vão em `timbreRitmo`; a mecânica do sotaque e a cidade vão em `sotaque`. Campo não decidido fica de fora. Proibições nunca entram no prompt de imagem.
3. **Fotos fixas, sob demanda** (`generate_image` com `model: gpt-image-2.5-sunburst` e `quality: 1K`, ~4 créditos cada; sem `model` cai no padrão de ~18; preço antes). O rosto salvo já é a referência de toda cena; as outras 3 (corpo inteiro com o figurino, no lugar dele, com o objeto) só são geradas quando a 1ª cena que precisa delas aparecer no roteiro (o corpo pra cena de corpo, o objeto pra cena com o objeto). Não são passo obrigatório antes do 1º reel. Todas com a URL do rosto (de `list_influencers`) em `referenceImages`. Modelos: S/references/prompts.md §Fotos fixas. Rosto que derivou não entra: refaça (preço antes). **Grave o taskId de cada uma** em `personagem.fotos_fixas` (o taskId vale em `referenceImages` e deixa rastro em `list_tasks`).
4. **A voz, o aluno escolhe ouvindo.** `list_voices` com uma palavra só, o idioma da ficha (`query: "português"`, `"espanhol"`, `"inglês"`); a lista não traz amostra nem tom.
   - **Tem voz no idioma da ficha:** escolha 3 que batem com a ficha (gênero, idade, jeito), gere a mesma frase nas 3 com `generate_voice` passando o `voiceId` de cada uma (preço antes; ~2 créditos cada), meça o tom de cada amostra (`python3 S/scripts/medir_voz.py tom amostra.mp3`) e mostre "voz X, <N> Hz (mais grave/mais aguda)". O aluno escolhe ouvindo. Ordem dos modelos de vídeo: Persona Pro, depois Avatar Pro.
   - **Não tem voz no idioma da ficha** (a galeria hoje é quase toda em português e inglês): o modelo de vídeo da vez é o **Avatar Pro**, e diga por quê ao aluno: "O Persona Pro fala com a voz do áudio que eu mando, e não há voz no seu idioma pra gerar esse áudio. O Avatar Pro fala no idioma do roteiro, e depois eu troco a voz pela do personagem, que fica sempre igual." Aqui a voz da galeria entra só como timbre da troca: escolha 3 de timbre parecido com a ficha (idioma não importa), mostre as amostras com o tom medido e o aluno escolhe. Grave `motores: ["avatrix-avatar-pro"]` no estado.
   - **Voz que o aluno traz de fora** (gravada por ele ou feita em outro serviço de voz, que não está na galeria): a fala de cada cena é gerada fora, passa pelo `apertar_pausas.py` (S/references/geracao.md, passo 5), sobe com `upload_file` (`purpose: reference`) e entra como `audioUrl` do Persona Pro. Escreva em `timbreRitmo` "voz de fora: <onde é gerada>", pra conversa nova saber. Ouça o nome do personagem e os nomes próprios na 1ª fala: voz clonada costuma errar nome; saiu errado, escreva o nome como se fala e ouça de novo.
   - **Voz fixa por troca:** se a ficha diz que a voz entra por troca por cima da atuação, ou se a voz escolhida lendo o texto sai fora do tom que o aluno quer, grave `personagem.voz.troca_no_fim: true` e o tom de referência em `tom_hz`, e escreva em `timbreRitmo` "voz por troca no fim". A montagem passa o reel inteiro pela troca (S/references/conferir-e-montar.md, passo 9.4). Não troque por outra voz da galeria.
   - Grave em `update_influencer` `voz.vozDaGaleria` e `voz.idioma`, e em `personagem.voz` do estado. Quer favoritar: `save_voice`.
   - **Voz clonada:** a conexão não cria clone. Se o aluno criou a própria voz no site da Avatrix, ela aparece em `list_voices` como voz salva da conta; peça o nome dela, use o `voiceId` que a lista mostrar e grave `voz.clonada: true`. Com voz clonada o Avatar Pro não entra (S/references/geracao.md).

## F. Prova: é sempre a mesma pessoa (~10 créditos)
- Rosto que veio da foto do aluno: a prova são as imagens de partida do 1º reel (o rosto é conferido nelas, S/references/geracao.md, passo 6). Pule as 2 imagens.
- Rosto gerado: **2 imagens** bem diferentes (outro lugar, outro ângulo, figurino da ficha) com a mesma referência de rosto. Compare com a foto fixa do rosto: mesma pessoa? Não passou: a referência ou o prompt estão arrastando cenário (o rosto vai como imagem, o lugar vai em texto). Mostre onde mudou; não siga.
- **Ritmo:** com voz no idioma (Persona Pro), uma fala de teste do tamanho de uma cena, uns 6 a 8 s (frase curta engana o ritmo), na voz escolhida (`generate_voice` com o `voiceId`, sempre: ela não lê a voz da ficha). Da duração e do tempo de cada palavra, calcule as **palavras por segundo** e grave em `palavras_por_segundo`. Sem voz no idioma (Avatar Pro): grave 2,3 palavras por segundo (fala pausada) até medir a 1ª cena trocada, e aí troque pelo medido. O tom (`tom_hz`) fica só como registro: a régua do tom é a mediana das cenas do próprio reel (S/references/conferir-e-montar.md).
- **O rosto salvo no personagem e as fotos fixas são a MESMA pessoa?** Ponha lado a lado (`python3 S/scripts/montar.py rostos <pasta das fotos fixas> --ref <rosto salvo> --saida rostos-fixas.jpg`) e olhe. Não são (outra idade, outro bigode, outro cabelo): pare e pergunte ao aluno qual vale, sem gastar; o que valer vira a referência de toda imagem.
- Passou: `pronto: true` e diga numa linha: "Personagem <Nome> pronto · rosto conferido · voz salva (fala <N> palavras por segundo) · vídeo pelo <modelo> · gastei <N> créditos, uma vez só · pode mandar o primeiro viral".

## Custo (estimativa; a cotação manda)
3 rostos ~30 + amostras de voz ~6 + prova ~10 + fala de ritmo ~3 = **~50 créditos**, uma vez (com a foto do próprio aluno, ~10). Fotos fixas extras, quando a cena pedir: ~4 cada. Sempre a cotação na frente do aluno, nunca este número.
