{
  description = "Custom packages for my Nix environment.";
  outputs = { ... }: {
    overlay = self: super:
      let require = path: args: super.callPackage (import path) args;
      in {
        deadbeef-file-browser-plugin =
          require ./pkgs/deadbeef-file-browser-plugin { };
        ibus-skk = require ./pkgs/ibus-skk { };
        jackass = require ./pkgs/jackass { };
        jackass-bin = require ./pkgs/jackass-bin { };
        libvterm-neovim-mlterm = require ./pkgs/libvterm-neovim-mlterm { };

        parsec-bin = require ./pkgs/parsec-bin { };
        qtbrynhildr = require ./pkgs/qtbrynhildr { };
        wcwidth-cjk = require ./pkgs/wcwidth-cjk { };
        wine-vst-wrapper = require ./pkgs/wine-vst-wrapper { };
        wineasio = require ./pkgs/wineasio { };

        # fonts
        nerdfont-symbols-2048 = require ./pkgs/nerdfont-symbols/2048.nix { };
        noto-fonts-jp = require ./pkgs/noto-fonts-jp { };

        # icons, themes
        victory-gtk-theme = require ./pkgs/victory-gtk-theme { };
        flatery-icon-theme = require ./pkgs/flatery-icon-theme { };

        # modified
        bitwig-studio3 = super.bitwig-studio3.overrideAttrs (old: rec {
          version = "3.3.11";
          src = super.fetchurl {
            url =
              "https://downloads.bitwig.com/stable/${version}/${old.pname}-${version}.deb";
            sha256 = "137i7zqazc2kj40rg6fl6sbkz7kjbkhzdd7550fabl6cz1a20pvh";

          };
          installPhase = (builtins.replaceStrings [ "bitwig-studio.desktop" ]
            [ "com.bitwig.BitwigStudio.desktop" ] old.installPhase);
        });

        whipper = super.whipper.overrideAttrs (old: rec {
          postPatch = ''
            sed -i 's|cd-paranoia|${super.cdparanoia}/bin/cdparanoia|g' whipper/program/cdparanoia.py
          '';
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
      };
  };
}
