package vote;

use strict;
use warnings;

sub campaign {
    my ($nickname, $channel) = ($_[1], $_[2], $_[3]);

    while(1) {
	$irc::socket->send("PRIVMSG $channel :ARE YOU TIRED OF BAD IRC TIMES? DOES LAR PROMISE YOU HE WONT LEAVE YOU? DOES COBAIN SAY HE DOESNT START WARS BUT HE REALLY DOES? DOES GLITCH SAY HES A BADASS HACKER, BUT DOESNT KNOW SHIT ABOUT HIS OWN DICK? TIRED OF GEEKGIRL HAVING THIS FINE NETWORK DDOSED TO HELL? KEV CLAIMING TO BE #000000? VOTE FOR THE TRISTATE DELIGATION ~*~ bReAk AnD aCesTaR AnD BaRz aS OuR MuScLe~*~ FOR 2012 HEAD NETWORK\r\n");
	sleep 20;
    }
}

#sub parse {
#    my ($irc, $nickname, $channel, $msg) = ($_[1], $_[2], $_[3], $_[4]);
#    my @data = $msg;

#    if($data[1] eq "add") {
#        my $cantidate = $data[2];
#	open(my $VOTEOUT,">db/votes/cantidates");
#	print $VOTEOUT "$cantidate\n";
#	close($VOTEOUT);
#	$irc->send("PRIVMSG $channel :\x02$cantidate is now running in the polls!\x02\r\n");
#    	}
#    } 
	
#    if($data[1] eq "list") {
#	open(my $VOTEIN,"<db/votes/cantidates");
#	my $amount = <$VOTEIN>;
#	$irc->send("PRIVMSG $channel :\x02$nickname has $amount votes\x02\r\n");
#	close($VOTEIN);
#   }
#}

1;
