#!/usr/bin/env python3
"""Exercise the public bindings with TinyCC and debug/optimized Clang."""
import argparse
import os
from pathlib import Path
import struct
import subprocess
import tempfile
import wave

ROOT = Path(__file__).resolve().parents[1]


def exercise(command, directory):
    samples = [i * 701 - 9000 for i in range(32)]
    with wave.open(str(directory / "tone.wav"), "wb") as stream:
        stream.setparams((1, 2, 8000, 32, "NONE", "not compressed"))
        stream.writeframes(struct.pack("<32h", *samples))
    subprocess.run(list(map(str, command)), cwd=directory, check=True)
    with wave.open(str(directory / "cropped.wav"), "rb") as stream:
        assert stream.getnframes() == 16
        assert struct.unpack("<16h", stream.readframes(16)) == tuple(samples[3:19])
    print("Passed:", " ".join(map(str, command)), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cc", default="clang")
    parser.add_argument("--graphics", action="store_true", help="Also render and assert pixels; needs a display (e.g. xvfb-run).")
    args = parser.parse_args()
    goose = os.environ.get("GOOSE", "goose")
    os.environ.setdefault("GOOSE_CC", args.cc)
    source = ROOT / "tests/check.goose"
    with tempfile.TemporaryDirectory(prefix="goose-raylib-tests-") as temp:
        directory = Path(temp)
        for opt in (0, 2):
            exercise([goose, "run", source, "--debug", f"-O{opt}"], directory)
        for flags in (["--debug"], []):
            exe = directory / ("check.exe" if os.name == "nt" else "check")
            subprocess.run([goose, "build", str(source), "--cc", args.cc, "-O2", *flags, "-o", str(exe)], cwd=ROOT, check=True)
            exercise([exe], directory)
        subprocess.run([goose, "check", str(ROOT / "examples/window.goose")], cwd=ROOT, check=True)
        if args.graphics:
            source = ROOT / "tests/render.goose"
            exercise_commands = [[goose, "run", str(source), "--debug"]]
            exe = directory / ("render.exe" if os.name == "nt" else "render")
            subprocess.run([goose, "build", str(source), "--cc", args.cc, "-O2", "-o", str(exe)], cwd=ROOT, check=True)
            exercise_commands.append([str(exe)])
            for command in exercise_commands:
                subprocess.run(command, cwd=directory, check=True)
                print("Passed rendering:", " ".join(command), flush=True)


if __name__ == "__main__":
    main()
