#! /usr/bin/perl

use Modern::Perl;

my @quoteme=<>;
chomp @quoteme;
for my $quoteme ( @quoteme ) {
    $quoteme =~ s/\r//; # nuke carriage returns
}

say "'" . join( q(', '), @quoteme ) . "'";
