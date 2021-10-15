self: super:
let require = path: args: super.callPackage (import path) args;
in {
  deadbeef-file-browser-plugin =
    require ./pkgs/deadbeef-file-browser-plugin { };
  ibus-skk = require ./pkgs/ibus-skk { };
  libvterm-neovim-mlterm = require ./pkgs/libvterm-neovim-mlterm { };
  parsec-bin = require ./pkgs/parsec-bin { };
  qtbrynhildr = require ./pkgs/qtbrynhildr { };
  wcwidth-cjk = require ./pkgs/wcwidth-cjk { };
  wineasio = require ./pkgs/wineasio { };

  # fonts
  nerdfont-symbols-2048 = require ./pkgs/nerdfont-symbols/2048.nix { };
  noto-fonts-jp = require ./pkgs/noto-fonts-jp { };

  # modified
  calibre = super.calibre.overrideAttrs (old: rec {
    buildInputs = [ super.python3Packages.pycrypto ] ++ old.buildInputs;
  });

  perlPackages = (with super.perlPackages; {
    Shell = buildPerlPackage {
      pname = "Shell";
      version = "0.73";
      src = super.fetchurl {
        url = "mirror://cpan/authors/id/F/FE/FERREIRA/Shell-0.73.tar.gz";
        sha256 =
          "f7dbebf65261ed0e5abd0f57052b64d665a1a830bab4c8bbc220f235bd39caf5";
      };
      meta = {
        description = "Run shell commands transparently within perl";
        license = with super.lib.licenses; [ artistic1 gpl1Plus ];
      };
    };
  }) // super.perlPackages;
}
