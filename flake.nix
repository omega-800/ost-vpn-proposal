{
  description = "typst development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      typix,
      ...
    }:
    let
      systems = nixpkgs.lib.platforms.unix;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = { };
              overlays = [ ];
            }
          )
        );
      mkApp = drv: {
        type = "app";
        program = "${drv}${drv.passthru.exePath or "/bin/${drv.pname or drv.name}"}";
      };
      typixPkgs =
        pkgs:
        let
          typixLib = typix.lib.${pkgs.system};
          commonArgs = {
            typstSource = "main.typ";
            fontPaths = with pkgs; [
              "${nerd-fonts.jetbrains-mono}/share/fonts/truetype"
              "${fira-math}/share/fonts/opentype"
              "${fira-code}/share/fonts/truetype"
              "${nerd-fonts.arimo}/share/fonts/truetype"
            ];
            virtualPaths = [ ];
          };
          inherit (pkgs) lib;
          extraArgs = {
            src = lib.cleanSourceWith {
              src = lib.cleanSource ./.;
              filter =
                path: type:
                let
                  hasAcceptedSuffix = builtins.any (lib.flip lib.hasSuffix path) [
                    ".typ"
                    ".bib"
                    ".png"
                    ".md"
                  ];
                  isSpecialFile = builtins.elem (builtins.baseNameOf path) [
                    "typst.toml"
                    "metadata.toml"
                  ];
                in
                builtins.any lib.id [
                  (type == "directory")
                  hasAcceptedSuffix
                  isSpecialFile
                ];
            };
            unstable_typstPackages = [ ];
          };
          sources = [
            "vpn.typ"
            "main.typ"
          ];
          watchScriptsPerDoc = map (
            typstSource:
            typixLib.watchTypstProject (
              commonArgs
              // {
                inherit typstSource;
                typstOutput = (pkgs.lib.removeSuffix ".typ" typstSource) + ".pdf";
              }
            )
          ) sources;
          watch-script = typixLib.watchTypstProject commonArgs;
        in
        {
          inherit typixLib commonArgs extraArgs watch-script;
          build-drv = typixLib.buildTypstProject (commonArgs // extraArgs);
          build-script = typixLib.buildTypstProjectLocal (commonArgs // extraArgs);
          watch-all = pkgs.writeShellApplication {
            text = "(trap 'kill 0' SIGINT; ${
              pkgs.lib.concatMapStringsSep " & " (s: "${s}/bin/typst-watch") watchScriptsPerDoc
            })";
            name = "typst-watch-all";
          };
          watch-open = pkgs.writeShellApplication {
            text = "${pkgs.writeShellScript "watch-with-zathura" ''
              ${pkgs.zathura}/bin/zathura "$PWD/${builtins.replaceStrings [".typ"] [""] commonArgs.typstSource}.pdf" &
              ${(mkApp watch-script).program}
              ''}";
            name = "typst-watch-open";
          };
        };
    in
    {
      packages = eachSystem (pkgs: {
        default = (typixPkgs pkgs).build-drv;
      });

      apps = eachSystem (
        pkgs:
        let
          inherit (typixPkgs pkgs) watch-script build-script watch-open;
          wopen = mkApp watch-open;
        in
        {
          inherit wopen;
          default = wopen;
          build = mkApp build-script;
          watch = mkApp watch-script;
        }
      );

      devShells = eachSystem (
        pkgs:
        let
          inherit (typixPkgs pkgs)
            watch-script
            build-script
            watch-all
            commonArgs
            typixLib
            ;
        in
        {
          default = typixLib.devShell {
            inherit (commonArgs) fontPaths virtualPaths;
            packages = [
              watch-all
              build-script
              watch-script
              pkgs.typstfmt
            ];
          };
        }
      );
    };
}
