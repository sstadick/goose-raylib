# goose-raylib

Goose bindings for raylib 6.0 and raymath, generated from their C headers.
Uses the Gooseverse conventions: `raylib.goose`, namespace `raylib`, snake_case
functions, `PascalCase` value types, native byte slices for text, and goose-doc.

See the [API reference](API.md) and the exact [coverage and omissions](COVERAGE.md).
Colors, keys, enum values and flags retain raylib's uppercase names, such as
`raylib::RAYWHITE`, `raylib::KEY_SPACE` and `raylib::FLAG_WINDOW_RESIZABLE`.
Their values and descriptions are in [raylib.goose](raylib.goose); goose-doc
does not currently include global constants.

## Run

Requires a current Goose compiler with `c_headers`, CMake 3.25+, and Clang.
Developed against Goose `d5ae5bbda990923fa4129f969c7f853c20d4d1e6`.
Raylib is vendored: no system raylib installation or build-time download is needed.
Even `goose run` needs a native compiler for raylib and the TinyCC adapter library.

On Debian/Ubuntu the desktop build needs X11 and OpenGL development packages:

```sh
sudo apt-get install clang cmake ninja-build libx11-dev libxrandr-dev \
  libxinerama-dev libxcursor-dev libxi-dev libgl1-mesa-dev
```

With a desktop display available, from this checkout:

```sh
GOOSE_CC=clang goose run examples/window.goose
mkdir -p build
goose build examples/window.goose --cc clang -O2 -o build/window
./build/window
```

Declare the package in your application's root file:

```goose
import raylib from "github.com/sstadick/goose-raylib@main";

fn main() {
    raylib::init_window(800, 450, "Goose + raylib");
    defer raylib::close_window();
    raylib::set_target_fps(60);
    while !raylib::window_should_close() {
        raylib::begin_drawing();
        raylib::clear_background(raylib::RAYWHITE);
        raylib::draw_circle(400, 225, 80.0, raylib::ORANGE);
        raylib::draw_text("Hello from Goose", 30, 30, 24, raylib::DARKGRAY);
        raylib::end_drawing();
    }
}
```

The example follows `main`. Applications that need reproducibility should pin
a tested commit. For local development, use `import raylib from "../goose-raylib";`.

## ABI and ownership

`raylib.build` injects `include/raylib.h` through **`c_headers`**, after Goose's
generated types. Clang inlines the adapters into the application's C. They
convert fields between packed Goose values and naturally aligned raylib values;
they never cast a Goose struct pointer to a raylib struct pointer. This matters
for types such as `RayCollision`, `Wave`, `Font`, and `Model`, not just vectors.

TinyCC calls native exports compiled from the same header, with the generated
packed ABI declarations in `include/abi.h`. The Goose-to-C naming/layout contract
is compiler-specific; the tests exercise both paths. Raymath functions are also
header-inlined in native builds. CMake owns raylib and its platform link libraries.

- Text arguments accept `const u8[:]`. Wrappers allocate a terminated copy for
  the call. Embedded NUL ends the C string, as in raylib; empty is not NULL.
  Use the corresponding `_raw` call with address `0` when raylib requires NULL.
- Functions returning `const char *` have wrappers that copy to `u8[>..]` before
  raylib can overwrite its static buffers. A NULL result becomes an empty builder.
- `trace_log` and `text_format` take **literal text**, not variadic arguments.
  Format values in Goose first. Percent signs are not interpreted.
- Functions such as `image_crop(image, rect)`, `wave_crop(wave, first, last)`
  and `update_camera(camera, mode)` borrow mutable values and copy changed fields
  back. They do not expose the packed values as native C storage.
- Resources remain **manually owned**. Call the corresponding `unload_*` once,
  normally with `defer`. Copies alias the same resource; they are not independent
  owners. Do not use a resource after unloading it. Unload GPU resources before
  closing the window, and audio resources before closing the audio device.
  Defaults/borrowed resources, such as `get_font_default()`, must not be unloaded.
  `load_model_from_mesh` transfers the mesh to the model: unload the model only.
- `_raw` functions and pointer fields use `u64` **native addresses**, not safe
  Goose references. They retain raylib's allocation, capacity, lifetime and
  ownership contracts. Array elements must have native C layout/alignment.
  Do not pass addresses of packed Goose structs or arrays to them. Native pointer
  results must be released with the matching raylib function, not a Goose free.
- `_c_*` declarations are implementation details, not the public API. In
  particular their string slices must already include their NUL terminator.
- The package is main-thread-only. Native callback registration is not exposed:
  a Goose function is not a C function pointer, particularly on audio threads.

The generated surface covers 736 raylib/raymath functions; 641 have value,
borrowed-reference or text interfaces, while the remaining 95 are raw-only.
Ten callback-registration functions are omitted. `rlgl`, raygui, and a safe
buffer/array facade for every pointer-based API are outside this package's
current scope. API coverage is not a claim that every function was executed.

## Generate, document and test

The parser comes from mojo-raylib. `tools/generate.py` consumes its JSON instead
of modifying the Mojo emitter, and generates the Goose module, inline adapters,
TinyCC ABI, public symbol list, and coverage report together. Unknown C types
fail generation rather than silently becoming integer handles. Edit the generator,
not its output. See [THIRD_PARTY.md](THIRD_PARTY.md) for provenance and licenses.

With goose-doc checked out next door:

```sh
python3 tools/generate.py
python3 tools/generate.py --check
scripts/docs.sh
scripts/docs.sh --check
GOOSE_CC=clang scripts/doctest.sh
scripts/doctest.sh --cc clang
python3 tests/run.py --cc clang
xvfb-run -a python3 tests/run.py --cc clang --graphics
```

Set `GOOSE` and `GOOSE_DOC` to choose the compiler and goose-doc's `main.goose`.
Linux graphics tests need a display or Xvfb and Mesa. The tests assert packed
struct returns, matrix/array conversion, mutable image and wave operations,
PNG round-trips, independently checked WAV samples, string boundaries, and
literal formatting. Rendering tests assert actual pixels for 2D shapes,
textures and a 3D model, plus camera transforms and font metrics. They run via
TinyCC and native Clang; CPU tests also run debug and optimized variants.

To capture the example, run `goose run examples/window.goose -- --frames 3 window.png`.

Local validation was on Linux x86-64 with Clang 18 and Mesa llvmpipe under Xvfb.
No physical audio playback, gamepad hardware, Windows or macOS validation is
claimed. [CI](https://github.com/sstadick/goose-raylib/actions/workflows/ci.yml)
checks generation, documentation and rendering on Linux. The package is listed
in [Gooseverse](https://github.com/sstadick/gooseverse).

The binding code is MIT licensed; raylib and the copied parser retain their
own zlib-style licenses.
