package web;

use strict;
use warnings;
use LWP::UserAgent;

BEGIN {
    triggers->add('channel', 'god', '.hnhh', 'web->hnhh($chan, $msg);');
}

sub hnhh {
    my ($chan, @data) = ($_[1], split " ", $_[2]);


    my $page = 'http://www.hotnewhiphop.com';
    my $get = HTTP::Request->new('GET', $page);
    my $ua = LWP::UserAgent->new();
    $ua->agent("Mozilla/6.0");
    $ua->timeout(20);

    
    my $result = $ua->request($get);

#    my $string = $result->decoded_entities;

    my $content = $result->decoded_content;
    $content =~ m/<div class="block2 home-songs song-vertical-list vertical-list">(.*)<a href="(.*?)" onclick="_gaq.push((['_trackEvent', 'Home','Click on Today Song Title'(.*)">(.*?)</a>(.*)<span class="artist"><i>(.*?)</i>(.*?)</span>/);

    open(my $cout, ">db/hnhh.dat");
    print $cout "$content";
    close($cout);
    $irc::socket->send("PRIVMSG $chan :$content\r\n");

#    if($result->is_success) {
#	for my $line (@content) {
#	    $line = decode_entities($line);
#$line =~ m/<div class="block2 home-songs song-vertical-list vertical-list">(.*)<a href="(.*?)" onclick="_gaq.push((['_trackEvent', 'Home', 'Click on Today Song Title'(.*)">(.*?)</a>(.*)<span class="artist"><i>(.*?)</i>(.*?)</span>/);
#	    my ($link, $title, $artist) = ($1, $2, $3);
#	    $irc::socket->send("PRIVMSG $chan :$title - $artist - $link\r\n");
#	    print $line;
#	$irc::socket->send("PRIVMSG $chan :\r\n");
#	open(my $cout, ">db/hnhh.dat");
#	print $cout "$line";
#	close($cout);
#	}
#   }
}

1;
