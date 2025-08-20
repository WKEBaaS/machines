# Nix

<!-- toc -->

- [Setup Machines](#setup-machines)
  * [Prepare Sops Key](#prepare-sops-key)
  * [Prepare Basic Tools](#prepare-basic-tools)
  * [Clone this Repository](#clone-this-repository)
  * [Initialize Kubernetes Cloud](#initialize-kubernetes-cloud)

<!-- tocstop -->

## Setup Machines

### Prepare Sops Key

```sh
mkdir -p ~/.config/sops/age
cat > ~/.config/sops/age/keys.txt
```

### Prepare Basic Tools

```sh
nix-shell -p git just
```

### Clone this Repository

```sh
git clone git@github.com:WKEBaaS/cloud-infra.git ~/.config/nix
```

### Initialize Kubernetes Cloud

> [!INFO]
> hostname: cloud-server, cloud-worker-<n>, cloud-lb

```sh
just cloud-init <hostname>
```
