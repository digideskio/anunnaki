package test;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'god', '.testing', 'test->parse($chan);');
}

sub parse {
    my $chan = $_[1];
   
    $irc::socket->send("PRIVMSG $chan :test\r\n");

}

1;
