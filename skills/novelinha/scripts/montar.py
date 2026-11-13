#!/usr/bin/env python3
"""Junta os clipes da novelinha na ordem (01.mp4, 02.mp4...) com corte seco, deixa todos no mesmo volume
e fecha com "PARTE 2?" escrito letra a letra numa tela preta.

Uso: python3 montar.py <pasta-dos-clipes> --saida parte-1.mp4 [--cortes cortes.json] [--texto "PARTE 2?"] [--segundos 1.5]
     python3 montar.py --teste
cortes.json (opcional) = os trechos que FICAM de cada clipe, em segundos: {"03": [[2.0, 2.9], [6.2, 9.5]], "07": [[2.0, 9.0]]}.
Clipe que não aparece no cortes.json entra inteiro. Use pra tirar plano parado sem fala e fala que o vídeo inventou.
Precisa de ffmpeg no PATH. Todos os clipes viram 720x1280, 30 fps, AAC 44,1 kHz antes de juntar.
"""
import argparse, json, pathlib, re, shutil, subprocess, sys, tempfile

ALVO_LUFS = -16.0  # volume igual em todos os clipes (ganho fixo por clipe, sem compressor que achata a fala)


def cmd(*a):
    r = subprocess.run(a, capture_output=True, text=True)
    if r.returncode:
        sys.exit(f"ffmpeg falhou: {' '.join(a[:6])}...\n{r.stderr[-800:]}")
    return r


def tem_audio(arquivo):
    r = subprocess.run(["ffprobe", "-v", "error", "-select_streams", "a", "-show_entries", "stream=index", "-of", "csv=p=0", str(arquivo)],
                       capture_output=True, text=True)
    return bool(r.stdout.strip())


def duracao(arquivo):
    r = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", str(arquivo)],
                       capture_output=True, text=True)
    return float(r.stdout.strip())


def volume(arquivo):
    r = subprocess.run(["ffmpeg", "-nostats", "-i", str(arquivo), "-af", "ebur128", "-f", "null", "-"], capture_output=True, text=True)
    achou = re.findall(r"I:\s+(-?[\d.]+) LUFS", r.stderr)
    return float(achou[-1]) if achou else None


def normalizar(entrada, saida, trechos=None):
    """padroniza tamanho/fps/som, corta os trechos pedidos e iguala o volume."""
    if tem_audio(entrada):
        entradas, a_in = ["-i", str(entrada)], "[0:a]"
    else:  # clipe mudo: silêncio do mesmo tamanho, pra o concat não desalinhar o som
        entradas, a_in = ["-i", str(entrada), "-f", "lavfi", "-t", str(duracao(entrada)), "-i", "anullsrc=r=44100:cl=stereo"], "[1:a]"
    trechos = trechos or [[0, duracao(entrada)]]
    f = []
    for i, (ini, fim) in enumerate(trechos):
        d = fim - ini
        f.append(f"[0:v]trim={ini}:{fim},setpts=PTS-STARTPTS[v{i}]")
        f.append(f"{a_in}atrim={ini}:{fim},asetpts=PTS-STARTPTS,afade=t=in:d=0.012,afade=t=out:st={max(d - 0.012, 0):.3f}:d=0.012[a{i}]")
    k = len(trechos)
    f.append("".join(f"[v{i}][a{i}]" for i in range(k)) + f"concat=n={k}:v=1:a=1[vc][ac]")
    f.append("[vc]scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2,fps=30,setsar=1[v]")
    # partes intermediárias em .mkv com som sem compressão (PCM): o AAC perde ~0,05 s no fim de cada arquivo e,
    # somado nas emendas, deixou o som 0,3 s adiantado da boca no fim do episódio de teste (06/11)
    meio = saida.with_name(saida.stem + "-c.mkv")
    cmd("ffmpeg", "-y", "-loglevel", "error", *entradas, "-filter_complex", ";".join(f), "-map", "[v]", "-map", "[ac]",
        "-c:v", "libx264", "-pix_fmt", "yuv420p", "-c:a", "pcm_s16le", "-ar", "44100", "-ac", "2", str(meio))
    lufs = volume(meio)
    ganho = 0.0 if lufs is None or lufs < -60 else ALVO_LUFS - lufs  # clipe mudo fica como está
    d = quadros(meio) / 30  # som com o tamanho exato da imagem
    cmd("ffmpeg", "-y", "-loglevel", "error", "-i", str(meio), "-c:v", "copy",
        "-af", f"volume={ganho:.2f}dB,alimiter=limit=0.89:level=false,apad=whole_dur={d:.4f},atrim=0:{d:.4f}",
        "-c:a", "pcm_s16le", "-ar", "44100", "-ac", "2", str(saida))


def quadros(arquivo):
    r = subprocess.run(["ffprobe", "-v", "error", "-count_frames", "-select_streams", "v", "-show_entries",
                        "stream=nb_read_frames", "-of", "csv=p=0", str(arquivo)], capture_output=True, text=True)
    return int(r.stdout.strip())


