{
  description = "latex env";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { utils, nixpkgs, ... }: utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
    }; 
    tex = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-full luatex latexmk;
    };
    findlatexmk = (with pkgs; stdenv.mkDerivation {
      pname = "findlatexmk";
      version = "0.2";
      src = fetchgit {
        url = "https://github.com/kprussing/FindLatexmk";
        rev = "0.2";
        sha256 = "sha256-fr7T8tEFolK6n4qnAJTHZlgOfWznwvMxCqWNT32A4zE=";
      };
      nativeBuildInputs = [
        tex
        cmake
      ];
      installPhase = ''
        mkdir -p $out/include
        mv $TMP/FindLatexmk/build/FindLatexmk.cmake $out/include
      '';
    });
  in {
    devShells.default = pkgs.mkShell {
      name = "latex env";
      packages = with pkgs; [
        cmake
        tex
        findlatexmk
      ];
    };
  });
}
