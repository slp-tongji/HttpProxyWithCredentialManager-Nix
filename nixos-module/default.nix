{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.http-proxy-with-credential-manager;
in
{
  options.services.http-proxy-with-credential-manager = {
    enable = lib.mkEnableOption "HttpProxyWithCredentialManager";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ../package { };
      description = "The HttpProxyWithCredentialManager package to use.";
    };

    proxyPort = lib.mkOption {
      type = lib.types.port;
      description = "Port on which the proxy server listens (on loopback).";
    };

    credentialManagerPort = lib.mkOption {
      type = lib.types.port;
      description = "Port on which the credential manager API listens (on loopback).";
    };

    stateDirectory = lib.mkOption {
      type = lib.types.str;
      default = "http-proxy-with-credential-manager";
      description = "systemd `StateDirectory` (under `/var/lib`) where the credential database is stored.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.http-proxy-with-credential-manager = {
      description = "HttpProxyWithCredentialManager";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        DynamicUser = true;
        StateDirectory = cfg.stateDirectory;
        ExecStart = lib.concatStringsSep " " [
          (lib.getExe cfg.package)
          "run"
          "--proxy-port"
          (toString cfg.proxyPort)
          "--credential-manager-port"
          (toString cfg.credentialManagerPort)
          "--credential-database"
          "/var/lib/${cfg.stateDirectory}/credentials.db"
        ];
        Restart = "on-failure";
      };
    };
  };
}
