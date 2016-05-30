#!/usr/bin/perl
use warnings;

my $cmd = "jekyll serve --draft";
print "running $cmd\n";
system($cmd);
