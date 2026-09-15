{
  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    self-pkgs = self.packages.${system};
  in {
    packages.${system} = {
      default = pkgs.dockerTools.buildLayeredImage {
        name = "ghcr.io/mehbark/nix-docker-test";
        tag = "latest";

        config = {
          Cmd = [ "${pkgs.lib.getExe self-pkgs.waste-cpus}" ];
        };
      };

      waste-cpus = pkgs.writeShellApplication {
        name = "waste-cpus";

        text = ''
          for i in $(seq $(nproc)); do
            waste-cpu &
          done
        '';

        runtimeInputs = [
          self-pkgs.waste-cpu
          pkgs.coreutils
        ];
      };

      waste-cpu = pkgs.stdenv.mkDerivation {
        pname = "waste-cpu";
        version = "0.1.0";
        meta.mainProgram = "waste-cpu";

        installPhase = ''
          mkdir -p $out/bin
          mv main $out/bin/waste-cpu
        '';

        src = ./waste-cpu;

        buildInputs = [ pkgs.gcc ];
      };
    };
  };
}
