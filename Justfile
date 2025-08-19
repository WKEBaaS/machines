# just is a command runner, Justfile is very similar to Makefile, but simpler.

# TODO update hostname here!
hostname := `if [ "$(uname)" = "Darwin" ]; then scutil --get LocalHostName; else hostname -s; fi`

############################################################################
#
#  NixOS related commands
#
############################################################################
[group('nixos')]
cloud-init new-hostname:
  # This command is used to setup a new NixOS machine with a cloud-init configuration.
  # It will create a new cloud-init configuration file and then run the nixos-rebuild command.
  sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --upgrade --flake .#{{new-hostname}} \
    --impure --extra-experimental-features 'nix-command flakes'
  
[group('nixos')]
nixos:
  sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --upgrade --flake .#{{hostname}} --impure

############################################################################
#
#  nix related commands
#
############################################################################

# List all the just commands
default:
    @just --list

# Update all the flake inputs
[group('nix')]
up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}}

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

