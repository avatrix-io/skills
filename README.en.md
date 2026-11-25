# Avatrix skills for Claude

[Português](README.md) · [Español](README.es.md) · **English**

A skill that has Claude make an AI micro drama in your [Avatrix](https://avatrix.io) account, from the link of a viral video to a season of 3 to 5 parts, edited one part at a time, with the dialogue in English. It shows you the price first and only spends credits after you reply "yes".

| Skill | What it does | You type | You get |
|---|---|---|---|
| **novelinha** | Makes a short AI drama: a vertical series, in parts, with the same characters. In English, Spanish or Portuguese. | "make a novelinha" + the link to a micro drama that's going viral | The 3-to-5-part season sketched, the script to approve, the characters created in your account and each part edited as an mp4, one at a time |

The other skill in this repository, **fabrica-de-reels**, only works in Portuguese for now: the install message and the steps are in the [Portuguese README](README.md#instalar-copie-uma-mensagem-e-cole-no-claude).

## What you need
- **Claude**: the [claude.ai](https://claude.ai) website, the app in chat mode, or Claude Code (in the terminal).
- **An Avatrix account** with credits.

## Install: copy a message and paste it into Claude

The same message works in Claude Code and on the Claude website or app. Open Claude (in Claude Code, in the folder where you want to work) and paste:

```text
Install the Avatrix novelinha skill for me. The steps are at https://raw.githubusercontent.com/avatrix-io/skills/main/INSTALL.md: read and follow them. In Claude Code, do everything yourself. On the Claude website or app, walk me through the clicks one at a time: download https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip, upload it in Settings > Plugins (or Customize > Skills on the old screen) and add the Avatrix connector with the URL https://avatrix.io/mcp. When you finish, tell me what to type to start.
```

In Claude Code, Claude downloads it, installs it, connects Avatrix and tells you what to type. On the website, it walks you through each click. You only sign in to your Avatrix account when it asks. It never asks for your password. What it does with the message is in [INSTALL.md](INSTALL.md) (in Portuguese; Claude reads it all the same).

Rather do it yourself? The clicks are below.

### On the Claude website or app (no terminal)
1. Download the skill file: [novelinha.zip](https://github.com/avatrix-io/skills/releases/latest/download/novelinha.zip).
2. In Claude, go to your name > Settings > Plugins > Add, pick the option to upload a plugin and choose the zip, without unzipping it (old screen: Customize > Skills > + > Create skill > Upload a skill).
3. Connect Avatrix in Plugins > Add > Add custom connector (old screen: Customize > Connectors > + Add > Add custom connector): name `Avatrix`, URL `https://avatrix.io/mcp`. Click Continue until Add and sign in to your Avatrix account.
4. Open a new chat and type "make a novelinha".

The full step-by-step, with the network setting the skill needs, is in [COMO-INSTALAR.en.md](skills/novelinha/COMO-INSTALAR.en.md).

Button names are the ones in Claude's help center (November 2026). If your screen shows a different name, use the one you see.

### Or by hand, in the terminal
Open the terminal in your project folder (for example `my-dramas`) and run:

```bash
claude plugin marketplace add avatrix-io/skills
claude plugin install novelinha@avatrix-skills --scope project
```

Then connect Avatrix (`claude mcp add --transport http avatrix https://avatrix.io/mcp` and, inside Claude Code, `/mcp` > avatrix > login) and install ffmpeg (`brew install ffmpeg` on Mac, `winget install ffmpeg` on Windows). The "yes" lock comes already on with the plugin.

## Language of the drama
The skill answers in the language you write in. Write in English and the drama comes out in English: the dialogue, the voices, the characters' country (American, unless you say otherwise), the hashtags and the title. Want another country or another language for the drama? Say it at the start ("make it British", "the drama in Spanish"). The language stays the same for the whole series.

## Update
- **Claude Code:** when a new version is out, a line shows up at the start of the session with the command: `claude plugin update novelinha@avatrix-skills`. Then open Claude Code again.
- **Claude website:** the skill tells you at the start of the chat, when the chat has web access. To update, download the zip again (link above) and upload it in place of the old one in Settings > Plugins (old screen: Customize > Skills).

## FAQ
**How much does it cost?** The skill quotes every generation on Avatrix and shows you the price in credits first. Without your "yes", it generates nothing.

**Do I need to know how to code?** No. In Claude Code you paste the message and it does the rest; on the Claude website it's all clicking.

**The skill said Avatrix didn't respond.** The connector isn't on, or you signed in with another account. Redo step 3 (website) or `/mcp` (Claude Code).

**It stopped halfway.** Type "novelinha continue" in the same chat. In a new chat, paste the sheet the skill shows at the end of each stage.

**What changes in each version?** It's in the [CHANGELOG](CHANGELOG.md) (in Portuguese).

## Who made it
Avatrix: [avatrix.io](https://avatrix.io).
