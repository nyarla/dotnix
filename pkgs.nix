self: super:
let require = path: args: super.callPackage (import path) args;
in {
  ibus-skk = require ./pkgs/ibus-skk { };
  wcwidth-cjk = require ./pkgs/wcwidth-cjk { };

  nerdfont-symbols-2048 = require ./pkgs/nerdfont-symbols/2048.nix { };
}
