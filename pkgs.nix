self: super:
let require = path: args: super.callPackage (import path) args;
in {
  # new packages
  ibus-skk = require ./pkgs/ibus-skk { };
  libvterm-neovim-mlterm = require ./pkgs/libvterm-neovim-mlterm { };
  wcwidth-cjk = require ./pkgs/wcwidth-cjk { };
  deadbeef-file-browser-plugin =
    require ./pkgs/deadbeef-file-browser-plugin { };

  # fonts
  nerdfont-symbols-2048 = require ./pkgs/nerdfont-symbols/2048.nix { };
  noto-fonts-jp = require ./pkgs/noto-fonts-jp { };

  # modified
  calibre = super.calibre.overrideAttrs (old: rec {
    buildInputs = [ super.python3Packages.pycrypto ] ++ old.buildInputs;
  });
}
