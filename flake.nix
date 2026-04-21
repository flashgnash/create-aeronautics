{
  description = "Modpack development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    packwiz-tui.url = "github:flashgnash/packwiz-tui";
  };

  outputs =
    {
      self,
      nixpkgs,
      packwiz-tui,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.packwiz
              packwiz-tui.packages.${system}.default
            ];
          };
        }
      );
    };
}
