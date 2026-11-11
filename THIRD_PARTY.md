# Third-party sources

## raylib

`vendor/raylib` contains the unmodified build-relevant source subset from
[raysan5/raylib](https://github.com/raysan5/raylib) commit
`8e82249f6572ae2683a9cade6addd9b404abd710` (headers identify version 6.0).
Copied from the raylib submodule used by mojo-raylib. Includes `src`, `cmake`,
the root CMake files, `raylib.pc.in`, README and LICENSE; upstream examples,
tools and project files not needed to build the library are omitted.

Raylib's license is in `vendor/raylib/LICENSE`. Its bundled third-party sources
retain their license notices and separate license files.

## rlparser / mojo-raylib

`tools/rlparser.c` was copied from the working checkout of
[mojo-raylib](https://github.com/kivicode/mojo-raylib), based on commit
`3d49cea57c0974590e35a7facd28ecc5ca672428`, including its local parser improvements.
The source snapshot before the Goose-specific change has SHA-256
`ef052cc37e9d2c1f26d5a915dbe87eaf9f79de4cd7c220fd89deed7618eb2f4d`.
The original checkout was not modified.

The Goose copy changes `EscapeBackslashes` to escape quotes and bound expanded
output, so quoted API descriptions produce valid JSON. The change is marked
in the source. Only its JSON export is used, not its Mojo/C CODE backend.

Copyright 2021–2026 Ramon Santamaria and contributors; Mojo binding generator
contributions by KiviCode. License notices are preserved in
`tools/LICENSE.rlparser` and `tools/LICENSE.mojo-raylib`.
