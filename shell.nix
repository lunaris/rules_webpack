{ pkgs ? import ./nix/nixpkgs.nix {} }:

with pkgs;

let
  nodeShell = (import ./nix/node {}).shell;

in
  mkShell {
    # Prevent Bazel using any toolchains provided by Xcode to improve uniformity
    # across OSX/Linux platforms.
    BAZEL_USE_CPP_ONLY_TOOLCHAIN=1;

    buildInputs = [
      bazel
      git
      nix
      nodePackages_10_x.node2nix
      nodePackages_10_x.npm
    ] ++ nodeShell.buildInputs;
  }
