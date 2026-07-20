./dotnet-install.ps1 -Channel LTS
./dotnet-install.ps1 -Channel 6.0.1xx -Quality preview -InstallDir C:\cli
./dotnet-install.ps1 -Runtime dotnet -Version 6.0.0
Invoke-WebRequest 'https://dot.net/v1/dotnet-install.ps1' -Proxy $env:HTTP_PROXY -ProxyUseDefaultCredentials -OutFile 'dotnet-install.ps1';
./dotnet-install.ps1 -InstallDir '~/.dotnet' -Version '6.0.2' -Runtime 'dotnet' -ProxyAddress $env:HTTP_PROXY -ProxyUseDefaultCredentials;
# Run a separate PowerShell process because the script calls exit, so it will end the current PowerShell session.
&powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) <additional install-script args>"
:~ $ ./dotnet-install.sh --channel 9.0 --install-dir local-dotnet  # installs the latest 9 SDK to the specified directory
dotnet-install: Attempting to download using aka.ms link https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.303/dotnet-sdk-9.0.303-linux-x64.tar.gz
dotnet-install: Remote file https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.303/dotnet-sdk-9.0.303-linux-x64.tar.gz size is 218004272 bytes.
dotnet-install: Extracting archive from https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.303/dotnet-sdk-9.0.303-linux-x64.tar.gz
dotnet-install: Downloaded file size is 218004272 bytes.
dotnet-install: The remote and local file sizes are equal.
dotnet-install: Installed version is 9.0.303
dotnet-install: Adding to current process PATH: `$HOME/local-dotnet`. Note: This change will be visible only when sourcing script.
dotnet-install: Note that the script does not resolve dependencies during installation.
dotnet-install: To check the list of dependencies, go to https://learn.microsoft.com/dotnet/core/install, select your operating system and check the "Dependencies" section.
dotnet-install: Installation finished successfully.
:~ $ ./local-dotnet/dotnet --list-runtimes # see what runtimes we have available
Microsoft.AspNetCore.App 9.0.7 [$HOME/local-dotnet/shared/Microsoft.AspNetCore.App]
Microsoft.NETCore.App 9.0.7 [$HOME/local-dotnet/shared/Microsoft.NETCore.App]
:~ $ ./local-dotnet/dotnet --list-sdks # see what SDKs we have available
9.0.303 [$HOME/local-dotnet/sdk]
:~ $ ./dotnet-install.sh --channel 8.0 --install-dir local-dotnet --skip-non-versioned-files # install the 8 SDK to the same place, but keep the 9 dotnet binaries
dotnet-install: Attempting to download using aka.ms link https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-linux-x64.tar.gz
dotnet-install: Remote file https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-linux-x64.tar.gz size is 216096947 bytes.
dotnet-install: Extracting archive from https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-linux-x64.tar.gz
dotnet-install: Downloaded file size is 216096947 bytes.
dotnet-install: The remote and local file sizes are equal.
dotnet-install: Installed version is 8.0.412
dotnet-install: Adding to current process PATH: `$HOME/local-dotnet`. Note: This change will be visible only when sourcing script.
dotnet-install: Note that the script does not resolve dependencies during installation.
dotnet-install: To check the list of dependencies, go to https://learn.microsoft.com/dotnet/core/install, select your operating system and check the "Dependencies" section.
dotnet-install: Installation finished successfully.
:~ $ ./local-dotnet/dotnet --list-runtimes # we should have 8 and 9 Runtimes now
Microsoft.AspNetCore.App 8.0.18 [$HOME/local-dotnet/shared/Microsoft.AspNetCore.App]
Microsoft.AspNetCore.App 9.0.7 [$HOME/local-dotnet/shared/Microsoft.AspNetCore.App]
Microsoft.NETCore.App 8.0.18 [$HOME/local-dotnet/shared/Microsoft.NETCore.App]
Microsoft.NETCore.App 9.0.7 [$HOME/local-dotnet/shared/Microsoft.NETCore.App]
:~ $ ./local-dotnet/dotnet --list-sdks # we should have 2 SDKs now
8.0.412 [$HOME/local-dotnet/sdk]
9.0.303 [$HOME/local-dotnet/sdk]
