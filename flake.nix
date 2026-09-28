{
  description = "Nix packaging for HttpProxyWithCredentialManager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (
        system:
        let
          package = nixpkgs.legacyPackages.${system}.callPackage ./package { };
        in
        {
          http-proxy-with-credential-manager = package;
          default = package;
        }
      );

      nixosModules =
        let
          module = ./nixos-module;
        in
        {
          http-proxy-with-credential-manager = module;
          default = module;
        };
    };
}
