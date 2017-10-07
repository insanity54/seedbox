# Seedbox

## Setup Process

Create user

    sudo useradd seeder

Grant sudo access

    sudo usermod -a -G sudo

create password for user

    sudo passwd seeder

Install deluge torrent software

    sudo apt-get install -y deluge-console deluge

Set your deluge webui password in `~/.config/deluge/auth`

    seeder:rosebud:10

Block world access to deluge web ui (greets https://serverfault.com/a/247180/186759)

    iptables -A INPUT -p tcp -s localhost --dport 25 -j ACCEPT
    iptables -A INPUT -p tcp --dport 25 -j DROP

In local machine (not seedbox) create /etc/hosts definition:

    28.348.212.83    seedbox

In local machine (not seedbox) set up Foxyproxy configuration in your browser of choice

    GENERAL
      Proxy Name: seedbox
    
    PROXY DETAILS
      Manual Proxy Configuration: true
      Server or IP Address: 127.0.0.1
      Port: 8822
      SOCKS proxy?: true
      SOCKS v5: true

    URL Patterns
      Enabled    Pattern Name    URL pattern        Whitelist (inclusive)
      true       seedbox         http://seedbox/*   Whitelist


In local machine (not seedbox) create an SSH config in ~/.ssh/config

    Host seedbox
    Hostname 28.348.212.83
    user seeder
    IdentityFile /Users/lol/.ssh/id_rsa
    DynamicForward 8822


Now when you create a fresh SSH session into your seedbox using `ssh seedbox`, you can access the webui in your browser through your private SOCKS proxy via Foxyproxy.

    http://seedbox:8112/

    