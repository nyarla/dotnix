{ stdenv, fetchFromGitHub, gnused, pkgconfig, wine, qt5, python3
, python3Packages, pkgs, pkgsi686Linux }:
let
  source = fetchFromGitHub {
    owner = "wineasio";
    repo = "wineasio";
    rev = "0a97f2f9e29c133349237cdd88fec4615cc72931";
    sha256 = "1358541j6qild0p2v1spyq9yhiji9j85k4znx0xrlsp2ny3kmp25";
    fetchSubmodules = true;
  };

  mkWineAsioDerivation = arch: pkgs:
    pkgs.stdenv.mkDerivation rec {
      pname = "wineasio-${arch}";
      version = "git";
      src = source;
      nativeBuildInputs = [ gnused pkgconfig ];

      buildInputs = [ wine pkgs.libjack2 ];

      postPatch = ''
        sed -i "s!= /usr!= $out!" Makefile.mk
        sed -i 's!-I$(PREFIX)/!-I${wine}/!g' Makefile.mk
      '';

      buildPhase = ''
        make clean
        make ${arch}
      '';

      libPrefix = if arch == "32" then "lib/wine" else "lib64/wine";

      installPhase = ''
        mkdir -p $out/${libPrefix}
        cp build${arch}/wineasio.dll.so $out/${libPrefix}/wineasio.dll.so
      '';

      dontFixup = true;
    };

  wineasio_32bit = mkWineAsioDerivation "32" pkgsi686Linux;
  wineasio_64bit = mkWineAsioDerivation "64" pkgs;
in stdenv.mkDerivation rec {
  pname = "wineasio";
  version = "git";
  src = source;

  nativeBuildInputs = [ qt5.wrapQtAppsHook python3.pkgs.wrapPython ];

  buildInputs =
    [ wineasio_32bit wineasio_64bit python3 python3Packages.pyqt5 qt5.full ];

  pythonPath = with python3Packages; [ pyqt5 ];

  postPatch = ''
    sed -i "s!= /usr!= $out!" gui/Makefile
  '';

  buildPhase = ''
    cd gui
    make
    cd ..

    cat <<EOF >gui/wineasio-settings
    #!${stdenv.shell}
    exec $out/share/wineasio/settings.py $@
    EOF
  '';

  installPhase = ''
    mkdir -p $out/lib/wine/i386-unix/
    mkdir -p $out/lib/wine/x86_64-unix/

    ln -s ${wineasio_32bit}/lib/wine/wineasio.dll.so $out/lib/wine/i386-unix/wineasio.dll.so
    ln -s ${wineasio_64bit}/lib64/wine/wineasio.dll.so $out/lib/wine/x86_64-unix/wineasio.dll.so

    mkdir -p $out/bin
    cd gui
    make install
    cd ..
  '';

  fixupPhase = ''
    chmod +x $out/share/wineasio/settings.py
    sed -i 's|#!/usr/bin/env python3|#!${python3}/bin/python3|' $out/share/wineasio/settings.py
    wrapProgram $out/share/wineasio/settings.py \
      ''${qtWrapperArgs[@]} \
      --prefix PYTHONPATH : $PYTHONPATH 
  '';

  dontStrip = true;
}
