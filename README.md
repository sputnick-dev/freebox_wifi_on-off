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
Usage : ./free-wifi_on-off.pl <on>|<off>|<switch>|<status>
```

Il est prévu à la base pour une utilisation avec le protocole de domotique X10 http://fr.wikipedia.org/wiki/X10_%28informatique%29 afin de redémarrer la Freebox automatiquement.

Sans X10, il modifie pour vous la console web free.fr sans rebooter la freebox.


Pour ceux qui veulent appeller le script depuis une page web (pratique pour avoir le wifi facilement depuis votre smartphone), vous pouvez utiliser la page php freebox_wifi_on-off.php. Il faut adapter les PATH dans le script et configurer sudo :
Chez moi, après avoir tapé visudo : 
```bash
Host_Alias LOCAL=10.0.0.1
http            LOCAL=NOPASSWD: /usr/bin/heyu
```
