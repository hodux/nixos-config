{ ... }:

{
  fileSystems."/" = { 
    device = "/dev/null"; 
    fsType = "ext4";
  };
}