{stdenv, ...}:
stdenv.mkDerivation {
  name = "zshrc";
  src = ./.;
  installPhase = ''
    mkdir -p $out;
    cp -r \
      *.md \
      LICENSE* \
      LS_COLORS \
      zshrc \
      profile \
      config \
      plugins \
      $out
  '';
}
