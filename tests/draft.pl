#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $root = dirname(__FILE__) . "/..";

my $tmp = "$root/.tmp";
system("rm -rf $tmp");
mkdir $tmp;
system("$root/jekyll-new-draft.pl $tmp") and die "exec failed: $!";

my $expected = "$tmp/_drafts/new.md";
if (not -f $expected) {
    print __FILE__, " failed\n";
    print "file not found: $expected\n";
    exit(1);
}
