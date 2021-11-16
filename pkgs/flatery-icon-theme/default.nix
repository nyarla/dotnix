{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "flatery-icon-theme";
  version = "git";
  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Flatery";
    rev = "b4cffbca5e19d79f12d2e81569313e3d451c9ed3";
    sha256 = "sha256-EsWHTspVkI0lqVchc0Ur9Dvn46U4fmc9+fjmBB5pgc4=";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/share/icons/

    mv Flatery $out/share/icons/
    mv Flatery-Black $out/share/icons/
    mv Flatery-Black-Dark $out/share/icons/
    mv Flatery-Blue $out/share/icons/
    mv Flatery-Blue-Dark $out/share/icons/
    mv Flatery-Dark $out/share/icons/
    mv Flatery-Gray $out/share/icons/
    mv Flatery-Gray-Dark $out/share/icons/
    mv Flatery-Green $out/share/icons/
    mv Flatery-Green-Dark $out/share/icons/
    mv Flatery-Indigo $out/share/icons/
    mv Flatery-Indigo-Dark $out/share/icons/
    mv Flatery-Mint $out/share/icons/
    mv Flatery-Mint-Dark $out/share/icons/
    mv Flatery-Orange $out/share/icons/
    mv Flatery-Orange-Dark $out/share/icons/
    mv Flatery-Pink $out/share/icons/
    mv Flatery-Pink-Dark $out/share/icons/
    mv Flatery-Sky $out/share/icons/
    mv Flatery-Sky-Dark $out/share/icons/
    mv Flatery-Teal $out/share/icons/
    mv Flatery-Teal-Dark $out/share/icons/
    mv Flatery-Yellow $out/share/icons/
    mv Flatery-Yellow-Dark $out/share/icons/
  '';
}
