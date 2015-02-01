#! /usr/bin/perl

# Takes a text file or reads standard input consisting of pairs of colon delimited lines.
# The first line each pair has the format TITLE : SUBTITLE [ description 1ine1 : descripton line2 : ... ]
# Each line will be printed as a cell in a 2 column table.
#
# For example
#
# 16859   southernnh: Missing Periodical Records : research missing records
#
# "16859   southernnh" is the title, is printed very large and bold.
# "Missing Periodical Records" is the subtitle, printed large and bold.
# "research missing records" is a line of description; this is printed
# at a regular size and weight.

use warnings;
use strict;
use v5.10.0;
use File::Spec;

#sub cell {
sub front {
    my $fh = shift;
    my @ticket = split ': ', shift;
    my $title = shift @ticket;
    my $subtitle = shift @ticket;
    print $fh "<td>"; 
    print $fh qq|<div class="title">$title</div>|;
    print $fh qq|<div class="subtitle">$subtitle</div>|;
    print $fh join( "<br />", @ticket );
    print $fh "</td>\n"; 
}

sub back {
    my $fh = shift;
    my @ticket = split ': ', shift;
    print $fh "<td>"; 
    print $fh join( "<br />", @ticket );
    print $fh "</td>\n"; 
}

sub body {
    my $fh = shift;
    my $page_data = shift;
    say $fh '<body>';
    table( $fh, $page_data );
    say $fh "</body>\n</html>";
}

sub table {
    my $fh = shift;
    my $page_data = shift;
    say( $fh "<table>");
    foreach my $row ( @$page_data ) {
        say( $fh "<tr>");
        front(  $fh, $row->{front} ); 
        back(  $fh, $row->{back} ) if ( defined $row->{back} ); 
        say( $fh "</tr>");
    }
    say  $fh "</table>";
}

sub head {
    my $fh = shift;
    my $filename = shift;
    #TODO td, th { height } should be calculated from rows per page.
    say $fh "<html>
<head>
<title>$filename</title>
<style>
table {
    border-collapse:collapse;
}
table,th, td {
    text-align:center;
    font-size: 18px;
    border: 1px solid black;
}
th, td {
    width: 375px;
    height:150px;
}
div.title {
    font-size: 36px;    
    font-weight: 900;
}
div.subtitle {
    font-size: 22px;    
    font-weight: 900;
}
</style>
</head>
";
}

sub get_page_data {
    my $rows_per_page=shift;
    my $number_of_rows_read=0;
    my $page_data = [];

    READ_ROW: for my $row (1 .. $rows_per_page) {
        my $current_row = {};
        $current_row->{front} = <>;
        if ( defined $current_row->{front} ) {
            $number_of_rows_read++;
            $current_row->{back} = <>;
            push @$page_data, $current_row;
        } else {
            last READ_ROW;
        }
    }
    return (scalar @$page_data == 0) ? undef : $page_data;
}

sub main {
    # TODO: should be able to specify output file name on command line.
    my $home=$ENV{HOME};
    my $basename='flashcard';
    my $page_counter=1;
    my $output_path="/tmp";
    my $rows_per_page=6;
   
    while( my $page_data=get_page_data( $rows_per_page ) ) {
        my $filename="${basename}." . sprintf("%03d", $page_counter) . ".html";
        my $output_file=File::Spec->join($output_path, $filename );
        my $OUT_FH;
        open( $OUT_FH, '>', $output_file) or die "Cannot open '$output_file' for output: $!";
        head( $OUT_FH, $filename );
        body( $OUT_FH, $page_data );
        close $OUT_FH;
        $page_counter++;
    }
}

main()
