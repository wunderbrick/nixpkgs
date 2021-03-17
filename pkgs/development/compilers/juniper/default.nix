{ lib, stdenv, writeTextFile, fetchzip, mono }:

stdenv.mkDerivation rec {
  pname = "juniper";
  version = "2.3.0";

  src = fetchzip {
    url = "http://www.juniper-lang.org/installers/Juniper-2.3.0.zip";
    sha256 = "10am6fribyl7742yk6ag0da4rld924jphxja30gynzqysly8j0vg";
    stripRoot = false;
  };

  doCheck = true;

  buildInputs = [ mono ];

  installPhase = ''
    rm juniper # original script with regular Linux assumptions
    mkdir -p $out/bin
    cp -r ./* $out
    echo -e "#!/bin/sh\n\n${mono}/bin/mono $out/Juniper.exe \$@" > $out/bin/juniper
    chmod +x $out/bin/juniper
  '';

  meta = with lib; {
    description = "Functional reactive programming language for programming Arduino";
    longDescription = ''
      Juniper targets Arduino and supports many features typical of functional programming languages, including algebraic data types, tuples, records, pattern matching, immutable data structures, parametric polymorphic functions, and anonymous functions (lambdas). Some imperative programming concepts are also present in Juniper, such as for, while and do while loops, the ability to mark variables as mutable, and mutable references.
    '';
    homepage = "https://http://www.juniper-lang.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ wunderbrick ];
    platforms = platforms.linux;
  };
}