def cartela(saida, texto, segundos):
    """tela preta com o texto aparecendo letra a letra (0,1 s por letra) e parado até o fim."""
    # shortcut: fonte padrão do sistema; se o drawtext reclamar de fonte, ponha fontfile=<caminho de um .ttf> no filtro
    passos = []
    for k in range(1, len(texto) + 1):
        ini, fim = 0.1 * (k - 1), (0.1 * k if k < len(texto) else segundos)
        passos.append(f"drawtext=text='{texto[:k]}':fontcolor=white:fontsize=72:x=(w-text_w)/2:y=(h-text_h)/2"
                      f":enable='between(t,{ini:.2f},{fim:.2f})'")
    cmd("ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", f"color=c=black:s=720x1280:r=30:d={segundos}",
        "-f", "lavfi", "-i", "anullsrc=r=44100:cl=stereo", "-t", str(segundos), "-vf", ",".join(passos),
        "-c:v", "libx264", "-pix_fmt", "yuv420p", "-c:a", "pcm_s16le", "-ar", "44100", "-ac", "2", str(saida))


def montar(pasta, saida, cortes=None, texto="PARTE 2?", segundos=1.5):
    clipes = sorted(pathlib.Path(pasta).glob("*.mp4"))
    if not clipes:
        sys.exit(f"nenhum .mp4 em {pasta}")
    cortes = cortes or {}
    with tempfile.TemporaryDirectory() as tmp:
        tmp = pathlib.Path(tmp); partes = []
        for i, c in enumerate(clipes):
            n = tmp / f"{i:02d}.mkv"; normalizar(c, n, cortes.get(c.stem)); partes.append(n)
        fim = tmp / "fim.mkv"; cartela(fim, texto.replace("'", ""), segundos); partes.append(fim)
        entradas = [x for p in partes for x in ("-i", str(p))]
        juntar = "".join(f"[{i}:v][{i}:a]" for i in range(len(partes))) + f"concat=n={len(partes)}:v=1:a=1[v][a]"
        cmd("ffmpeg", "-y", "-loglevel", "error", *entradas, "-filter_complex", juntar, "-map", "[v]", "-map", "[a]",
            "-c:v", "libx264", "-pix_fmt", "yuv420p", "-c:a", "aac", "-ar", "44100", "-ac", "2", "-movflags", "+faststart", str(saida))
    return len(clipes)


def teste():
    with tempfile.TemporaryDirectory() as t:
        t = pathlib.Path(t); (t / "c").mkdir()
        for nome, dur in (("01", 4), ("02", 5), ("03", 5), ("04", 5)):
            cmd("ffmpeg", "-y", "-loglevel", "error", "-f", "lavfi", "-i", f"color=c=gray:s=320x568:r=24:d={dur}", "-f", "lavfi",
                "-i", f"sine=f=220:d={dur}", "-shortest", "-c:v", "libx264", "-c:a", "aac", str(t / "c" / f"{nome}.mp4"))
        montar(t / "c", t / "s.mp4", {k: [[0, 1.5], [3, 4.5]] for k in ("02", "03", "04")}, segundos=1.5)
        d = duracao(t / "s.mp4")
        assert abs(d - (4 + 3 * 3 + 1.5)) < 0.3, f"esperava 14,5 s, saiu {d:.2f} s"
        som = len(subprocess.run(["ffmpeg", "-v", "error", "-i", str(t / "s.mp4"), "-vn", "-ac", "1", "-ar", "44100", "-f", "s16le", "-"],
                                 capture_output=True).stdout) / 2 / 44100
        img = quadros(t / "s.mp4") / 30
        assert abs(som - img) < 0.05, f"som {som:.3f} s e imagem {img:.3f} s descasaram"
    print("teste ok: clipe 1 inteiro (4 s) + 2 trechos de cada um dos outros 3 (9 s) + PARTE 2? (1,5 s) = 14,5 s, som e imagem do mesmo tamanho")


def main(argv=None):
    if argv is None and sys.argv[1:] == ["--teste"]:
        return teste()
    p = argparse.ArgumentParser()
    p.add_argument("pasta"); p.add_argument("--saida", required=True); p.add_argument("--cortes")
    p.add_argument("--texto", default="PARTE 2?"); p.add_argument("--segundos", type=float, default=1.5)
    a = p.parse_args(argv)
    if not shutil.which("ffmpeg"):
        sys.exit("ffmpeg não encontrado: veja COMO-INSTALAR.md, passo 3")
    cortes = json.loads(pathlib.Path(a.cortes).read_text()) if a.cortes else None
    n = montar(a.pasta, a.saida, cortes, a.texto, a.segundos)
    print(f"pronto: {a.saida} ({n} clipes + {a.segundos}s de '{a.texto}')")


if __name__ == "__main__":
    main()
