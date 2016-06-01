#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $root = dirname(__FILE__) . "/..";

my $tmp = "$root/.tmp";
system("rm -rf $tmp");
mkdir $tmp;

# given a draft
system("$root/jekyll-new-draft.pl $tmp") and die "exec failed: $!";
# when publishing
my $draft = "$tmp/_drafts/new.md";
system("$root/jekyll-publish-draft.pl $draft") and die "exec failed: $!";

# a new published file exists
my $post = "$tmp/_posts/new-post.md";
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
