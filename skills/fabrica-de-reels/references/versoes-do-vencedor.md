# Versões do vencedor ("faz versões desse reel que bombou")

Um reel do perfil foi bem acima dos outros (pelo menos 2 vezes a mediana de views dos últimos posts do mesmo perfil, medido no passo 15). Repostar o mesmo vídeo cansa quem já viu e a rede segura o alcance. A versão é um **reel novo que reaproveita o que fez o vencedor funcionar**, com outra roupa.

**Fica igual:** o tema, a receita (o que se faz e em que ordem), a promessa, o personagem e a palavra pra comentar (a mesma do vencedor: é o que liga a DM que já funciona).
**Troca junto, em cada versão:** (1) o **lugar** (o corpo do reel refeito em outro lugar do personagem, não só a 1ª cena); (2) a **forma de entrada**, o que se vê nos 3 primeiros segundos (o objeto na mão, o antes e depois, a ação no meio, o rosto de perto com a pergunta); (3) o **gancho**, falado e escrito. Duas versões nunca repetem a mesma entrada nem o mesmo gancho.

**De onde vêm entrada e gancho:** de outro viral real do mesmo tema (o aluno manda 2 ou 3 links, ou você acha com ele como em "Onde achar o viral", em `viral-e-roteiro.md`). Leia só os 3 primeiros segundos de cada um: o que aparece e o que é dito. Gancho inventado do zero não ensina nada e costuma sair morno.

## Passo a passo
1. Leia o vencedor: `roteiro.md`, `viral.md` e a medição dele (pasta do reel). Se a medição não mostra que ele ganhou, diga isso e pergunte se segue mesmo assim.
2. Quantas versões: sugira 2 (cada uma é um reel inteiro, com preço de reel).
3. Pra cada versão, escreva uma linha: lugar novo · entrada nova (de qual viral veio) · gancho novo (falado e escrito). Mostre e pergunte "ok".
4. Roteiro de cada versão = o do vencedor com a abertura e o lugar novos (passo 3 de `viral-e-roteiro.md`, mesmas regras de tamanho e ritmo). As frases do meio podem ficar iguais; a 1ª e a 2ª cena mudam.
5. **Cuidados que viram defeito numa versão** (todos entram na rodada 1 de `criticos.md`):
   - A crítica é da versão. A nota do vencedor não passa pra versão: cada uma faz as 3 rodadas.
   - A fala nova não desmente a imagem nova (dizer "a parede não mofa" com a parede mofada na tela), nem traz prazo ou número que o vencedor e o viral não têm.
   - O gancho falado e o escrito usam a mesma palavra (fala "energia", a tela não diz "entidade").
   - Se o vencedor começa como teste ("pra saber se a sua casa tem…"), a versão mantém a frase que diz que é teste; sem ela o passo parece a própria solução.
   - A família de gancho pedida não cabe no material (prova pessoal sem prova)? Troque a família; não cole uma frase na frente da abertura antiga.
   - A abertura nova corre pelo menos no ritmo do corpo: meça as duas com `python3 S/scripts/medir_voz.py ritmo` (mesma ferramenta pras duas, como na rodada 3 de `criticos.md`).
6. Siga a fábrica normal a partir do passo 4 (preço e "sim"), uma versão por vez.
7. **No post:** a legenda acompanha a abertura nova (o 1º parágrafo da legenda diz o gancho da versão, não o do vencedor). Trocar o vídeo de um post agendado é trocar vídeo e legenda juntos. Poste as versões com pelo menos 2 dias entre elas e entre elas e o vencedor.
8. **Medir:** cada versão contra a mediana do perfil (passo 15), anotando no `estado.json` de qual vencedor ela é (`"versao_de": "<pasta do vencedor>"`). A entrada que ganhar vira a preferida nos próximos reels do mesmo tema.
