# As 3 rodadas de crítica (valem em todo reel)

Reel bom é o que aguenta lado a lado com o viral. Quem escreveu não enxerga o próprio buraco, por isso a crítica é de outro olhar, em 3 momentos, e cada um acontece **antes** do gasto que ele protege: o roteiro antes do "sim" do reel, as falas antes de pagar o vídeo, o reel montado antes de mostrar ao aluno. Julgar texto custa zero; refazer vídeo custa o reel.

**Como rodar um crítico.** No Claude Code, um subagente por crítico, sem ver a sua opinião nem a dos outros, só com o material listado. No site do Claude (sem subagente), faça você mesmo, um crítico por vez, num bloco separado, lendo só o que aquele crítico recebe, como quem nunca viu o reel. Cada crítico responde: o que **mata** (tem de consertar antes de seguir), o que **não mata** (anota e segue) e uma nota de 0 a 10.

**Até 3 voltas por rodada.** Conserte só o que mata e rode de novo os críticos que apontaram. Passou quando nenhum aponta algo que mata e todos dão 7 ou mais. Depois da 3ª volta, o que sobrar vira pergunta pro aluno, com o seu conserto sugerido: mais voltas oscilam em vez de melhorar.

Grave cada rodada em `criticas.md` na pasta do reel (o crítico, o que apontou, o que foi feito) e marque no estado `criticas.roteiro`, `criticas.falas` ou `criticas.reel` como `true` quando ela passar. O carimbo é da versão: roteiro ou reel mudou, a crítica antiga não vale pra nova.

## Rodada 1: o roteiro (antes do "sim" do reel, 0 crédito)
Material: a tabela do roteiro, o `viral.md` (fala do viral com tempos, o que aparece em cada cena, o mecanismo e a casca) e a ficha do personagem.
- **Espectador frio** (só as falas do roteiro e o gancho escrito, sem o viral): em que fala passaria o dedo, e por quê? Entendeu nos 3 primeiros segundos o que vai ganhar se ficar? Alguma pergunta ficou sem resposta? Alguma frase só faz sentido pra quem viu o viral?
- **Fiel ao mecanismo** (roteiro + `viral.md`): o que prende no viral (o objeto do 1º quadro, a ordem, a virada, o fecho) está no roteiro, na mesma ordem e no mesmo tempo? Entrou algo que é casca (cor, música, enfeite) no lugar do que é mecanismo? A abertura conta **como** se faz antes da hora (aí o espectador já levou o que queria e sai)? O tamanho cabe no ritmo da voz?
- **Fala × imagem** (roteiro + coluna "Na tela"): alguma fala desmente o que a tela mostra? Algum número, prazo ou fato que o viral não tem e ninguém conferiu ("há mais de 10 anos", "90% das pessoas")? O gancho escrito e a fala usam a mesma palavra? A palavra pra comentar é a mesma na fala, no texto do fim e na legenda? O fecho entrega a oferta do tema deste vídeo?
Mata: pergunta sem resposta, mecanismo do viral que sumiu, fala que desmente a imagem, número inventado, palavra diferente entre fala e tela, fecho com produto de outro assunto, roteiro que não cabe no tempo.

## Rodada 2: as falas (antes de pagar o vídeo, só no Persona Pro)
Material: o texto de cada cena e o que voltou da fala (`falas/NN.json`, as palavras com tempo).
- **Integridade:** as palavras que voltaram batem com o texto mandado? 3 ou mais palavras seguidas faltando ou trocadas é fala comida: mata (refaça a fala, que é barata). Uma palavra solta diferente costuma ser só a leitura do tempo: não mata.
- **Respiro:** silêncio de mais de 2,5 s dentro da fala é ar morto (mata); pausa de 0,8 a 2,5 s marcada no roteiro (suspense, reza) fica, apertada pra uns 0,4 s; as outras já saem no passo de apertar pausas.
- **Pronúncia:** número, nome e palavra estrangeira saíram como se fala? Palavra com vogal aberta que a voz fechou: acento só no texto da voz, nunca na legenda.
Só depois desta rodada a fala vai pro vídeo.

## Rodada 3: o reel montado (antes de mostrar ao aluno)
Material: o `reel.mp4`, o `viral/viral.mp4`, 1 quadro de cada cena dos dois (os de `viral/quadros/` e 1 do meio de cada cena nossa; no site, mais que isso enche a conversa), a transcrição dos dois e a tabela viral × nosso: duração, trocas de cena por minuto (`ffmpeg ... select='gt(scene,0.2)'`), segundos sem fala, tempo até a 1ª virada e do fim da última fala até o fim.
- **Espectador frio** (só o nosso reel): em que segundo passaria o dedo? O quadro 0 se entende sem som? Parece vídeo de gente ou de IA estranha (boca que não bate, olhar parado na câmera, mão de boneco)?
- **Ritmo × viral** (os dois + a tabela): o que está mais lento ou mais vazio que o viral, com o segundo. A abertura (1 a 3 s) corre pelo menos tão rápido quanto o corpo? O fim sobra depois da palavra pra comentar?
- **Continuidade e texto na tela** (o nosso + a foto do rosto + a folha de rostos das cenas + `reel-textos.jpg`): o rosto, a roupa e o lugar batem em todas as cenas? Algum texto encosta no rosto, no chapéu baixo ou no título do objeto? Gancho, legenda e palavra pra comentar estão escritos certo e na faixa que o Instagram não cobre?
- **O quadro 0 à parte:** o crítico olha o vídeo andando e pula o primeiro quadro; tire o quadro 0 (`ffmpeg -i reel.mp4 -frames:v 1 q0.jpg`) e confira sozinho: é a capa que aparece no feed.
Conserte só o que mata, sem gastar quando der: primeiro cortes, ordem e texto (montar de novo), depois uma fala, por último uma cena (com o preço e o "sim").

Ao mostrar o reel ao aluno (`references/conferir-e-montar.md`, passo 10), junte numa linha o resultado: "3 rodadas de crítica: <N> consertos, nota final <menor nota>".
