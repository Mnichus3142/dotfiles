#!/usr/bin/env python3
"""Pack Caelestia colours into a Telegram Desktop theme that auto-reloads."""

from __future__ import annotations

import json
import os
import struct
import tempfile
import zipfile
import zlib
from pathlib import Path


def state_dir() -> Path:
    return Path(os.environ.get("XDG_STATE_HOME", Path.home() / ".local/state")) / "caelestia"


def colours() -> dict[str, str]:
    raw = os.environ.get("SCHEME_COLOURS")
    if raw:
        try:
            parsed = json.loads(raw)
            if isinstance(parsed, dict) and parsed:
                return parsed
        except json.JSONDecodeError:
            pass
    scheme_path = state_dir() / "scheme.json"
    scheme = json.loads(scheme_path.read_text())
    return scheme.get("colours", {})


def write_png(path: Path, red: int, green: int, blue: int, size: int = 64) -> None:
    row = b"\x00" + bytes((red, green, blue)) * size
    raw = row * size

    def chunk(tag: bytes, data: bytes) -> bytes:
        return struct.pack(">I", len(data)) + tag + data + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)

    ihdr = struct.pack(">IIBBBBB", size, size, 8, 2, 0, 0, 0)
    path.write_bytes(
        b"\x89PNG\r\n\x1a\n"
        + chunk(b"IHDR", ihdr)
        + chunk(b"IDAT", zlib.compress(raw, 9))
        + chunk(b"IEND", b"")
    )


def main() -> None:
    root = state_dir()
    colors_src = root / "theme" / "colors.tdesktop-theme"
    if not colors_src.is_file():
        return

    palette = colours()
    background = palette.get("background", "000000").lstrip("#")
    red = int(background[0:2], 16)
    green = int(background[2:4], 16)
    blue = int(background[4:6], 16)

    out_dir = root / "telegram"
    out_dir.mkdir(parents=True, exist_ok=True)
    background_png = out_dir / "background.png"
    write_png(background_png, red, green, blue)

    dest = out_dir / "caelestia.tdesktop-theme"
    fd, tmp_name = tempfile.mkstemp(prefix="caelestia-telegram-", suffix=".tdesktop-theme", dir=out_dir)
    os.close(fd)
    tmp_path = Path(tmp_name)
    try:
        with zipfile.ZipFile(tmp_path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
            archive.write(colors_src, "colors.tdesktop-theme")
            archive.write(background_png, "background.png")
        tmp_path.replace(dest)
    finally:
        if tmp_path.exists():
            tmp_path.unlink(missing_ok=True)


if __name__ == "__main__":
    main()
