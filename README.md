# lustrate-lightsail
Install NixOS on an AWS Lightsail VM using the lustrate method.

## Usage

Launch a lightsail instance using Debian 11, then follow the script.

At the point where it has you write configuration.nix, use this as the starting point:

```
{ config, pkgs, modulesPath, ... }:
{
  imports = [ "${modulesPath}/virtualisation/amazon-image.nix" ];
  ec2.hvm = true;

  system.stateVersion = "22.11";
}
```

## Notes

It's not easy to test on lightsail directly because there's no way of seeing what goes wrong when an instance doesn't boot. However, lightsail instances are really just ec2 instances under the hood. If you're having problems, find the ec2 instance most similar to the type you care about that is on the Nitro platform, and then use the serial console to see what's going wrong with the boot.
