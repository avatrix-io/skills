# Changelog

## fabrica-de-reels 0.5.0
- **A voz fica guardada na ficha do personagem.** Toda fala sai da Avatrix na voz que o aluno escolheu, lida da ficha, igual em todo reel. Quem vem da versão anterior: antes do próximo reel, a skill confere a voz na ficha (não cobra).
- **Uma fala por frase, juntadas por cena.** Cada frase do roteiro vira uma fala, em lotes de até 12 (no site, um "Permitir uma vez" vale pelo lote inteiro), e as falas de cada cena se juntam na própria Avatrix com a pausa certa entre elas (juntar não cobra). Só a frase que sai errada se refaz, que é barata; nunca a cena inteira.
- **A fala se confere antes de pagar o vídeo**, com o `scripts/conferir_fala.py` novo: o texto (número por extenso, sem símbolo nem palavra toda em maiúscula, cena de até 15 s), cada cena antes de juntar (frase sem voz, ar morto, pedaço que a voz pulou), o reel inteiro contra o tamanho e o ritmo do viral, e cada cena que volta do vídeo (fala comida refaz a cena com o mesmo áudio; voz a mais depois da última palavra: o conferidor dá o trecho pro corte da montagem).
- **No ritmo de fala do viral.** A skill mede as palavras por segundo do viral e da voz do personagem e acerta o speed da voz pra o reel falar o mesmo tanto que o viral, no mesmo tempo (entre 85% e 115% dele).
- **Reserva com a mesma voz.** Quando o Persona Pro não pode, o Avatar Pro recebe a mesma fala juntada: a voz e o tempo saem iguais, sem troca de voz e sem arrastar arquivo.
- **Dois caminhos com troca de voz, que no site pedem arraste:** o personagem sem voz no idioma dele (o Avatar Pro fala o roteiro e a voz do personagem entra por troca, 1 arraste por cena, com a 1ª cena medida antes das outras) e a voz fixada por troca no fim (o reel montado e conferido passa uma vez pela troca, 1 arraste).
- **A voz do próprio aluno**, clonada no site da Avatrix (Criar personagem > Clonagem completa), com o passo a passo pra pôr essa voz num personagem que já existe.
- **O 1º quadro copia o do viral:** a imagem do gancho parte do quadro 0 do viral como referência.
- **2ª pessoa no quadro do viral:** vira um personagem salvo da conta (só reagindo, ou em diálogo, cada um na voz da ficha dele), ou a cena fica só com o personagem. O aluno escolhe.
- **O pedido do meio é um teste:** os reels alternam com e sem "Comenta <PALAVRA> que eu te mando" na tela, no meio do vídeo. Com 3 reels de cada jeito medidos, ganha o jeito que tirou pelo menos 20% a mais de comentário por view; diferença menor, o pedido do meio sai.
- **A legenda sai do tempo de cada palavra** que a voz devolve, sem tempo escrito à mão.
- A montagem grava os trechos que usou de cada cena e a legenda no tempo do reel, pra conferir o ritmo da abertura e cortar à mão sem conta.
- A pausa de propósito (reza, suspense) se protege na montagem em todo reel, não só no reel curto.
- O máximo por dia vale no dia em que foi dado e cobre também a leitura do viral; no dia seguinte, a skill pergunta de novo.
- **Trava do sim:** mensagem com pergunta não abre o gasto, e um "sim" depois não encurta a janela do máximo do dia. O gasto do dia fica somado no estado.
- **Medição mais justa:** só com 24 h completas, contra a mediana dos últimos 10 posts medidos do perfil; leitura vazia não conta como medida; reel com o dobro da mediana ganha a oferta de 2 versões.
- A frase do curso sai uma vez por personagem, não a cada conversa.
- **Conversa nova retoma certo:** a ficha do reel leva o tema, o perfil, o comando da montagem, o reel já subido e as marcas da voz; "fabrica continua" só retoma reel ainda não agendado.
- **Crítica com verificador:** cada "mata" dos críticos vem com a prova e passa por um verificador antes do conserto; o que ele não confirma não se conserta.
- **Moldes novos** em `references/prompts.md`: diálogo, vídeo do Avatar Pro com a fala e a imagem do gancho.
- **Personagem ainda sem oferta:** o fecho entrega algo curto do tema de graça, na DM, e a DM liga sem botão até ter o link.
- **Fotos fixas sob demanda:** o corpo e o objeto só são gerados quando o roteiro pede, dentro do máximo do reel.
- **Ficha do reel completa** no site do Claude: com as frases, o máximo, o gasto e o teste do pedido do meio, uma conversa nova retoma o reel do passo em que parou, sem pagar de novo o que já está pronto.
- **O modelo de reserva só entra quando o de cima não pode gerar**; recusa por causa do pedido se conserta no mesmo modelo.
- Saíram o `apertar_pausas.py` (a montagem já encolhe as pausas) e a medida de ritmo do `medir_voz.py` (a régua do ritmo agora é uma só, a do `conferir_fala.py`).

