{ inputs, ... }:
let
  rust-overlay = inputs.rust-overlay.overlays.default;
in
{
  default = final: prev: (rust-overlay final prev);
}
