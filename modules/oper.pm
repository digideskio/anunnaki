package oper;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'god', '!kill', 'oper->kill($user, $chan, $msg);');
    triggers->add('channel', 'god', '!gline', 'oper->gline($user, $chan, $msg);');
    triggers->add('channel', 'god', '!zline', 'oper->zline($user, $chan, $msg);');
    triggers->add('channel', 'god', '!shun', 'oper->shun($user, $chan, $msg);');
    triggers->add('channel', 'god', '!sajoin', 'oper->sajoin($user, $chan, $msg);');
}

sub kill {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    $data[0] = '';
 
    if(!$data[1] || !$data[2]) {
	$irc::socket->send("PRIVMSG $chan :Usage: !kill <username> <reason>\r\n");
    } else {
        my $kill = $data[1];
        $data[1] = '';
        $irc::socket->send("KILL $kill :@data\r\n");
    }
}

sub sajoin {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $dest = $data[1];

    open(my $ulist, "<db/userlist.db");
    my @udat = <$ulist>;
    close($ulist);
 
	$irc::socket->send("SAJOIN a $dest\r\n");  
	$irc::socket->send("SAJOIN Ace $dest\r\n");	
	$irc::socket->send("SAJOIN aidz $dest\r\n");
	$irc::socket->send("SAJOIN an0n $dest\r\n"); 
	$irc::socket->send("SAJOIN Angie $dest\r\n");
	$irc::socket->send("SAJOIN Atreyu $dest\r\n");
	$irc::socket->send("SAJOIN Av[a]ilea $dest\r\n");
	$irc::socket->send("SAJOIN Break $dest\r\n");
	$irc::socket->send("SAJOIN Buffalo $dest\r\n");
	$irc::socket->send("SAJOIN Carlisle $dest\r\n");
	$irc::socket->send("SAJOIN chrissy $dest\r\n");
	$irc::socket->send("SAJOIN Chastity $dest\r\n");
	$irc::socket->send("SAJOIN clunk $dest\r\n");
	$irc::socket->send("SAJOIN demon $dest\r\n");
	$irc::socket->send("SAJOIN Decessus $dest\r\n");
	$irc::socket->send("SAJOIN DETERMINOLOGY $dest\r\n");	
	$irc::socket->send("SAJOIN disable $dest\r\n");
	$irc::socket->send("SAJOIN DJLIGHTNING $dest\r\n");
	$irc::socket->send("SAJOIN Dren $dest\r\n");
	$irc::socket->send("SAJOIN DrRen $dest\r\n");
	$irc::socket->send("SAJOIN geekgirlmobile $dest\r\n");
	$irc::socket->send("SAJOIN geekgirl $dest\r\n");
	$irc::socket->send("SAJOIN Gr1m3 $dest\r\n");
	$irc::socket->send("SAJOIN Haunted|bye $dest\r\n");
	$irc::socket->send("SAJOIN Heavenly $dest\r\n");
	$irc::socket->send("SAJOIN H0LLYWOOD $dest\r\n");
	$irc::socket->send("SAJOIN hyp $dest\r\n");
	$irc::socket->send("SAJOIN Incog_BUSY $dest\r\n");
	$irc::socket->send("SAJOIN Incogmous $dest\r\n");
	$irc::socket->send("SAJOIN JAQ $dest\r\n");	
	$irc::socket->send("SAJOIN JD $dest\r\n");
	$irc::socket->send("SAJOIN Jenn|Work $dest\r\n");
	$irc::socket->send("SAJOIN Jen $dest\r\n");
	$irc::socket->send("SAJOIN Jer $dest\r\n");
	$irc::socket->send("SAJOIN Joah $dest\r\n");
	$irc::socket->send("SAJOIN Kacey $dest\r\n");
	$irc::socket->send("SAJOIN Kait $dest\r\n");
	$irc::socket->send("SAJOIN klucas $dest\r\n");
	$irc::socket->send("SAJOIN Kritikal $dest\r\n");
	$irc::socket->send("SAJOIN lar $dest\r\n");
	$irc::socket->send("SAJOIN lawltastic $dest\r\n");
	$irc::socket->send("SAJOIN Lestat $dest\r\n");
	$irc::socket->send("SAJOIN lynx $dest\r\n");
	$irc::socket->send("SAJOIN matt $dest\r\n");
	$irc::socket->send("SAJOIN Mandee $dest\r\n");
	$irc::socket->send("SAJOIN misty $dest\r\n");
	$irc::socket->send("SAJOIN mmmm $dest\r\n");
	$irc::socket->send("SAJOIN Morphyus $dest\r\n");
	$irc::socket->send("SAJOIN MsLoveDoctor $dest\r\n");
	$irc::socket->send("SAJOIN Ninja $dest\r\n");
	$irc::socket->send("SAJOIN Ninja_Bot $dest\r\n");
	$irc::socket->send("SAJOIN plat_ $dest\r\n");
	$irc::socket->send("SAJOIN Poseidon $dest\r\n");
	$irc::socket->send("SAJOIN pogo $dest\r\n");
	$irc::socket->send("SAJOIN Reezy $dest\r\n");
 
#    for my $u (sort @udat) {	
#	print $u;
#    }
    
}

sub gline {
   my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);

   my $opt = shift(@data);

   if($opt eq 'all') {
	open(my $gl, "<db/glines.db");
	my @glines = <$gl>;
	close($gl);

	foreach my $line (@glines) {
	    print $line;
	}
    }elsif($opt eq 'list') {
	$irc::socket->send("STATS g\r\n");
    }
}
  
1;
