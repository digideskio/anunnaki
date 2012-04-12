package qdb;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'normal', '.qadd', 'qdb->add($user, $chan, $msg);');
}

sub add {
    my ($username, $channel, $quote) = ($_[1], $_[2], $_[3]);

    $irc::socket->send("PRIVMSG $channel :$quote\r\n");
}

sub grep {
}

1;
