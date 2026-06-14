{ self, ... }: {
  flake.nixosModules.libfprintPatch = { ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        libfprint = prev.libfprint.overrideAttrs (old: {
          patches = (old.patches or []) ++ [
            "${self}/modules/features/libfprint-elanmoc-0c5a.patch"
          ];
        });
      })
    ];
  };
}
