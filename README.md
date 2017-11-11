# dunsted-volume
for nixos

# Installation

## Systemwide

Add this to your configuration.nix

```nix
environment.systemPackages = [
  dunsted-volume
];

nixpkgs.config.packageOverrides = super: {
  dunsted-volume = callPackage (fetchFromGitHub {
    owner = "BjornMelgaard";
    repo = "dunsted-volume";
    rev = "ac5136d87c16dd93c8c58e7db8b6d07a76f8faa5";
    sha256 = "13w2b73952lfpg85mk4zc8fdjbx1rpva1hldmh70dnnmp2f2mc8a";
  }) {};
};
```

To update just refresh `rev` and `sha256`, generated with `nix-prefetch-git https://github.com/BjornMelgaard/dunsted-volume`


## Local copy
```nix
nixpkgs.config.packageOverrides = super: {
  dunsted-volume = callPackage /home/bjorn/projects/dunsted-volume {};
};
```
