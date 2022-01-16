{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "flatery-icon-theme";
  version = "git";
  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Flatery";
    rev = "cdd59fa55c5116e7ff9dbeb470fde9348c9cd1b7";
    sha256 = "0kpfzf7viqmbym6w02sg8ql3gqrb53b59fi8bb41x12j9xbrsr3v";
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
