with import <nixpkgs> {};

stdenv.mkDerivation ({
  name = "dummy";
  buildCommand = "";
  passAsFile = [ "buildCommand" ];
  buildInputs = [
    libnotify
    alsaUtils
  ];
  shellHook = ''
    echo "${libnotify}"
  '';
})
