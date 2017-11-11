{ pkgs, libnotify, alsaUtils }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "dunsted-volume";
  version = "0.1.0";

  name = "${pname}-${version}";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ libnotify alsaUtils ];

  installPhase = with stdenv.lib; ''
    install -v -D -m755 ./volume.sh $out/bin/dunsted-volume

    wrapProgram "$out/bin/dunsted-volume" \
      --prefix PATH : ${ makeBinPath [libnotify alsaUtils] }
  '';
}
