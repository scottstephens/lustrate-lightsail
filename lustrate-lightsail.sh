
curl -L https://nixos.org/nix/install | sh
. $HOME/.nix-profile/etc/profile.d/nix.sh # …or open a fresh shell
nix-channel --add https://nixos.org/channels/nixos-22.11 nixpkgs
nix-channel --update
nix-env -f '<nixpkgs>' -iA nixos-install-tools
sudo e2label /dev/xvda1 nixos
sudo mkdir -p /etc/nixos
sudo vi /etc/nixos/configuration.nix

sudo su root

swapFile=$(mktemp /tmp/nixos-infect.XXXXX.swp)
dd if=/dev/zero "of=$swapFile" bs=1M count=$((1*1024))
chmod 0600 "$swapFile"
mkswap "$swapFile"
swapon -v "$swapFile"
exit

nix-env -p /nix/var/nix/profiles/system -f '<nixpkgs/nixos>' -I nixos-config=/etc/nixos/configuration.nix -iA system

sudo chown -R 0:0 /nix
sudo touch /etc/NIXOS
sudo touch /etc/NIXOS_LUSTRATE
echo etc/nixos | sudo tee -a /etc/NIXOS_LUSTRATE

sudo mv -v /boot /boot.bak && sudo /nix/var/nix/profiles/system/bin/switch-to-configuration boot

sudo shutdown -r now
