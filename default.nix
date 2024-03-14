{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) callPackage;
in
rec {
  godot = callPackage ./pkgs/godot { };
  godotMono = callPackage ./pkgs/godot/mono.nix {
    godotBin = godot;
  };
}
