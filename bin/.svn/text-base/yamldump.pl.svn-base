#! /usr/bin/perl -w

use YAML 'DumpFile';

local $YAML::UseBlock = 1;

my $fields =
{
        sender_id => '',
        status => '',
        date => '',
        fr_number => '',
        date_due => '',
};

$file = "foo";
DumpFile( $file, $fields );

system( $ENV{EDITOR}, $file) == 0
        or die "Error launching $ENV{EDITOR}"
