freebox_wifi_on-off
===================

Script Perl qui allume ou eteint le module wifi de la freebox V5 à distance en ligne de commande et/ou via interface web.

(Je n'ai jamais eu l'occasion d'avoir une freebox V6 en ma possession : c'est plus simple pour rebooter et pas besoin de X10, voir http://linuxfr.org/forums/programmation-shell/posts/controle-de-la-freebox-v6-par-le-shell-wifi-reboot ou http://www.freebox-v6.fr/wiki/index.php?title=API )

Sous Debian et dérivés (GNU/Linux) :
```bash
sudo apt-get update
sudo apt-get install git libnet-ssleay-perl libhtml-treebuilder-xpath-perl libwww-mechanize-perl
git clone https://github.com/sputnick-dev/freebox_wifi_on-off.git
cd freebox_wifi_on-off
chmod +x freebox_wifi_on-off.pl
./freebox_wifi_on-off.pl
Usage : ./free-wifi_on-off.pl <on>|<off>|<switch>|<status>
```

Pour les autres systèmes d'exploitation, voir les tutoriels sur le web.


Pour ceux qui veulent appeller le script depuis une page web (pratique pour avoir le wifi facilement depuis votre smartphone), vous pouvez utiliser la page php freebox_wifi_on-off.php.
Les prérequis sont : 

 - un PC disponible pour servir de serveur web et de commutateur X10
 - un serveur web (voir http://wiki.debian.org/LaMp )
 - du matériel X10 (si on veux pouvoir rebooter la freebox automatiquement). Sans X10, il modifie pour vous la console web free.fr sans rebooter la freebox. Voir http://fr.wikipedia.org/wiki/X10_%28informatique%29
 - des connaissances rudimentaires en administration système

Il faut aussi adapter les PATH dans le script et configurer sudo :

chez moi, après avoir tapé visudo : 
```bash
Host_Alias LOCAL=10.0.0.1
http            LOCAL=NOPASSWD: /usr/bin/heyu
```
