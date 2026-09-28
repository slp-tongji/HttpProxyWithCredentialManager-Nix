# HttpProxyWithCredentialManager-Nix

Nix packaging for [HttpProxyWithCredentialManager](https://github.com/slp-tongji/HttpProxyWithCredentialManager) — an HTTP proxy server with a credential manager API for creating, querying and revoking proxy credentials.

## Adding as a flake input

```nix
{
  inputs = {
    http-proxy-with-credential-manager.url = "github:slp-tongji/HttpProxyWithCredentialManager-Nix";
  };
}
```

## Package

The binary is exposed as `HttpProxyWithCredentialManager`:

```nix
http-proxy-with-credential-manager.packages.${system}.http-proxy-with-credential-manager
```

Or try it directly from the CLI:

```console
$ nix shell github:slp-tongji/HttpProxyWithCredentialManager-Nix
$ HttpProxyWithCredentialManager run \
    --proxy-port 8080 \
    --credential-manager-port 8081 \
    --credential-database /tmp/credentials.db
```

## NixOS module

A module is exposed as `nixosModules.http-proxy-with-credential-manager` (also
available as `nixosModules.default`):

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    http-proxy-with-credential-manager.url = "github:slp-tongji/HttpProxyWithCredentialManager-Nix";
  };

  outputs = { nixpkgs, http-proxy-with-credential-manager, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [
        http-proxy-with-credential-manager.nixosModules.default
        {
          services.http-proxy-with-credential-manager = {
            enable = true;
            proxyPort = 8080;
            credentialManagerPort = 8081;
          };
        }
      ];
    };
  };
}
```

The module runs the service as a systemd unit with a dynamic system user and a
`StateDirectory` for the credential database.

Options under `services.http-proxy-with-credential-manager`:

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `enable` | bool | `false` | Whether to enable the service |
| `package` | package | this flake's package | The package to install |
| `proxyPort` | port | (required) | Port the proxy server listens on (loopback) |
| `credentialManagerPort` | port | (required) | Port the credential manager API listens on (loopback) |
| `stateDirectory` | str | `"http-proxy-with-credential-manager"` | systemd `StateDirectory` (under `/var/lib`) holding the credential database |

---

All documentation and `description` fields in this repository are AI-generated.
