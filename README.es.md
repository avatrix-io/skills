# Skills de Avatrix para Claude

[Português](README.md) · **Español** · [English](README.en.md)

Una skill que hace que Claude cree una novela con IA en tu cuenta de [Avatrix](https://avatrix.io), del link de un video viral hasta una temporada de 3 a 5 partes, armada parte por parte, con los diálogos en español. Te muestra el precio antes y solo gasta créditos después de que respondas "sí".

| Skill | Qué hace | Tú escribes | Tú recibes |
|---|---|---|---|
| **novelinha** | Hace una novela corta con IA: serie vertical, por partes, con los mismos personajes. En español, inglés o portugués. | "haz una novelinha" + el link de una novela que se esté haciendo viral | La temporada de 3 a 5 partes esbozada, el guion para aprobar, los personajes creados en tu cuenta y cada parte armada en mp4, una a la vez |

La otra skill del repositorio, **fabrica-de-reels**, por ahora solo funciona en portugués: el mensaje de instalación y los pasos están en el [README en portugués](README.md#instalar-copie-uma-mensagem-e-cole-no-claude).

## Qué necesitas
- **Claude**: el sitio [claude.ai](https://claude.ai), la app en modo conversación o Claude Code (en la terminal).
- **Una cuenta en Avatrix** con créditos.

## Instalar: copia un mensaje y pégalo en Claude

El mismo mensaje sirve en Claude Code y en el sitio o la app de Claude. Abre Claude (en Claude Code, en la carpeta donde quieres trabajar) y pega:

```text
Instálame la skill novelinha de Avatrix. Los pasos están en https://raw.githubusercontent.com/avatrix-io/skills/main/INSTALL.md: léelo y síguelo. En Claude Code, hazlo todo tú. En el sitio o la app de Claude, guíame en los clics, uno a la vez: descargar https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip, cargarlo en Configuración > Plugins (o Personalizar > Habilidades en la pantalla antigua) y añadir el conector de Avatrix con la URL https://avatrix.io/mcp. Al final, dime qué escribo para empezar.
```

En Claude Code, Claude descarga, instala, conecta Avatrix y te dice qué escribir. En el sitio, te guía clic por clic. Tú solo entras a tu cuenta de Avatrix cuando te lo pida. No pide contraseña. Lo que hace con el mensaje está en el [INSTALL.md](INSTALL.md) (en portugués; Claude lo lee igual).

¿Prefieres hacerlo tú? Los clics están aquí abajo.

### En el sitio o en la app de Claude (sin terminal)
1. Descarga el archivo de la skill: [novelinha.zip](https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip).
2. En Claude, ve a tu nombre > Configuración > Plugins > Añadir, elige la opción de subir un plugin y el zip, sin descomprimirlo (pantalla antigua: Personalizar > Habilidades > + > Crear habilidad > Cargar una habilidad).
3. Conecta Avatrix en Plugins > Añadir > Añadir conector personalizado (pantalla antigua: Personalizar > Conectores > + Añadir > Añadir conector personalizado): nombre `Avatrix`, URL `https://avatrix.io/mcp`. Sigue con Continuar hasta Añadir y entra a tu cuenta de Avatrix.
4. Abre una conversación nueva y escribe "haz una novelinha".

El paso a paso completo, con el ajuste de red que la skill necesita, está en [COMO-INSTALAR.es.md](skills/novelinha/COMO-INSTALAR.es.md).

Los nombres de los botones son los de la ayuda de Claude en español (noviembre de 2026). Si en tu pantalla aparecen con otro nombre, usa el que ves.

### O a mano, en la terminal
Abre la terminal en la carpeta del proyecto (por ejemplo `mis-novelas`) y ejecuta:

```bash
claude plugin marketplace add avatrix-io/skills
claude plugin install novelinha@avatrix-skills --scope project
```

Después conecta Avatrix (`claude mcp add --transport http avatrix https://avatrix.io/mcp` y, dentro de Claude Code, `/mcp` > avatrix > login) e instala ffmpeg (`brew install ffmpeg` en Mac, `winget install ffmpeg` en Windows). El candado del "sí" ya viene activado con el plugin.

## Idioma de la novela
La skill te responde en el idioma en que le escribes. Si escribes en español, la novela sale en español: los diálogos, la voz, el país de los personajes (mexicanos, si no dices otro), las hashtags y el título. ¿Quieres otro país o la novela en otro idioma? Díselo al empezar ("la novela en español de Colombia", "la novela en inglés"). El idioma queda fijo para toda la serie.

## Actualizar
- **Claude Code:** cuando sale una versión nueva, aparece una línea al inicio de la sesión con el comando: `claude plugin update novelinha@avatrix-skills`. Después abre Claude Code de nuevo.
- **Sitio de Claude:** la skill avisa al inicio de la conversación, cuando la conversación tiene acceso a la web. Para actualizar, descarga el zip de nuevo (link de arriba) y súbelo en lugar del anterior en Configuración > Plugins (pantalla antigua: Personalizar > Habilidades).

## Preguntas frecuentes
**¿Cuánto cuesta?** La skill cotiza cada generación en Avatrix y te muestra el precio en créditos antes. Sin tu "sí", no genera nada.

**¿Necesito saber programar?** No. En Claude Code pegas el mensaje y él hace el resto; en el sitio de Claude todo es con clics.

**La skill dijo que Avatrix no respondió.** El conector no está activado o entraste con otra cuenta. Repite el paso 3 (sitio) o el `/mcp` (Claude Code).

**Se detuvo a la mitad.** Escribe "novelinha continúa" en la misma conversación. En una conversación nueva, pega la ficha que la skill muestra al final de cada etapa.

**¿Qué cambia en cada versión?** Está en el [CHANGELOG](CHANGELOG.md) (en portugués).

## Quién la hizo
Avatrix: [avatrix.io](https://avatrix.io).
