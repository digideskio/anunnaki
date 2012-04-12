package annoy;

use strict;
use warnings;

sub ddos {
    my ($nickname, $channel, @data) = ($_[1], $_[2], split " ", $_[3]);
    
    my $victim = $data[1];
    $irc::socket->send("PRIVMSG $channel :HEY \x02$victim\x02 PREPARE TO DIE!!!!!!!!!!!!!!!!!!!!!!!!!!\r\n");
    $irc::socket->send("PRIVMSG $channel :IM CHARGING MY LAZORS - TARGED LOCKED: \x02$victim\x02\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [|________]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [||_______]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [|||______]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [||||_____]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [|||||____]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [||||||___]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [|||||||__]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [||||||||_]\r\n");
    $irc::socket->send("PRIVMSG $channel :DDOS PROGRESS: [|||||||||]\r\n");
    $irc::socket->send("PRIVMSG $channel :HEY \x02$victim\x02 HAVE FUN EVER GETTIN ON THE INTERNET AGAIN!! YOU'RE TOAST!! ENJOY YOUR BREAK FGT!!\r\n"); 
    $irc::socket->send("PRIVMSG $channel :*robot laugh*\r\n");
}

sub cry {
}

sub retard {
    my ($nickname, $channel, @data) = ($_[1], $_[2], split " ", $_[3]);

    my @hate = ('ok bro ur fucking retarded', 'uve got downs bro', 'bro y u so autistic', 'anyone else see this retard give it up bro', 'dur dur dur durrrr three hundred and twenty four yeah three hundred and twenty four');
    
    my $retard = $data[2];
    my $string = $hate[int rand scalar @hate];

    if($data[1] eq "add") {
        open(my $rein, ">>db/annoy/retards/$retard");
        print $rein "$retard\n";
        close($rein);
    }

    open(my $reout, ">>db/annoy/retards.db");
    my @retards = <$reout>;
    my $grep = grep(/$data[2]/, @retards);
    close($reout);
	
    $irc::socket->send("PRIVMSG $channel :$data[1] $string $grep @retards\r\n");
}

sub insult {
    my ($nickname, $channel, @data) = ($_[1], $_[2], $_[3], split " ", $_[4]);    

    $data[0] = '';
    if(!$data[2]) {
	open(my $DISSIN,"<db/diss.db");
	my @insults = <$DISSIN>;
	my @grep = grep(/^$data[2]/, @insults);
	my $string = $grep[int rand scalar @grep];
	close($DISSIN);

	if(!$string) {
	    $irc::socket->send("PRIVMSG $channel :$nickname y u so dumb, that person cant be dissed fuckboyy STEP YA GAME UP!!\r\n");
	} else {
	    $irc::socket->send("PRIVMSG $channel :$string\r\n");
	}
    } elsif($data[2]) {
        open(my $DISSOUT,">>db/diss.db");
        print $DISSOUT "@data\n";
        close($DISSOUT);
        $irc::socket->send("PRIVMSG $channel :@data added to the diss database.\r\n");
    }
}

1;
