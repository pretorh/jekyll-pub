#!/usr/bin/perl
use warnings;
use File::Copy;
use File::Basename;

my $resources = dirname(__FILE__);

my $draft = $ARGV[0];
$draft =~ /(.*)\/_drafts\/.+\.(.+)/;
my ($root, $ext) = ($1, $2);
my $posts = "$root/_posts";

my $title = getTitle($draft);
$title = (`$resources/jekyll-titlize.pl $title`)[0];
chomp $title;

mkdir $posts;
print "$draft -> $posts/$title.$ext\n";
move($draft, "$posts/$title.$ext") or die "Failed to publish: $!";

sub getTitle {
    my ($file) = @_;
    open(FILE, "<$file");
    my @lines = <FILE>;
    close(FILE);

    my $line = (grep /^title: .+$/,@lines)[0];
    $line =~ /^title:\s+(.+)$/;
    return $1;
}
