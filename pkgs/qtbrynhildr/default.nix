{ stdenv, fetchurl, celt, libvpx, icu, qt5, libpulseaudio, openssl, pkg-config
, libGLU }:
stdenv.mkDerivation rec {
  pname = "QtBrynhildr";
  version = "v238";
  src = fetchurl {
    url =
      "https://github.com/funfun-dc5/qtbrynhildr/archive/refs/tags/v238.tar.gz";
    sha256 = "00cnkmikp86dzifjxiya6fmj2ah7rb2fh23ddb7vhlpav026gmdn";
  };

  postPatch = ''
    sed -i 's!CONFIG += c++11!CONFIG += c++11 link_pkgconfig!' src/qtbrynhildr.pro

    sed -i 's!INCLUDEPATH += ../libs/celt/include!PKGCONFIG += celt!' src/qtbrynhildr.pro
    sed -i 's!LIBS += -L../libs/celt/$$BUILDARCH -lcelt!!' src/qtbrynhildr.pro
    sed -i 's!include "celt.h"!include <celt/celt.h>!' src/soundthread/converter_celt.h

    sed -i 's!INCLUDEPATH += ../libs/vpx/include!PKGCONFIG += vpx!' src/qtbrynhildr.pro
    sed -i 's!LIBS += -L../libs/vpx/$$BUILDARCH -lvpx!!' src/qtbrynhildr.pro
    sed -i 's!include "vpx_decoder.h"!include <vpx/vpx_decoder.h>!' src/graphicsthread/yuv2rgb/yuv2rgb.h
    sed -i 's!include "vp8dx.h"!include <vpx/vp8dx.h>!' src/graphicsthread/yuv2rgb/yuv2rgb.h

    sed -i 's!qApp->applicationDirPath() + QTB_KEYLAYOUT_FILE_PATH  + QDir::separator()!QTB_KEYLAYOUT_FILE_PATH!' src/settings.cpp
    sed -i "s!/keylayout!$out/share/QtBrynhildr/keylayout!" src/settings.h
  '';

  preConfigure = ''
    cd src
  '';

  buildInputs =
    [ qt5.full celt libvpx.dev icu libpulseaudio openssl.dev libGLU ];
  nativeBuildInputs = (with qt5; [ qmake qttools wrapQtAppsHook ])
    ++ [ pkg-config ];

  postBuild = ''
    cd keylayout
    make -f GNUmakefile
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/QtBrynhildr/keylayout/

    cp 'Qt Brynhildr' $out/bin/qtbrynhildr 
    cp keylayout/klfc $out/bin/klfc

    cp -R keylayout/*.kl $out/share/QtBrynhildr/keylayout/
    cd $out/share/QtBrynhildr/keylayout/
    $out/bin/klfc Japanese109.kl
    $out/bin/klfc US101.kl
    cd ../../../
  '';
}
