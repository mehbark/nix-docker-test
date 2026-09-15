{
  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.dockerTools.buildLayeredImage {
      name = "ghcr.io/mehbark/nix-docker-test";
      tag = "latest";

      contents = [
        pkgs.fish
        pkgs.bsdgames
      ];

      config = {
        Cmd = [ "${pkgs.lib.getExe pkgs.fish}" ];
        Env = [ "PATH=${pkgs.bsdgames}/bin:$PATH" ];
      };
    };
  };
}
