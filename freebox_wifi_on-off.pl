#!/usr/bin/env perl
# ------------------------------------------------------------------
#    made by sputnick in da FreAkY lAb (c) 2009-2012
#    gilles.quenot <AT> gmail <DOT> com
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of version 2 of the GNU General Public
#    License published by the Free Software Foundation.
# ------------------------------------------------------------------
#                                                ,,_
#                                               o"  )@
#                                                ''''
# ------------------------------------------------------------------
#

# 2012-08-10 17:05:25.0 +0200 / sputnick <gilles.quenot *AT* gmail>

# variables à renseigner : interface web de free
my $login = ''; my $password = '';
#my $have_X10 = 'yes'; # si vous utilisez le protocole X10 pour redemarrer votre freebox
my $have_X10 = 'no'; # si vous n'utilisez pas le protocole X10 pour redemarrer votre freebox

# variables du script, ne plus rien toucher sans etre sur de ce quu'on fait
my $loginURL = "https://subscribe.free.fr/login/login.pl";

use strict;
use warnings;
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

die("Il faut renseigner les variables de login...\n") unless $password && $login;
die("Usage : $0 <on>|<off>|<switch>|<status>\n") unless @ARGV;

my $m = WWW::Mechanize->new( autocheck => 1 );
$m->agent_alias( 'Linux Mozilla' );
$m->get($loginURL);
$m->submit_form( fields => {
        login => $login,
        pass => $password
    }
);
my $authreply = $m->content( format => 'text' );
die("Authentification erronée\n") if $authreply =~ /Identifiant incorrect/i;
$m->follow_link( url_regex => qr/fbxcfg\.pl\?id.*tpl=wifi/i );

my $tree = HTML::TreeBuilder::XPath->new_from_content( $m->content );

if ($ARGV[0] eq "status") {
    my $switch = $tree->findvalue( './/*[@name="wifi_disable_radio"]/@value' );

    if ($switch == 0) {
        print "Wifi enabled...\n";
    }
    elsif ($switch == 1) {
        print "Wifi disabled...\n";
    }
    else {
        die "Le site de free a change : Merci de me remonter le BUG !\n";
    }

    exit(0);
}
elsif ($ARGV[0] eq "off") {
    my $rand = $tree->findvalue( './/*[@id="fbxcfgwww_wifi_random"]/@value' );
    my $post_page = $tree->findvalue( './/*[@id="form_wifiexpert"]/@action' );

    $m->post(
        "https://adsl.free.fr/$post_page",
        [
            wifi_random         => $rand,
            wifi_disable_radio  => 1, # Eteindre le module WiFi
            wifi_active         => 0, # Votre réseau WiFi personnel
            wifi_ssid           => $tree->findvalue( './/*[@name="wifi_ssid"]/@value' ),
            wifi_channel_auto   => $tree->findvalue( './/*[@name="wifi_channel_auto"]/@value' ),
            wifi_channel        => $tree->findvalue( './/*[@name="wifi_channel"]/@value' ),
            wifi_ssid_hide      => $tree->findvalue( './/*[@name="wifi_ssid_hid"]/@value' ),
            wifi_key_type       => $tree->findvalue( './/*[@id="fbxcfgwww_wifi_radio_2"]/@value' ),
            wifi_key            => $tree->findvalue( './/*[@id="fbxcfgwww_wifi_text_1"]/@value' ),
            action              => 'update',
            tpl                 => 'wifi'

        ]
    );

    if ($m->status() == 200) {
        print "POST ok\n";
    } else {
        print "POST fails :/\n";
    }

    $have_X10 eq "yes" ? exec("sudo heyu off freebox; sudo heyu on freebox") : print "Vous pouvez redemarrer la freebox\n";
}
elsif ($ARGV[0] eq "on") {
    my $rand = $tree->findvalue( './/*[@id="fbxcfgwww_wifi_random"]/@value' );
    my $post_page = $tree->findvalue( './/*[@id="form_wifiexpert"]/@action' );

    $m->post(
        "https://adsl.free.fr/$post_page",
        [
            wifi_random         => $rand,
            wifi_disable_radio  => 0, # Eteindre le module WiFi
            wifi_active         => 1, # Votre réseau WiFi personnel
            wifi_ssid           => $tree->findvalue( './/*[@name="wifi_ssid"]/@value' ),
            wifi_channel_auto   => $tree->findvalue( './/*[@name="wifi_channel_auto"]/@value' ),
            wifi_channel        => $tree->findvalue( './/*[@name="wifi_channel"]/@value' ),
            wifi_ssid_hide      => $tree->findvalue( './/*[@name="wifi_ssid_hid"]/@value' ),
            wifi_key_type       => $tree->findvalue( './/*[@id="fbxcfgwww_wifi_radio_2"]/@value' ),
            wifi_key            => $tree->findvalue( './/*[@id="fbxcfgwww_wifi_text_1"]/@value' ),
            action              => 'update',
            tpl                 => 'wifi'

        ]
    );

    if ($m->status() == 200) {
        print "POST ok\n";
    } else {
        print "POST fails :/\n";
    }

    $have_X10 eq "yes" ? exec("sudo heyu off freebox; sudo heyu on freebox") : print "Vous pouvez redemarrer la freebox\n";
}
elsif ($ARGV[0] eq "switch") {
    my $rand = $tree->findvalue( './/*[@id="fbxcfgwww_wifi_random"]/@value' );
    my $post_page = $tree->findvalue( './/*[@id="form_wifiexpert"]/@action' );

    $m->post(
        "https://adsl.free.fr/$post_page",
        [
            wifi_random         => $rand,
            wifi_disable_radio  => switch( $tree->findvalue( './/*[@name="wifi_disable_radio"]/@value' )),
            wifi_active         => switch( $tree->findvalue( './/*[@id="wifi_enable_check"]/@value' )),
            wifi_ssid           => $tree->findvalue( './/*[@name="wifi_ssid"]/@value' ),
            wifi_channel_auto   => $tree->findvalue( './/*[@name="wifi_channel_auto"]/@value' ),
            wifi_channel        => $tree->findvalue( './/*[@name="wifi_channel"]/@value' ),
            wifi_ssid_hide      => $tree->findvalue( './/*[@name="wifi_ssid_hid"]/@value' ),
            wifi_key_type       => $tree->findvalue( './/*[@id="fbxcfgwww_wifi_radio_2"]/@value' ),
            wifi_key            => $tree->findvalue( './/*[@id="fbxcfgwww_wifi_text_1"]/@value' ),
            action              => 'update',
            tpl                 => 'wifi'

        ]
    );

    if ($m->status() == 200) {
        print "POST ok\n";
    } else {
        print "POST fails :/\n";
    }

    $have_X10 eq "yes" ? exec("sudo heyu off freebox; sudo heyu on freebox") : print "Vous pouvez redemarrer la freebox\n";
}
else {
    die "Mauvais argument\n";
}

sub switch {
    my $bit = shift;

    return (($bit == 0) ? 1 : 0);
}
