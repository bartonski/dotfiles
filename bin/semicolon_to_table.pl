#! /usr/bin/perl

use warnings;
use strict;

# Possible states:
# 0: Enterng table
# 1: In table
# 2: Exiting table
# 3: Out of table
my $in_table = 2;

sub print_line {
    my ( $state, $line ) = @_;
    my @line_start = (
          "<table><tr><td>" # entering table ( in table, changed )
        , "<tr><td>" # In table ( in table, unchanged )
        , "<tr><td>" # exiting table ( not in table, changed )
        , "" # Not in table ( not in table, unchanged )
    );
    my @line_end = (
          "</td></tr>" # Entering table
        , "</td></tr>" # In table
        , "</td></tr></table>" # Exiting table
        , "" # Not in table
    );
    my @delimiter = (
          "</td><td>" # Entering table
        , "</td><td>" # In table
        , "</td><td>" # Exiting table
        , "" # Not in table
    );
    my @text = split ( ';', $line );
    print $line_start[$state] . join( $delimiter[$state], @text ) . $line_end[$state] . "\n";
}

while(<>) {
    my $old_in_table = $in_table;
    $in_table = m/;/ ? 0 : 2;    
    my $same = $in_table == $old_in_table ? 1 : 0;
    print_line( $in_table + $same, $_ );
}
