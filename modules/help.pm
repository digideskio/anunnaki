package help;

use strict;
use warnings;


BEGIN {
    triggers->add('channel', 'peasant', '.help', 'help->display($user, $msg);');
}

sub display {
    my ($user, @data) = ($_[1], split " ", $_[2]);
   
    if(!$data[1]) {
        $irc::socket->send("NOTICE $user :Usage: .help <argument>\r\n");
        $irc::socket->send("NOTICE $user :commands\r\n");
        $irc::socket->send("NOTICE $user :games\r\n");

    } elsif($data[1] eq 'commands') {
	$irc::socket->send("NOTICE $user :Still working on this feature\r\n");
    } elsif($data[1] eq 'games') {
	$irc::socket->send("NOTICE $user :jewgolds, kingpin, annoy\r\n");
    }
}

1;
