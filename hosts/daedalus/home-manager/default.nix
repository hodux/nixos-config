{ config, ... }:

{
  imports = [
    ./niri.nix
  ];
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/noctalia/daedalus";
  home.file.".config/winapps".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/winapps";

  # temp fix for popups' wrong positioning
  xdg.desktopEntries."idea" = {
    name = "IntelliJ IDEA";
    genericName = "Java, Kotlin, Groovy and Scala IDE from JetBrains";
    comment = "IDE for Java SE, Groovy & Scala development Powerful environment for building Google Android apps Integration with JUnit, TestNG, popular SCMs, Ant & Maven. Also known as IntelliJ.";
    exec = "env -u WAYLAND_DISPLAY idea";
    icon = "idea";
    type = "Application";
    categories = [ "Development" ];
    settings = {
      StartupWMClass = "jetbrains-idea";
      Version = "1.5";
    };
  };
}
