package twitter;

use strict;
use warnings;
use Twitter::Badge;

BEGIN {
    triggers->add('channel', 'peasant', '.twitter', 'twitter->status($chan, $msg);');
}

sub status {
    my($chan, @data) = ($_[1], split " ", $_[2]);
    my $id = $data[1];

    my $t = Twitter::Badge->new(id => $id);
    $t->fetch();

    $irc::socket->send("PRIVMSG $chan :<$t->name> $t->text\r\n");
  
}

1;
