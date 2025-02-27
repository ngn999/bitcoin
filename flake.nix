{
  description = "A development environment for Bitcoin Core";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = false; # Bitcoin Core 是自由软件，不需要非自由依赖
            # 你可以在这里添加其他的 Nix 配置，比如优化编译参数
          };
        };
      in
      {
        devShell = pkgs.mkShell.override { stdenv = pkgs.llvmPackages_22.stdenv; } {
          buildInputs = with pkgs; [
            cmake
            # 添加编译 Bitcoin Core 需要的最小依赖
            # 如果需要，可以在此基础上添加其他依赖项
            git
            boost
            pkg-config
            libevent
            sqlite

            # capnproto
            #
            # # gui
            # qt6.qtbase
            # qt6.qttools
            # qrencode
            # 根据需要关闭的特性，添加相应的依赖
            # 比如，如果不需要钱包功能，你可以不包含 db4 等
          ];
          # cmake 的具体开关（BUILD_TESTS 等）交给 CMakeUserPresets.json 的
          # "non-gui" preset 管理：cmake --preset non-gui
          shellHook = ''
            echo "Welcome to the Bitcoin Core development environment!"
            echo "You can now build Bitcoin Core with the provided dependencies."
          '';
        };
      }
    );
}
