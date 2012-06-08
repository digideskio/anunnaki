package jewgolds;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'peasant', '!gamble', 'jewgolds->gamble($user, $chan);');
    triggers->add('channel', 'peasant', '!jewgolds', 'jewgolds->amount($user, $chan);');
}


sub amount {
    my ($nickname, $channel) = ($_[1], $_[2]);

    open(my $GOLDIN,"<db/golds/$nickname.gold");
    my $golds = <$GOLDIN>;

    $irc::socket->send("PRIVMSG $channel :$nickname your jewgold amount is $golds\r\n");

    close($GOLDIN);
}

sub gamble {
   my ($nickname, $channel) = ($_[1], $_[2]);

   open(my $GOLDIN,"<db/golds/$nickname.gold");
   my $golds = <$GOLDIN>;
   my $range = 50;
   my $rand = int(rand($range));

   if($rand > 25) {
      $irc::socket->send("PRIVMSG $channel Greedy jew \x02$nickname\x02 has gambled and won \x02$rand\x02 jewgolds.\r\n");
      open(my $GOLDOUT,">db/golds/$nickname.gold");
      my $newgold = $golds + $rand;
      print $GOLDOUT "$newgold";
      close($GOLDOUT);
   }
   if($rand < 25) {
      $irc::socket->send("PRIVMSG $channel Greedy jew \x02$nickname\x02 has gambled and lost \x02$rand\x02 jewgolds.\r\n");
      open(my $GOLDOUT,">db/golds/$nickname.gold");
      my $newgold = $golds - $rand;
      print $GOLDOUT "$newgold";
      close($GOLDOUT);
   }
   close($GOLDIN);
}

1;
