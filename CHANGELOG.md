# Changelog

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
