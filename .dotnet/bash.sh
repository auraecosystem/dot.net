# gpg --import dotnet-install.asc
sudo apt install gpg wget https://dot.net/v1/dotnet-install.asc
gpg --import dotnet-install.asc
gpg --verify dotnet-install.sig dotnet-install.sh
sudo apt install gpg
wget https://dot.net/v1/dotnet-install.asc
gpg --import dotnet-install.asc
wget https://dot.net/v1/dotnet-install.sh
wget https://dot.net/v1/dotnet-install.sig
gpg --verify dotnet-install.sig dotnet-install.sh
