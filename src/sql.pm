package sql;

use strict;
use warnings;
use DBI;

our ($dbh, $sth);

sub conn {
   my $dsn = "DBI:mysql:database=anunnaki;host=localhost";
   $dbh = DBI->connect($dsn, 'wired', 'lolw3rd!') or die "can't connect to mysql database anunnaki\n";
}

sub get {
    my $table = $_[1];
    if(defined $dbh && defined $table) {
	$sth = $dbh->prepare("SELECT * from $table");
	$sth->execute();
	return 1;
    }
}

sub prepare {
    my $query = $_[1] or return undef;
    if(defined $dbh && defined $query) {
	$sth = $dbh->prepare($query);
	return 1;
    }
}

sub execute {
    my $string = $_[1] or return undef;
    if(defined $dbh && defined $string) {
	$sth->execute($string);
	$sth->finish;
	return 1;
    }
}

sub close {
    $dbh->disconnect() if defined $dbh;
    return 1;
}

1;
