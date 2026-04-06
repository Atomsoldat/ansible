# every flake.nix defines a dictionary that contains outputs and inputs keys
{
  # nixpkgs-unstable is similar to debian unstable (rolling release)
  # nix calls this a channel
  # nixpkgs-unstable is a branch on github somewhere which gets updates all the time
  # that is what makes stuff reproducible
  # when we update our packages in this channel, we point at those new commits
  # nixpkgs-unstable is different from nixos-unstable
  # the latter branch requires more tests to pass that ensure a working OS
  # can be built from the packages. Since we are not using NixOS, we don't need 
  # that level of guarantees
  
  
  # a nix flake is a directory containing a flake.nix file and flake.lock
  # it might contain other files, but those are not required
  # like a package manager for e.g. python or JS, the flake.nix defines dependencies
  # which, when installed, get written to flake.lock, so that their version is pinned
  # just like we can define commands in our package.json or pyproject.toml, which our
  # flake.nix can define outputs that can do or represent all kinds of crazy things
  
  # inputs is equal to a dictionary containing a key nixpkgs, which is a dictionary containing a key url, which is equal to a string with a URL in it
  inputs = {
    # a.b is shorthand syntax for dictionaries
    # we are saying that url is a key in the dictionary nixpkgs, which is a key in the dictionary inputs
    # we assign to inputs. the key url is equal to the value of the string we pass after the =
    # key = value;
    # note, that = is not exactly like the assignment in imperative programming languages
    # it's more like the proper mathematical use where "=" means "is"
    # once we say, that something "is" abc , we can not just go and reassign it, because that would be weird
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  }; 
  
  
  
  # we are assigning a function to thing
  # in nix, functions get a single argument (could be a dictionary, could be a string, ...)
  # there's some voodoo magic with currying regarding this, but lets
  # skip that for now. A semicolon ends the definition of the key-value pair
  # in the following case, everything between the = and ; is the function
  # key = {ARGUMENT}: FUNCTION_BODY;
  # so in our case, outputs is equal to a function
  # the arguments of the function come first, and the body of the function comes after the colon
  
  # ... is a way of saying "its okay when other stuff is in the dictionary, dont error out over that"
  # the squiggly braces thing is an argument destructuring, which defines which arguments with which exact names our function takes
  # see https://nix.dev/tutorials/nix-language.html#attribute-set-argument
  # 
  outputs = { nixpkgs, ... }:                                                                                                                                                    
    # let defines a local equation (nix calls this a binding)
    let                                                                                                                                                                                     
      # legacyPackages is just a way that nix flakes can get "the whole can of worms" of available nix packages
      # it is legacy in the sense, that the flakes people would like something tidier than what currently exists
      # but that thing seems to not be there yet
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    # in defines the scope where this local equation / binding is available
    in                                                                                                                                                                                      
    { 
      packages.x86_64-linux.default = pkgs.buildEnv {
        name = "k8s-packages"; 
        # paths is the list of packages to include
        # with temporarily injects all keys of the pkgs dictionary into our current scope
        # if we did not use with here, we could prefix each package name with "pkgs."
        #  [ ... ] defines a list as usual
        paths = with pkgs; [
          kubectl
	  minikube
  	  k9s
        ];
      };
    # this semicolon ends the value definition that is equal to outputs
    };
}
