#!/usr/bin/perl
use warnings;

my $title = $ARGV[0];
$title = lc $title;
$title =~ s/[^a-z0-9 ]//g;
$title =~ s/  / /g;
$title =~ s/ /-/g;
print "$title\n";
