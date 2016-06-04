#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $root = dirname(__FILE__) . "/..";

my $tmp = "$root/.tmp";
system("rm -rf $tmp");
mkdir $tmp;
chdir $tmp;

# given a draft
system("../$root/jekyll-new-draft.pl") and die "exec failed: $!";
# when publishing
my $draft = "_drafts/new.md";
system("../$root/jekyll-publish-draft.pl $draft") and die "exec failed: $!";

# a new published file exists
my $post = "_posts/new.md";
if (not -f $post) {
    print __FILE__, " failed\n";
    print "post not found: $post\n";
    exit(1);
}

# and the draft is gone
if (-f $draft) {
    print __FILE__, " failed\n";
    print "draft still exists: $draft\n";
    exit(1);
}

# and the date is set in the post
system("grep '^date: ' $post") and die "'date: ' line not found in post";
