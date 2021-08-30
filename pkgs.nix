self: super:
let require = path: args: super.callPackage (import path) args;
in {
  # new packages
  ibus-skk = require ./pkgs/ibus-skk { };
  libvterm-neovim-mlterm = require ./pkgs/libvterm-neovim-mlterm { };
  wcwidth-cjk = require ./pkgs/wcwidth-cjk { };

  # fonts
  nerdfont-symbols-2048 = require ./pkgs/nerdfont-symbols/2048.nix { };
  noto-fonts-jp = require ./pkgs/noto-fonts-jp { };

  # modified
  mlterm = super.mlterm.overrideAttrs (old: rec {
    src = super.fetchurl {
      url =
        "https://github.com/arakiken/mlterm/archive/refs/heads/master.tar.gz";
      sha256 = "10bh0azg5dxpr4c4xl3r9yk56dh1scncv35clxa3vzpmk96k1dqc";
    };
  });
  neovim-unwrapped = super.neovim-unwrapped.override {
    libvterm-neovim = self.libvterm-neovim-mlterm;
  };
}
