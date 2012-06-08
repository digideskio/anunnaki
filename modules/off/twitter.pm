package twitter;

use strict;
use warnings;
use Net::Twitter::Lite;

BEGIN {
    triggers->add('channel', 'god', '.twit', 'twitter->parse($user, $chan, $msg);');
}

sub parse {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);

    my $nt = Net::Twitter::Lite->new(
	consumer_key	=> 'Vp3dCCmVfRDyuYfV5hJqw',
	consumer_secret	=> '6eqRwslLMsxasUXmPVd5g3yLO3puSd2rpgVmynMr5UM',
	access_token	=> '236977665-eZw7f48JSrlHma7rbU1uUpe3jOjOJbvimMfPAYMK',
	access_token_secret => 'ccvTKAxChyqAcoo86EkcHRprwafVij6O9YsI7dbn7A'
    );

    my $friends = eval { $nt->friends() };
    if($friends) {
        $irc::socket->send("PRIVMSG $chan :$friends\r\n");
    } else {
	my $error = $nt->get_error();
	if( ref $error ) {
	    if( ref($error) eq 'HASH' && exists $error->{error} ) {
		$error = $error->{error};
	    } else {
		$error = 'Unexpected error type ' . ref($error);
	    }
	} else {
	    $error = $nt->http_code() . ": " . $nt->http_message;
	}
	$irc::socket->send("PRIVMSG $chan :$error\r\n");
    }	
}

1;
