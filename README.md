# dunsted-volume
for nixos

# Installation

Derivation for local install

```nix
{ stdenv, fetchFromGitHub, pkgs, makeWrapper }:

stdenv.mkDerivation rec {
  name = "dunsted-volume-${version}";
  version = "0.1";

  src = /home/bjorn/projects/dunsted-volume;

  buildInputs = [ pkgs.libnotify pkgs.alsaUtils ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = with stdenv.lib; with pkgs; ''
    install -v -D -m755 ./volume.sh $out/bin/dunsted-volume

    wrapProgram "$out/bin/dunsted-volume" \
      --prefix PATH : ${ makeBinPath [libnotify alsaUtils] }
  '';
}
```

full example [here](https://github.com/BjornMelgaard/dotfiles/blob/8321fcef585ed2ea8b9f1f9798af9d9172e5668d/nixos/pkgs/dunsted-volume/default.nix), [here](https://github.com/BjornMelgaard/dotfiles/blob/8321fcef585ed2ea8b9f1f9798af9d9172e5668d/nixos/pkgs/all-packages.nix), [here](https://github.com/BjornMelgaard/dotfiles/blob/8321fcef585ed2ea8b9f1f9798af9d9172e5668d/nixos/root/system-packages.nix#L65), [here](https://github.com/BjornMelgaard/dotfiles/blob/8321fcef585ed2ea8b9f1f9798af9d9172e5668d/i3/config#L104)
