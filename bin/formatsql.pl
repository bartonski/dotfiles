#! /usr/bin/perl

my $query = '';

while( <> ) {
    chomp;
    $query .= ' ' . $_;
}

$query =~ s/\b(select|from|where|inner join|left join|using|order by|group by|is|not|null|as|and)\b/\U$1/ig;
$query =~ s/(SELECT|FROM|WHERE|ORDER BY|GROUP BY)\s+/\n$1\n    /g;
$query =~ s/(INNER JOIN|LEFT JOIN|AND)/\n    $1/g;
$query =~ s/, /,\n    /g;
print $query;

