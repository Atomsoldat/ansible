
Test whether the nix flake works (apparently, the `#default`-bit is implicit, if we do not pass it)
```bash
nix build '.#default'
nix build .
```

Install packages from our flake
```bash
nix profile install '.#default'
nix profile install .
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