## novelinha 1.8.0
A skill passa a seguir o método que a fábrica de novelinhas da Avatrix usa hoje (16 a 24/11/2026). O detalhe e a fonte de cada regra estão em `references/metodo-atual.md`.
- **Cabeçalho do SKILL.md corrigido:** a descrição vai entre aspas. Sem elas, o texto com dois-pontos no meio quebrava o cabeçalho e o Claude podia não carregar a skill (vinha da 1.7.1).
- **Fiel ou adaptado:** quando o viral tem as próximas partes no ar, a nossa Parte k copia a Parte k dele cena a cena (mesma ordem de falas e viradas, mesma duração ±10%, mesmo número de partes), trocando só elenco, lugar e jeito de falar. Sem continuação no ar: a mesma virada, humilhação e desforra numa história nossa de 3 partes.
- **Temporada de 3 partes por padrão** (até 5 no fiel). Parte 2 na mesma noite da Parte 1 e Parte 3 no dia seguinte.
- **Régua da Parte 1,** medida nas partes que escalaram contra a que caiu: 1ª fala em até 0,5 s com o vilão humilhando a vítima na cara, pelo menos 8 falas de desprezo, pelo menos 5 viradas, um segredo a favor da vítima antes do fim, o vilão confiante e errado na última fala, e quem entra no meio sem saber de nada.
- **Gente e roupa:** lugar com gente leva o público no prompt, no vídeo e no som; troca de roupa escrita inteira e repetida dali em diante; roupa nunca vai na lista de objetos.
- **Leitor frio com duas notas** (`entender` e `quer_p2`, as duas em 8 ou mais), até 4 leituras, com conserto só nas cenas que ele citou.
- **Fim e legenda como os virais** (27 novelinhas medidas, de 3 a 17/11): a parte que continua fecha com "CONTINUA..." e "Comenta PARTE N" por cima do último segundo, com o último quadro parado, sem tela preta; a última parte fecha com o protagonista pedindo pra seguir; legenda "Parte N | título" e comentário fixado. A regra antiga que proibia "comenta PARTE 2" saiu. A parte nunca é prometida por direct.
- **Fundo de estúdio:** conferência, em cada plano, de que atrás das pessoas aparece o lugar, e não o fundo cinza liso da ficha.
- **Persona Pro na prática:** o take volta a 24 qps, até 8 vídeos na fila (o 9º volta erro sem cobrar) e take curto cobra o mínimo.
- **`scripts/montar.py` novo:** fim por cima da cena (`--fim continua|segue|cartela|nenhum`, `--parte`, `--idioma`), @ do perfil no canto (`--arroba`), -15 LUFS, ruído bem baixo contra buraco de silêncio, portões no fim (sai com erro se o volume ou o silêncio reprovar) e a versão limpa da parte, sem o fim, pro YouTube. Converte o take de 24 qps pelo tempo.
- **Tudo dentro da Avatrix:** saiu o caminho econômico pelo Google Flow (e a extensão do Chrome que ele pedia) e o acabamento no CapCut. Imagem, voz, vídeo, montagem e post acontecem na Avatrix e na própria conversa.
- **`scripts/longo.py` e fase 8 (novo):** o longo do YouTube da série fechada, em 16:9 com a parte no meio e ela mesma desfocada dos lados, sem cartela entre as partes, 6 s finais pedindo "Comenta PARTE 2" e inscrição, capítulos prontos pra descrição, e o modelo de título, descrição e comentário fixado.

## fabrica-de-reels 0.4.0
- **3 rodadas de crítica em todo reel**, cada uma antes do gasto que ela protege: o roteiro antes do "sim" do reel, as falas antes de pagar o vídeo e o reel montado antes de te mostrar. Em cada rodada, 3 críticos independentes (no Claude Code, subagentes; no site, o Claude faz um por vez); até 3 voltas, consertando só o que mata. Fica tudo em `criticas.md`, na pasta do reel. Regras em `references/criticos.md`.
- **Mecanismo ou casca:** antes do roteiro, a skill separa o que faz o viral prender (sai do vídeo, ele para de funcionar) do que é só enfeite. O roteiro copia o mecanismo, no mesmo lugar e no mesmo tempo, e não copia a casca nem o produto do outro.
- **A abertura não entrega o como:** os 3 primeiros segundos mostram o que a pessoa ganha ou o problema; o ingrediente, o passo ou o nome do método ficam pro meio.
- **A fala não desmente a imagem** e não inventa número, prazo nem fato que o viral não tem. O gancho escrito usa a mesma palavra que o personagem fala.
- **Fala comida:** 3 ou mais palavras seguidas faltando na fala gerada refaz a fala antes do vídeo (a fala é barata; o vídeo não).
- **O quadro 0 à parte** (é a capa no feed) e o ritmo da abertura medido contra o do resto do reel.
- **Versões do vencedor:** "faz versões desse reel que bombou" faz reels novos a partir de um que foi bem acima da média do perfil, trocando juntos o lugar, o que se vê nos 3 primeiros segundos e o gancho (tirados de outro viral real do mesmo tema), com a mesma receita e a mesma palavra pra comentar. Regras em `references/versoes-do-vencedor.md`.

