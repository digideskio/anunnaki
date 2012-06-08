package lord;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'lord', '.nmap', 'lord->portscan($user, $chan, $msg);');
    triggers->add('channel', 'lord', '.whois', 'lord->whois($chan, $msg);');
}

sub portscan {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);

    my $ip = $data[1];
    my @out = `nmap -v $ip`;

    foreach my $line (@out) {
	$irc::socket->send("PRIVMSG $chan :$line\r\n");
    }
}

sub whois {
    my ($chan, @data) = ($_[1], split " ", $_[2]);

    my $domain = $data[1];
    my @out = `whois $domain`;

    foreach my $line (@out) {
	$irc::socket->send("PRIVMSG $chan :$line\r\n");
    }
}

sub trace {
    my ($chan, @data) = ($_[1], split " ", $_[2]);

    my $ip = $data[1];
    my @out = `traceroute $ip`;

    foreach my $line (@out) {
	$irc::socket->send("PRIVMSG $chan :$line\r\n");
    }
}



1;

