{stdenv, ...}:
stdenv.mkDerivation {
  name = "zshrc";
  src = ./.;
  installPhase = ''
    mkdir -p $out;
    cp -r \
      *.md \
      LICENSE* \
      zshrc \
      profile \
      config \
      plugins \
      $out
  '';
}
