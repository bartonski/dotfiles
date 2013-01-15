#!/usr/bin/perl
#
# Copyright 2008 Guillaume Cottenceau.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# 
# Produces a "useful" diff between two ZIP files, helping to view what
# changed in between. It even adds a diff between different ZIP/JAR
# files inside both ZIP files.
#
# First aim is to make sure all changes are mastered when deploying
# a new WAR file in production (helps spot what bugfixes/features are
# actually in the new WAR file).
#
# Example output:
#
# @@ -2 +2 @@
# -main.jsp 9
# +main.jsp 17
# @@ -8 +8 @@
# -WEB-INF/lib/foo.jar 958
# +WEB-INF/lib/foo.jar 967
# 	@@ -8,2 +8,2 @@
# 	-org/gc/megadance/Bar.class 21
# 	-org/gc/megadance/Qux.class 24
# 	+org/gc/megadance/Bar.class 27
# 	+org/gc/megadance/Qux.class 27
#

use strict;
use Getopt::Long;
use File::Temp qw(tempfile tempdir);

my $nocolordiff;
my $p = 0;

sub help {
    die "Usage: ", basename($0), " <zip1> <zip2> [OPTION]...
    --no-color-diff     do not pipe output through colordiff (but you should use it, it's cool)
    -p<num>             save as -p of patch
";
}

my $result = GetOptions("no-color-diff" => \$nocolordiff,
                        "p=s"           => \$p);

help() if @ARGV != 2;


my $tempdir = tempdir(CLEANUP => 1);
our (undef, $first_profile) = tempfile(DIR => $tempdir);
our (undef, $second_profile) = tempfile(DIR => $tempdir);

my $tempdir_contents1;
my $tempdir_contents2;

my @maindiff = produce_diff($ARGV[0], $ARGV[1]);

my $output;

foreach my $line (@maindiff) {
    $output .= "$line\n";
    if ($line =~ /^([-+])(\S+) \d+/) {
        my $kind = $1;
        my $file = $2;
        $file =~ /\.(jar|war|zip)$/ or next;
        if ($kind eq '+') {
            if (!$tempdir_contents1) {
                $tempdir_contents1 = tempdir(CLEANUP => 1);
                system("unzip -q $ARGV[0] -d $tempdir_contents1");
            }
            if (!$tempdir_contents2) {
                $tempdir_contents2 = tempdir(CLEANUP => 1);
                system("unzip -q $ARGV[1] -d $tempdir_contents2");
            }
            my $f1 = "$tempdir_contents1/$file";
            my $f2 = "$tempdir_contents2/$file";
            if (!-f $f1) {
                $output .= "\t<new file>\n";
            } else {
                my @insidediff = produce_diff($f1, $f2);
                foreach my $insideline (@insidediff) {
                    $output .= "\t$insideline\n";
                }
            }
        }
    }
}

if ($nocolordiff) {
    print $output;
} else {
    open FOO, "|colordiff";
    print FOO $output;
    close FOO;
}


sub basename { local $_ = shift; s|/*\s*$||; s|.*/||; $_ }

sub produce_profile {
    my ($f, $output) = @_;
    if ($f =~ /\.(zip|jar|war)/) {
        system("unzip -l $f | perl -ane 'if (\$F[3]) { \$F[3] =~ s|[^/]*/|| foreach 1..$p; print \"\$F[3] \$F[0]\n\" }' | sort > $output");
    } else {
        system("tar tvf $f | perl -ane 'if (\$F[5]) { \$F[5] =~ s|[^/]*/|| foreach 1..$p; print \"\$F[5] \$F[2]\n\" }' | sort > $output");
    }
}

sub produce_diff {
    my ($f1, $f2) = @_;
    produce_profile($f1, $first_profile);
    produce_profile($f2, $second_profile);
    my (undef, undef, @out) = split /\n/, `diff --unified=0 $first_profile $second_profile`;
    return @out;
}
