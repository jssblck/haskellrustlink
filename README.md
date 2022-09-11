
# Linking Rust libraries statically in Haskell

This is a small repo in which I'm trying to set up a realistic Haskell project and link FFI binaries
(in this case Rust, but it could be anything) into it with minimal pain.

Resources used:
- https://blog.mgattozzi.dev/haskell-rust/

# Status

This pretty much just works, with a couple downsides:

1. Whatever file actually includes the FFI library complains because "loading static libraries is not supported in this configuration".

I think this is purely a language server issue, as the build itself works.
This is being worked around by telling `cargo` to build both a dynamic and static library- but this may not be ideal;
in particular I'm unsure how to force it to statically link if both are available.

2. The file must be linked from an abolute path, so the FFI target needs to be installed in a global place.

**Output:**
```shell
; cabal clean  && cabal run
Resolving dependencies...
Build profile: -w ghc-9.0.2 -O0
In order, the following will be built (use -v for more details):
 - haskellrustlink-0.1.0.0 (lib:extlib) (first run)
 - haskellrustlink-0.1.0.0 (lib) (first run)
 - haskellrustlink-0.1.0.0 (exe:demo) (first run)
Configuring library 'extlib' for haskellrustlink-0.1.0.0..
Preprocessing library 'extlib' for haskellrustlink-0.1.0.0..
Building library 'extlib' for haskellrustlink-0.1.0.0..
[1 of 2] Compiling Extlib.Internal  ( extlib/Extlib/Internal.hs, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/l/extlib/noopt/build/extlib/Extlib/Internal.o, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/l/extlib/noopt/build/extlib/Extlib/Internal.dyn_o )
[2 of 2] Compiling Extlib           ( extlib/Extlib.hs, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/l/extlib/noopt/build/extlib/Extlib.o, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/l/extlib/noopt/build/extlib/Extlib.dyn_o )
Configuring library for haskellrustlink-0.1.0.0..
Preprocessing library for haskellrustlink-0.1.0.0..
Building library for haskellrustlink-0.1.0.0..
[1 of 1] Compiling Lib              ( src/Lib.hs, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/noopt/build/Lib.o, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/noopt/build/Lib.dyn_o )
Configuring executable 'demo' for haskellrustlink-0.1.0.0..
Preprocessing executable 'demo' for haskellrustlink-0.1.0.0..
Building executable 'demo' for haskellrustlink-0.1.0.0..
[1 of 1] Compiling Main             ( app/Main.hs, /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/x/demo/noopt/build/demo/demo-tmp/Main.o )
Linking /Users/jessica/projects/scratch/haskellrustlink/dist-newstyle/build/aarch64-osx/ghc-9.0.2/haskellrustlink-0.1.0.0/x/demo/noopt/build/demo/demo ...
Hello, Haskell
Hello from Rust!
Hello through Rust
3 doubled is: 6
```

# Architecture

The attempt was to get this to replicate a non-trivial project and quarantine the language server error.

- `app/Main.hs`: The binary entry point. Depends on `src/Lib.hs`.
- `src/Lib.hs`: The library. Depends on `extlib/Extlib.hs`.
- `extlib/Extlib.hs`: A wrapper for the FFI layer to hide FFI types. Depends on `extlib/Extlib/Internal.hs`.
- `extlib/Extlib/Internal.hs`: The actual file that calls into the FFI binary.
- `extlib/hello`: The Rust library being FFI'd into.

`extlib` has its own `library extlib` entry in the Cabal file:
this uses the "[convenience libraries](https://github.com/haskell/cabal/pull/3022)" feature of Cabal.

# TODO

- [ ] Force the Haskell binary to be statically linked.
- [ ] Make the build script put the Rust binary somewhere global but system independent for building.
- [ ] Make a test matrix including Windows so I can validate how that works.

Things I'd like to do, but may not be easily doable:

- [ ] Somehow work around the language server error without building a `cdylib`.
