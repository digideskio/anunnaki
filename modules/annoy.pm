package annoy;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'god', '.ddos', 'annoy->ddos($user, $chan, $msg);');
    triggers->add('channel', 'god', '.siren', 'annoy->siren($user, $chan, $msg);');    
}

sub siren {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my @offenders = ('bars', 'Break`', 'a', 'lar');
    my $offchan = '#umad';

    if(!$data[1]) {
        $irc::socket->send("PRIVMSG $chan :Usage: .siren #channel\r\n");
    } else {
#	$irc::socket->send("PRIVMSG $offchan :\x02@offenders $data[1]\x02\r\n");
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!! THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!! ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\r\n");
        $irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!! ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!! GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!\x02\r\n");  
        sleep(5);
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!!THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!!ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\x02\r\n");
	$irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!!ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!!GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!\x02\r\n");
        sleep(10);
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!!THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!!ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\x02\r\n");
	$irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!!ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!!GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!\x02\r\n");
        sleep(15);
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!!THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!!ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\x02\r\n");
	$irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!!ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!!GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!\x02\r\n");
        sleep(20);
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!!THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!!ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\x02\r\n");
	$irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!!ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!!GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!^B\x02\r\n");
        sleep(25);
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!!THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!!ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\x02\r\n");
	$irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!!ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!!GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!\x02\r\n");
        sleep(30);
        $irc::socket->send("PRIVMSG $offchan :\x02ATTENTION @offenders PLEASE CALM DOWN IN $data[1]!!!!!!!!!!THIS IS THE ALARM!!!! WEEEEEYOUUUUUUUUUUUUU WEEEEEEEYOUUUUUUUUUUUUUUUUU WEEEEEEEEEEEEEEYOUUUUUUUUUUUUUUU!!!!!!!!!!!!!!!!!!! TAKE A CHILL PILL BROBABES!!! ATTENTION @offenders PLEASE TAKE A SEAT AND A QUICK BREATHER IN $data[1]!!!!! WE NEED YOU TO RELAX BEFORE YOU'RE TRANQUILIZED!!!ATTENTION @offenders YOU ARE ALL OVERDOING IT INSIDE OF $data[1]!!!!!!\x02\r\n");
	$irc::socket->send("PRIVMSG $offchan :\x02PLEASE DO NOT REOFFEND OR WE WILL BE FORCED TO TAKE IMMEDIATE ACTION AND ESSENTIALLY ROLL ON YOU!!!!!!!!!!!!!!!!!!ATTENTION @offenders PLEASE STOP THE MADNESS IN $data[1]!!!!!GEEKGIRL HAS A CYST ON HER OVARIES AND ITS ABOUT TO BURST IF YOU WILL NOT QUIT IT!!!!!^B\x02\r\n");
    }
}

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
