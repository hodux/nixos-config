{ pkgs, inputs, system, ... }:

{
  imports = [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];

  services.lact.enable = true;
  services.wivrn.enable = true;
  services.wivrn.openFirewall = true;
  programs.weylus.enable = true;
  programs.weylus.openFirewall = true;
  environment.systemPackages = with pkgs; [
    prismlauncher
    wootility
    # cisco-packet-tracer_9
    protonup-qt
    wayvr
    xrizer
    lutris
    parsec-bin
    davinci-resolve
    ananicy-cpp
    ananicy-rules-cachyos
  ];
}
