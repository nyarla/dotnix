self: super:
let require = path: args: super.callPackage (import path) args;
in {
  # new packages
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
}
