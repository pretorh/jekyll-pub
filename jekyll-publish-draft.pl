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
my $final = "$posts/$title.$ext";
print "$draft -> $final\n";
move($draft, $final) or die "Failed to publish: $!";

sub getTitle {
    my ($file) = @_;
    my @lines = getFileLines($file);

    my $line = (grep /^title: .+$/,@lines)[0];
    $line =~ /^title:\s+(.+)$/;
    return $1;
}

sub getFileLines {
    my ($file) = @_;
    open(FILE, "<$file");
    my @lines = <FILE>;
    close(FILE);
    return @lines;
}
