#! /usr/bin/perl

use Modern::Perl;

my @quoteme=<>;
chomp @quoteme;

say "'" . join( q(', '), @quoteme ) . "'";
