{ lib, stdenv, makeWrapper, libnotify, alsaUtils }:

stdenv.mkDerivation rec {
  pname = "dunsted-volume";
  version = "0.1.0";

  name = "${pname}-${version}";

  src = ./volume.sh;

  unpackPhase = ":";

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ libnotify alsaUtils ];

  installPhase = ''
    install -v -D -m755 $src $out/bin/dunsted-volume

    wrapProgram "$out/bin/dunsted-volume" \
      --prefix PATH : ${ lib.makeBinPath [libnotify alsaUtils] }
  '';
}
