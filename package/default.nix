{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
}:

buildDotnetModule (finalAttrs: {
  pname = "http-proxy-with-credential-manager";
  version = "0.0.4";

  src = fetchFromGitHub {
    owner = "slp-tongji";
    repo = "HttpProxyWithCredentialManager";
    rev = "v${finalAttrs.version}";
    hash = "sha256-taql5qTqWFpyqDgXTg9YqiB3FcM+CWZ1Jbfvtqbo76Q=";
  };

  projectFile = "src/HttpProxyWithCredentialManager/HttpProxyWithCredentialManager.csproj";
  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.aspnetcore_10_0;

  nugetDeps = ./deps.nix;

  strictDeps = true;
  __structuredAttrs = true;

  meta = {
    description = "An HTTP proxy server with a credential manager API for creating, querying and revoking proxy credentials.";
    homepage = "https://github.com/slp-tongji/HttpProxyWithCredentialManager";
    license = lib.licenses.mit;
    mainProgram = "HttpProxyWithCredentialManager";
    maintainers = [ ];
  };
})
