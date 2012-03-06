package jewgolds;

use strict;
use warnings;

sub amount {
    my ($irc, $nickname, $channel) = ($_[1], $_[2], $_[3]);

    open(my $GOLDIN,"<db/golds/$nickname.gold");
    my $golds = <$GOLDIN>;

    $irc->send("PRIVMSG $channel :$nickname your jewgold amount is $golds\r\n");

    close($GOLDIN);
}

sub gamble {
   my ($irc, $nickname, $channel) = ($_[1], $_[2], $_[3]);

   open(my $GOLDIN,"<db/golds/$nickname.gold");
   my $golds = <$GOLDIN>;
   my $range = 50;
   my $rand = int(rand($range));

   if($rand > 10) {
      $irc->send("PRIVMSG $channel Greedy jew \x02$nickname\x02 has gambled and won \x02$rand\x02 jewgolds.\r\n");
      open(my $GOLDOUT,">db/golds/$nickname.gold");
      my $newgold = $golds + $rand;
      print $GOLDOUT "$newgold";
      close($GOLDOUT);
   }
   if($rand < 10) {
      $irc->send("PRIVMSG $channel Greedy jew \x02$nickname\x02 has gambled and lost \x02$rand\x02 jewgolds.\r\n");
      open(my $GOLDOUT,">db/golds/$nickname.gold");
      my $newgold = $golds - $rand;
      print $GOLDOUT "$newgold";
      close($GOLDOUT);
   }
   close($GOLDIN);
}

1;
