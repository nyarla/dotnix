{ stdenv, pkgs, lib, buildFHSUserEnv, dpkg, fetchurl }:
let
  pkg = stdenv.mkDerivation rec {
    pname = "parsecd";
    version = "latest";
    src = fetchurl {
      url = "https://builds.parsecgaming.com/package/parsec-linux.deb";
      sha256 = "1hfdzjd8qiksv336m4s4ban004vhv00cv2j461gc6zrp37s0fwhc";
    };

    nativeBuildInputs = [ dpkg ];

    unpackPhase = ''
      dpkg --fsys-tarfile $src | tar --extract
    '';

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share

      cp -R usr/bin/* $out/bin/
      cp -R usr/share/* $out/share/
    '';
  };
in buildFHSUserEnv rec {
  name = "parsec";
  targetPkgs = pkgs:
    (with pkgs; [
      alsaLib
      cacert
      cairo
      expat
      freetype
      gdk_pixbuf
      glib-networking
      gtk2
      libGL
      libglvnd
      libpulseaudio
      libudev
      openssl
      pango
      zlib
    ]) ++ (with pkgs.xorg; [
      libSM
      libX11
      libXcomposite
      libXcursor
      libXfixes
      libXi
      libXinerama
      libXrandr
      libXrender
      libXxf86vm
      libxcb
    ]) ++ [ stdenv.cc.cc.lib ];

  runScript = pkgs.writeScript "parsec" ''
    #!${stdenv.shell}

    if test ! -d $HOME/.parsec ; then
      mkdir -p $HOME/.parsec
    fi

    if test ! -e $HOME/.parsec/appdata.json ; then
      cp ${pkg}/share/parsec/skel/appdata.json $HOME/.parsec/
    fi

    if test ! -e $HOME/.parsec/parsecd-150-28.so ; then
      cp ${pkg}/share/parsec/skel/parsecd-150-28.so $HOME/.parsec/
    fi

    chmod +w $HOME/.parsec/*

    exec ${pkg}/bin/parsecd
  '';
}
