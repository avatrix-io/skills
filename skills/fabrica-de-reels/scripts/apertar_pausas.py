#!/usr/bin/env python3
"""Encurta as pausas longas entre frases de uma fala ANTES de gerar o vídeo. Só precisa do ffmpeg.

  python3 apertar_pausas.py falas/01.mp3 falas/01-apertada.mp3 [--json falas/01.json] [--min 0.42] [--alvo 0.28]
  python3 apertar_pausas.py teste

Fala gerada sai lenta pela pausa, não pela velocidade: 18 a 25% de silêncio, com 1 a 1,5 s entre frases, contra 7% num
viral que fala 3 palavras por segundo. Silêncio de 0,42 s ou mais vira 0,28 s; silêncio curto (respiração, consoante)
fica. Com --json, o tempo de cada palavra é ajustado no próprio arquivo, pra legenda e corte continuarem batendo.
shortcut: limiar fixo de 35 dB abaixo do pico; com ruído de fundo forte, a pausa não é achada e nada se corta.
"""
import argparse, array, json, math, pathlib, subprocess, sys

SR = 44100
JANELA = 0.01   # 10 ms


def ler(arquivo):
    r = subprocess.run(["ffmpeg", "-v", "error", "-i", str(arquivo), "-vn", "-ac", "1", "-ar", str(SR), "-f", "s16le", "-"],
                       capture_output=True, check=True)
    x = array.array("h")
    x.frombytes(r.stdout)
    return x


def achar_pausas(x, minimo):
    """trechos de silêncio (início, fim) em amostras, de pelo menos `minimo` s, sem contar o começo e o fim do arquivo."""
    h = int(JANELA * SR)
    n = len(x) // h
    db = []
    for i in range(n):
        q = x[i * h:(i + 1) * h]
        db.append(20 * math.log10(math.sqrt(sum(v * v for v in q) / h) + 1e-3))
    if not db:
        return []
    corte = max(db) - 35
    pausas, i = [], 0
    while i < n:
        if db[i] < corte:
            j = i
            while j < n and db[j] < corte:
                j += 1
            if (j - i) * JANELA >= minimo and i > 0 and j < n:
                pausas.append((i * h, j * h))
            i = j
        else:
            i += 1
    return pausas


def apertar(x, pausas, alvo):
    """devolve (áudio novo, trechos removidos em segundos do original). Fica `alvo` s de cada pausa, meio de cada lado."""
    meio = int(alvo * SR / 2)
    fade = int(0.008 * SR)
    y, removidos, pos = array.array("h"), [], 0
    for a, b in pausas:
        fim, volta = a + meio, b - meio
        pedaco = x[pos:fim]
        for k in range(min(fade, len(pedaco))):   # emenda suave: some no fim do pedaço...
            pedaco[-1 - k] = int(pedaco[-1 - k] * k / fade)
        y.extend(pedaco)
        removidos.append((fim / SR, volta / SR))
        pos = volta
    resto = x[pos:]
    if pausas:
        for k in range(min(fade, len(resto))):    # ...e volta no começo do seguinte
            resto[k] = int(resto[k] * k / fade)
    y.extend(resto)
    return y, removidos


def mapear(t, removidos):
    """tempo no áudio original -> tempo no áudio apertado."""
    menos = 0.0
    for a, b in removidos:
        if t >= b:
            menos += b - a
        elif t > a:
            return a - menos
    return t - menos


def gravar(y, destino):
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-f", "s16le", "-ar", str(SR), "-ac", "1", "-i", "-",
                    "-c:a", "libmp3lame", "-b:a", "160k", str(destino)], input=y.tobytes(), check=True)


def teste():
    def tom(s):
        return array.array("h", (int(8000 * math.sin(2 * math.pi * 200 * k / SR)) for k in range(int(s * SR))))

    x = tom(0.5) + array.array("h", [0] * int(1.2 * SR)) + tom(0.5) + array.array("h", [0] * int(0.3 * SR)) + tom(0.5)
    pausas = achar_pausas(x, 0.42)
    assert len(pausas) == 1, pausas                       # a pausa de 0,3 s fica
    y, rem = apertar(x, pausas, 0.28)
    assert abs((len(x) - len(y)) / SR - 0.92) < 0.03, (len(x) - len(y)) / SR   # 1,2 s viraram 0,28 s
    assert abs(mapear(1.9, rem) - (1.9 - 0.92)) < 0.03    # palavra depois da pausa anda pra trás
    assert mapear(0.2, rem) == 0.2                        # palavra antes da pausa fica onde está
    print("teste ok: pausa de 1,2 s virou 0,28 s, a de 0,3 s ficou, tempo das palavras acompanha")


def main():
    if len(sys.argv) == 2 and sys.argv[1] == "teste":
        return teste()
    p = argparse.ArgumentParser()
    p.add_argument("origem")
    p.add_argument("destino")
    p.add_argument("--json")
    p.add_argument("--min", type=float, default=0.42)
    p.add_argument("--alvo", type=float, default=0.28)
    a = p.parse_args()
    x = ler(a.origem)
    y, rem = apertar(x, achar_pausas(x, a.min), a.alvo)
    gravar(y, a.destino)
    if a.json:
        j = pathlib.Path(a.json)
        dados = json.loads(j.read_text())
        if dados.get("pausas_apertadas") is not None:
            sys.exit(f"{a.json} já foi ajustado; refaça a partir da fala original")
        for w in dados.get("palavras", []):
            w["de"], w["ate"] = round(mapear(w["de"], rem), 3), round(mapear(w["ate"], rem), 3)
        dados["duracao"] = round(len(y) / SR, 3)
        dados["pausas_apertadas"] = [round(b - a_, 2) for a_, b in rem]
        j.write_text(json.dumps(dados, ensure_ascii=False, indent=1))
    print(f"{a.destino} | {len(x) / SR:.2f} s -> {len(y) / SR:.2f} s | {len(rem)} pausas encurtadas")


if __name__ == "__main__":
    main()
