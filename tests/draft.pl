#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $root = dirname(__FILE__) . "/..";

my $tmp = "$root/.tmp";
system("rm -rf $tmp");
mkdir $tmp;
chdir $tmp;

system("../$root/jekyll-new-draft.pl") and die "exec failed: $!";

my $expected = "_drafts/new.md";
if (not -f $expected) {
    print __FILE__, " failed\n";
    print "file not found: $expected\n";
    exit(1);
}
