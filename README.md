# seedbox


set up a torrent seed box using Ubuntu 14.04


## dependencies

on your local admin box:

* ansible version >= 2.0
* rsync (optional)

on your remote vps

* ubuntu 14.04


## setup

create an inventory file. example:

```
[seedboxes]
384.283.283.283
```

run the playbook

    ansible-playbook -i ./inventory ./main.yml --ask-pass


ansible will set up the server to run a seedbox. afterwards, add your ssh key to /root/.ssh/authorized_keys and /home/drip/.ssh/authorized_keys

lock down your ssh setup by editing /etc/ssh/sshd_config and removing ability for root to log in using a password.

you can use the example file sync.sh to copy downloaded files from your vps to your local machine.


## web gui

deluge-web is locked down. the only way you can access the web gui is via localhost.

I recommend SSH SOCKS proxy.

first of all, make your live easier by editing the ssh config file on your admin box. ~/.ssh/config

```
Host seedbox
    Hostname 384.283.283.283 
    user drip
    IdentityFile /Users/chris/.ssh/mykey
```

now open a SSH sesh, forwarding port 8822

    ssh -D 8822 seedbox

leave the SSH sesh open, but feel free to minimize it. Now, using your favorite web browser, install FoxyProxy add-on. Create a new rule that says all traffic going to http://localhost:8112 should proxy through localhost on port 8822.

With the FoxyProxy rule in place, go to http://localhost:8112 in your browser. You should see the deluge GUI. If you don't see the deluge gui, go to your SSH session and look at the log outputs for /var/log/syslog, /var/log/upstart/deluged.log and /var/log/upstart/deluge-web.log.

The default password for the web GUI is `deluge`. Now you can add torrents, have them download, then use sync.sh to copy the downloaded files to your admin box.

Happy hacking!