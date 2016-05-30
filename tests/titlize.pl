#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $root = dirname(__FILE__) . "/..";

my $input = "Test @! name - with some STUff!";
my $expected = "test-name-with-some-stuff";
my $output = `$root/jekyll-titlize.pl "$input"` or die "exec failed: $!";
chomp $output;

if ($output ne $expected) {
    print __FILE__, " failed\n";
    print "in : $input\n";
    print "exp: $expected\n";
    print "out: $output\n";
    exit(1);
}
