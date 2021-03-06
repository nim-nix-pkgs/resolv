{
  description = ''DNS resolution nimble making use of the native glibc resolv library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."resolv-master".dir   = "master";
  inputs."resolv-master".owner = "nim-nix-pkgs";
  inputs."resolv-master".ref   = "master";
  inputs."resolv-master".repo  = "resolv";
  inputs."resolv-master".type  = "github";
  inputs."resolv-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."resolv-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}