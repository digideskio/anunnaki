package google;

use strict;
use warnings;
#use LWP::UserAgent;
#use URI::Escape;
#use JSON;

BEING {
    triggers->add('channel', 'peasant', '.google', 'google->search($chan, $msg);');
}

sub search {
    my ($chan, @data) = ($_[1], split " ", $_[2]);
    shift(@data);

    print @data;

#    my $url = 'https://ajax.googleapis.com/ajax/services/search/web?b=1.0&q=@data&userip=174.34.147.216";

#    my $ua = LWP::UserAgent->new();
#    $ua->default_header("HTTP_REFERER" => http://dope.umad.us);
#    my $body = $ua->get($url);

#    print $body->decoded_content;

 #   my $json = from_json($body->decoded_content);

 #   my $i = 0;

  #  foreach my $result (@{$json->{responseData}->{results}}) {
#	$i++;
#	$irc::socket->send("PRIVMSG $chan :$i $result->{titleNoFormatting} $result->{url}\r\n");
 #   }

  #  if(!$i) {
#	$irc::socket->send("PRIVMSG $chan :Sorry, no results were found for @data\r\n");
 #   }
}

1;
