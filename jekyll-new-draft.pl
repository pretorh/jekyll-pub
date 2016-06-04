#!/usr/bin/perl
use warnings;
use File::Basename;

my $resources = dirname(__FILE__);
my $drafts = "_drafts";

my $title = @ARGV ? $ARGV[0] : "new";
my $filename = `$resources/jekyll-titlize.pl "$title"` or die "failed to get title: $!";
chomp $filename;
$filename = "$drafts/$filename.md";

mkdir $drafts or die "failed to create drafts dir $drafts: $!";
my $command = "sed -e 's/^title: .*\$/title: \"$title\"/' $resources/draft-template.md > $filename";
print "$command\n";
system($command) and die "Failed to create draft: $!";
