{ fetchurl,
  godotBin,
  msbuild,
  dotnetPackages,
  mono5,
  zlib
}:

let
  qualifier = "stable";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-mono-bin";
  version = "4.2.1";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/mono/Godot_v${version}-${qualifier}_mono_linux_x86_64.zip";
    sha256 = "kYC6b2elFvSdI0wcTDn1K/ZQ7fQXoskEVvXORY+fEEE=";
  };

  buildInputs = oldAttrs.buildInputs ++ [zlib];

  unpackCmd = "";
  installPhase = ''
    mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${version}-${qualifier}_mono_linux.x86_64 $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_linux.x86_64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_linux.x86_64 $out/bin/godot-mono
  '';

  postFixup = ''
    wrapProgram $out/bin/godot-mono \
      --set LD_LIBRARY_PATH ${oldAttrs.libraries}
  '';
})
