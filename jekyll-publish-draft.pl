#!/usr/bin/perl
use warnings;
use File::Slurp;
use File::Basename;
use DateTime;

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
publish($draft, $final);

sub getTitle {
    my ($file) = @_;
    my @lines = read_file($file);

    my $line = (grep /^title: .+$/,@lines)[0];
    $line =~ /^title:\s+(.+)$/;
    return $1;
}

sub publish {
    my ($s, $d) = @_;
    my @lines = read_file($s);
    @lines = addCurrentDateAfterTitleLine(@lines);
    write_file($d, @lines);
    unlink $s or "failed to remove draft: $!";
}

sub addCurrentDateAfterTitleLine {
    my (@lines) = @_;
    @lines = grep { not $_ =~ /^date: \d+/ } @lines;
    my ($index) = grep { $lines[$_] =~ /^title/ } 0..$#lines;
    my $now = DateTime->now()->iso8601().'Z';
    splice @lines, $index, 0, "date: $now\n";
    return @lines;
}
