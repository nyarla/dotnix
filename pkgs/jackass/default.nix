{ multiStdenv, fetchzip, fetchFromGitHub, pkgs, pkgsi686Linux, wine, xorg }:
let
  vst2sdk = fetchzip {
    url = "https://archive.org/download/VST2SDK/vst_sdk2_4_rev2.zip";
    sha256 = "1x4qfviwcssk4fswhqks745jicblpy352kd69p7cqmgfcxhckq79";
  };
in multiStdenv.mkDerivation rec {
  pname = "JackAss";
  version = "v1.1";
  src = fetchFromGitHub {
    owner = "falkTX";
    repo = "JackAss";
    rev = "275f21b4aa3a34da0c3f7f1a6c734880f50a360b";
    sha256 = "1zh43wjh468dhqndbzjyd5l50p76a82azqmyl2rip9zvmj2b7kpz";
  };

  buildInputs =
    [ pkgs.libjack2 pkgsi686Linux.libjack2 wine xorg.libpthreadstubs ];

  prePatch = ''
    cp -R ${vst2sdk}/* vstsdk2.4/
    chmod -R +w vstsdk2.4

    sed -i 's|VST_EXPORT AEffect|VST_EXPORT VSTCALLBACK AEffect|g' vstsdk2.4/public.sdk/source/vst2.x/vstplugmain.cpp
    sed -i 's|-O3|-O2|' Makefile
  '';

  buildPhase = ''
    mkdir -p $out/lib/vst/JackAss

    make linux \
      CXXFLAGS=-I${pkgs.libjack2}/include \
      LDFLAGS="-L${pkgs.libjack2}/lib -ljack"
    cp JackAss*.so $out/lib/vst/JackAss/
    make clean


    make wine32
      CXXFLAGS="-I${pkgsi686Linux.libjack2}/include" \
      LDFLAGS="-L${pkgsi686Linux.libjack2}/lib -ljack"
    cp JackAss*.dll $out/lib/vst/JackAss/
    make clean

    make wine64 \
      CXXFLAGS="-I${pkgs.libjack2}/include" \
      LDFLAGS="-L${pkgs.libjack2}/lib -ljack"
    cp JackAss*.dll $out/lib/vst/JackAss/
    make clean
  '';

  installPhase = "true";
}
