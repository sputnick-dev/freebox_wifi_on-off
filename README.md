freebox_wifi_on-off
===================

Script Perl qui allume ou eteint le module wifi de la freebox à distance en ligne de commande.

Sous Debian et dérivés :
```bash
sudo apt-get update
sudo apt-get install libhtml-treebuilder-xpath-perl libwww-mechanize-perl
git clone https://github.com/sputnick-dev/freebox_wifi_on-off.git
cd freebox_wifi_on-off
chmod +x freebox_wifi_on-off.pl
./freebox_wifi_on-off.pl
```

Il est prévu à la base pour une utilisation avec le protocole de domotique X10 http://fr.wikipedia.org/wiki/X10_%28informatique%29 afin de redémarrer la Freebox automatiquement.

Sans X10, il modifie pour vous la console web free.fr sans rebooter la freebox.
