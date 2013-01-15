#!/usr/bin/perl
################################################################################
#   9/23/2011  bchittenden        Initial version.
#                                 
#                                 This script takes a key field, a delimiter
#                                 and a file name as arguments, and
#                                 correlates the key field against all other
#                                 fields, record by record.
#                                 The results are summarized into a report
#                                 which is written to standard out.
#                                 
#                                 Run 'perldoc correlate.pl' for detailed
#                                 documentation and usage example.
################################################################################
use strict;
use warnings;
use Getopt::Long;

my $delimiter = "\t";
my $hasHeader = 0;
my $keyColumn = 1;
my $rs = '|';
my $getoptResult = 
   GetOptions (
        "delimiter|d=s"      => \$delimiter
      , "header|h"           => \$hasHeader
      , "key|k=i"            => \$keyColumn
      , "record-separator|r" => \$rs
   );

my @header;
# @columns is an AoA. Each column will be a
# reference to entries in that column.
my @columns; 
my @uniqueEntry;
# @uniqueEntry is an AoH. Each column will be a
# reference to a hash holding the entries in that column.
my @count;
my @key; # all keys, indexed by row.
my @uniqueKeys;
my $numKeys = 0;

# convert $keyColumn so that it is 0-indexed.
$keyColumn --; 

# if $delimiter is a pipe, escape it.
$delimiter = $delimiter eq '|' ? '\|' : $delimiter;

my $rowNumber = 0;
my $columnNumber = 0;
my $totalColumns;
my $firstLine=1;

sub getHeader {
    my $line = shift;
    my @fields = split( $delimiter );
    # global
    $totalColumns = scalar @fields;
    
    # if $hasHeader is not set, @fields will contain a list of numbers between
    # starting with 1.
    
    for( my $counter = 0; $counter < scalar @fields; $counter++ ) {
        my $field = $hasHeader ? "$rs$fields[$counter]" : "";
        $fields[$counter] = sprintf( "%5d%s", $counter+1, $field );
    }
    unless ( $hasHeader ) {
        for( my $counter = 0; $counter < scalar @fields; $counter++ ) {
		$fields[$counter] = $counter+1;
        }
    }
    return @fields;
}

################################################################################
# populate @columns
################################################################################
while( <> ) {
    chomp;
    s/\r$//; #remove carriage returns if present
    if ( $firstLine ) {
        @header = getHeader( $_ );
        $firstLine = 0;
        next if $hasHeader;
    }
    my @row = split( $delimiter );
    my $colNum = 0;
    foreach my $entry (@row) {
        $columns[$colNum] = () unless (defined $columns[$colNum] );
        push( @{$columns[$colNum]}, $entry );
        $colNum++;
    }
    $key[$rowNumber] = $row[$keyColumn];
    $rowNumber++;
}

################################################################################
# Calculate
#   $numKeys: number of unique values in the KEY column.
#   $uniqueEntry[$columnNumber]: entries in colum $colNum, expressed as a hash,
#                          so that the keys form a set of unique entries in that
#                          column.
#   $count[$columnNumber]: A count of matches between keys and values.
################################################################################
foreach my $column (@columns) {
    my $rowNum = 0;
    my %row;
    foreach my $entry ( @$column ) {
        $row{ $key[$rowNum] } = {} unless $row{ $key[$rowNum] };
        ($row{ $key[$rowNum] })->{$entry} = 1;
        $uniqueEntry[$columnNumber] = {} unless $uniqueEntry[$columnNumber];
        ($uniqueEntry[$columnNumber])->{$entry} = 1;
        $rowNum++; 
    }
    unless (@uniqueKeys) {
        @uniqueKeys = (keys %row);
        $numKeys = scalar @uniqueKeys;
    }
    foreach my $key ( @uniqueKeys ) {
        $count[$columnNumber] += scalar( keys %{$row{$key}} );
    }
    $columnNumber++;
}

################################################################################
# Print the report.
################################################################################
for( my $colNum = 0; $colNum < $totalColumns; $colNum++ ) {
    print  "$header[$colNum]"
          . "$rs"
          . $numKeys/$count[$colNum] 
          . "$rs"
          . scalar( keys( %{$uniqueEntry[$colNum]} ) )/$numKeys
          . "\n";
}

__END__
=head1 NAME

correlate.pl - Find correlations between a key field in a delimited file and other fields.

=head1 SYNOPSIS

  correlate.pl --key KEY [--delimiter DELIMITER] [--header] [--record-separator SEPARATOR] FILE

  --key KEY

  KEY is the number of the field that we are doing comparisons against, counting from 1

  --delimiter DELIMITER
  
  DELIMITER is the delimiter for fields in FILE. The default delimiter is "\t".

  --header

  If the first line in the file is a header containing the names of the fields, 
  this option will show the field names in the report printed to standard out.

  --record-separator SEPARATOR

  SEPARATOR is the delimiter for fields in the report printed to standard out.

=head1 DESCRIPTION

  Given a delimited file 'FILE', correlate.pl will read the file in line by 
  line and compare each record on a line against a key field sepecified by the 
  --key option. It will write a report, field by field, showing the field number,
  an optional field name, and the correlation between that field and the key field,
  summarized across the entire file.

  The correlation is shown by two fields: the first is a ratio between the number of
  times the key field occurs and the number of fields matched. If there is a one to
  many relationship between keys and fields, this number will be less than 1.

  The second field is a ratio between the number of unique fields and the number of
  keys. If there are duplicate fields, this number will be less than 1.

=head1 EXAMPLE

  The input file 'example.txt' looks like this:

  KEY        |MATCH      |ONE-TO-MANY|DUPLICATE
  1          |BCHITTENDEN|LBROWN     |SOUTHPAW
  2          |CAMMERMAN  |BLONDE     |RIGHTY
  2          |CAMMERMAN  |BALD       |RIGHTY
  3          |MWOLTHERS  |DBROWN     |RIGHTY
  4          |MJACKEY    |BLACK      |RIGHTY

  The key field will be 1, delimiter will be '|' and the first line of the file
  is a header, so

  correlate.pl --key 1 --delimiter '|' --header example.txt 

  yields the following output:

    1|KEY        |1|1
    2|MATCH      |1|1
    3|ONE-TO-MANY|0.8|1.25
    4|DUPLICATE|1|0.5

  There is a one to one relationship between the 'KEY' and 'MATCH' fields. Field 3 of the
  the 'MATCH' line is 1, because there were 4 unique keys, and 4 unique matches between KEY
  and the name in the 'MATCH' field.

  In the ONE-TO-MANY row, Field 3 is 0.8, because we have 4 unique keys and 5 fields that 
  those keys match against. Field 4 is greater than 1 because we have more unique fields than
  keys.

  In the DUPLICATE row, Field 3 is 1, because each key matches a single value, but field 4 is 0.5
  because there are only two unique values, vs. 4 unique keys.

=head1 AUTHOR  

Barton Chittenden, E<lt>bchittenden@appriss.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Barton Chittenden

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut

