#! /usr/bin/perl

use strict;
use warnings;

sub pick {
    return $_[ rand scalar @_ ];
};


my @eyebrows = ( '', '', '', '', '', qw( : > ) ); 
my @eyes    = qw( = : : : : 8 B % ; );
my @noses   = ( '', qw( 0 * ^ o O . u - - - - - - ) );
my @mouths  = qw" ) ) ) ) > } D D ";

my $eybrows = pick( @eyebrows );
my $eyes    = pick( @eyes );
my $nose    = pick( @noses ); 
my $mouth   = pick( @mouths ); 

print "$eybrows"
    . "$eyes"
    . "$nose"
    . "$mouth"
    . "\n";
