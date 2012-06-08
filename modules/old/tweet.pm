package twitter;

use strict;
use warnings;
use Net::Twitter;
use Scalar::Util 'blessed';

BEGIN {
    triggers->add('channel', 'god', '.twitter', 'twitter->parse($chan);');
}

sub parse {
#    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $chan = $_[1];

    $irc::socket->send("PRIVMSG $chan :test\r\n");
    my $nt = Net::Twitter->new(
	traits 		=> [qw/OAuth API::REST/],
	consumer_key	=> 'Vp3dCCmVfRDyuYfV5hJqw',
	consumer_secret	=> '6eqRwslLMsxasUXmPVd5g3yLO3puSd2rpgVmynMr5UM',
	access_token	=> '236977665-eZw7f48JSrlHma7rbU1uUpe3jOjOJbvimMfPAYMK',
	access_token_secret => 'ccvTKAxChyqAcoo86EkcHRprwafVij6O9YsI7dbn7A'
    );



    $irc::socket->send("PRIVMSG $chan :$nt->account_settings\r\n");

#    for my $status (@$r) {
#	$irc::socket->send("PRIVMSG $chan :$r->user->screen_name\r\n");
#    }

#    eval {
#        my $statuses = $nt->friends_timeline({count => 10});
#        for my $status (@$statuses) {
#            $irc::socket->send("PRIVMSG $chan :$status->{created_at} <$status->{user}{screen_name}> $status->{text}\r\n");
#        }
#    };


}

1;