## Instalação por mensagem, também no site do Claude
- A mensagem pronta pra colar agora serve no Claude Code e no site ou no app do Claude. No Claude Code ele instala sozinho; no site, ele lê o passo a passo e te guia clique por clique (baixar o zip, subir a skill, ligar a Avatrix e liberar a internet que ela precisa).

## novelinha 1.7.1
- Novela em espanhol e em inglês, além do português (que continua o padrão). A skill conversa no idioma em que você escreve e grava o idioma da série no `estado.json` (`pt`, `es` ou `en`): a fala, a voz, o país dos personagens, as hashtags, a legenda e o "PART 2?" do fim saem no idioma escolhido. Tudo o que muda de um idioma pro outro está em `references/idioma.md`. Em conversa em espanhol ou inglês, a skill não fala do curso (ele é em português).
- A trava do "sim" no Claude Code aceita "sí" e "yes" (e "si" sozinho ou "si," no começo da resposta). "Si quieres...", "me gusta" e "nice" não liberam gasto. Teste em `tests/test_trava_sim.sh`.
- README e COMO-INSTALAR em espanhol e em inglês, com a instalação por mensagem pronta.
- A ficha do personagem descreve o sapato e a barra da roupa (sai de corpo inteiro), com um detalhe único por personagem e um acento de cor só na série.
- Personagem que está na cena mas fora das fotos ganha uma linha nas travas do pedido: onde ele está (fora do quadro) e que ninguém mais aparece.
- O crítico do clipe conta as pessoas em cada plano aberto (o modelo às vezes duplica alguém) e, quando o close sai aberto, recorta na montagem em vez de gastar de novo.
- Palavra com vogal aberta que a voz fecha: acento só no texto da voz, legenda com a grafia normal.
- A legenda do post não entrega a última fala da parte.
- Som: fundo contínuo bem baixo por lugar, pra o som não sumir entre cenas, e volume igualado fala por fala sem vazar pro fim da peça.
- O zip confere o tamanho da descrição da skill (o site do Claude recusa acima de 1024 caracteres).

## novelinha 1.7.0
- A novelinha agora pensa na temporada inteira: antes da Parte 1, ela esboça de 3 a 5 partes, e o gancho do fim de uma é o começo da próxima.
- Antes de gastar crédito, ela escreve a história e te mostra pra aprovar: quem é quem, o golpe, cena por cena. Só depois gera.
- Guarda o que já aconteceu na série e os erros que você reprovou, pra não repetir nas próximas partes.
- Cenas emendam melhor (quem estava onde, com qual objeto), o som passa de uma cena pra outra e a partir da Parte 2 cada parte abre com um resumo de 2 a 3 segundos.
- Confere o rosto de cada personagem plano a plano contra a foto dele e refaz o clipe quando não bate.
- Mostra quanto cada parte gastou de verdade.

## Instalação por mensagem
- A primeira forma de instalar agora é colar uma mensagem pronta no Claude Code: ele baixa, instala, liga a Avatrix e te diz o que digitar. O zip continua pro site do Claude.

## novelinha 1.6.2
- Conserto da trava do "sim" no Claude Code: quando a pasta do projeto ainda não tinha a pasta `.claude`, o "sim" não ficava gravado e toda geração era bloqueada. Agora a trava cria a pasta sozinha. Nada muda pra quem já usava.

## novelinha 1.6.1 · fabrica-de-reels 0.3.9 (primeira versão pública)
- As duas skills viram plugins do Claude Code: instalação por comando e atualização pelo próprio Claude Code.
- Aviso de versão nova: no Claude Code, uma linha no começo da sessão; no site do Claude, a skill confere a versão publicada uma vez por conversa, quando tem acesso à web.
- No Claude Code, a trava do "sim" vem ligada pelo plugin.
- Zip de cada skill pronto pra subir no site do Claude, na página de versões (Releases).
- Nova `references/proximo-passo.md` em cada skill: o texto do próximo passo (o curso) num lugar só.
