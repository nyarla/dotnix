{ stdenv, lib, fetchurl }:
let fonts = import ./fonts.nix;
in stdenv.mkDerivation rec {
  version = "V2.0001";
  name = "noto-fonts-jp-${version}";

  files =
    map ({ name, url, sha256 }: fetchurl { inherit name url sha256; }) fonts;

  unpackPhase = ''
    mkdir -p noto

    ${lib.strings.concatMapStrings (font: ''
      cp ${font} noto/${font.name} 
    '') files}
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/
    mv noto $out/share/fonts/
  '';

  meta = with lib; {
    description = "Beautiful and free fonts for CJK languages";
    homepage = "https://www.google.com/get/noto/help/cjk/";
    longDescription = ''
      Noto Sans CJK is a sans serif typeface designed as an intermediate style
      between the modern and traditional. It is intended to be a multi-purpose
      digital font for user interface designs, digital content, reading on laptops,
      mobile devices, and electronic books. Noto Sans CJK comprehensively covers
      Simplified Chinese, Traditional Chinese, Japanese, and Korean in a unified font
      family. It supports regional variants of ideographic characters for each of the
      four languages. In addition, it supports Japanese kana, vertical forms, and
      variant characters (itaiji); it supports Korean hangeul — both contemporary and
      archaic.
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainer = [ "nyarla <nyarla@thotp.net>" ];
  };
}
