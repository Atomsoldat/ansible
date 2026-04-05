
Test whether the nix flake works
```bash
nix build '.#default'
```

Install packages from our flake
```bash
nix profile install '.#default'
```


Rebuild profile from `flake.nix` (do this when we add packages)
```bash
nix profile upgrade 'ansible'
```

Upgrade package versions (when we want to move the nixpkgs pin forward)
```bash
nix flake update
nix profile upgrade 'ansible'
```
