{config,pkgs, ..}:

{

  environment.systemPackages = with pkgs; [
    gobuster
    ffuf
    sqlmap
    whatweb
    burpsuite
    postman
    jwt-hack
    gtfocli
    hashcat
    # sage
    cyberchef
    steghide
    exiftool
    audacity
    binwalk
    pwntools
    strace
    ghidra
    gdb
    gef
    gnuradio
    bloodhound
    chisel
    responder
    metasploit
    thc-hydra
    zsteg
    termshark
  ];
}
