{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  pname = "victory-gtk-theme";
  version = "git";
  src = fetchgit {
    url = "https://gitlab.com/newhoa/victory-gtk-theme/";
    sha256 = "1v7sa9v99l6g0d4y1cjjh673lwzl7w2byd400lqnlmb274zij0nk";
  };

  installPhase = ''
    mkdir -p $out/share/themes/

    mv Victory-17.04 $out/share/themes/Victory
    mv Victory-17.04-dark $out/share/themes/Victory-dark
    mv Victory-17.04-medium $out/share/themes/Victory-medium
    mv Victory-17.04-midnight $out/share/themes/Victory-midnight
    mv Victory-17.04-silver $out/share/themes/Victory-silver
    mv Victory-xfwm-hidpi $out/share/themes/Victory-xfwm-hidpi 
  '';
}
