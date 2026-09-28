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

---

All documentation and `description` fields in this repository are AI-generated.
