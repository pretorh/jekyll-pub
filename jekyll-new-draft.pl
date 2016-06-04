#!/usr/bin/perl
use warnings;
use File::Copy;
use File::Basename;

my $resources = dirname(__FILE__);
my $drafts = "_drafts";

mkdir $drafts;
print "$resources/draft-template.md -> $drafts/new.md\n";
copy("$resources/draft-template.md", "$drafts/new.md") or die "Failed to create draft: $!";
