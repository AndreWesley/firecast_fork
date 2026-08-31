use strict; use warnings;
binmode(STDOUT, ':encoding(UTF-8)');
# qa_words.pl <arch_en.tsv>
# Hunts the WORD, not the entry: PDF column bleed and bad de-hyphenation leave debris that
# reads like prose, so the eye slides past it. Every hit below is printed with its context.

my %OK_SHORT = map { $_ => 1 } qw(
  a an the to of in is it he she we me my by on at as or so no up if do be am us our its his her
  him you your they them their who how why all any few not now new one two own out off per via
  and but for nor yet too was are were has had have i o s t d ll re ve
);

open(my $f, '<:encoding(UTF-8)', $ARGV[0]) or die $!;
my $entries = 0; my $flagged = 0; my $hits = 0;
while (my $l = <$f>) {
    chomp $l;
    next unless $l =~ /\S/;
    my ($name, $book, $page, $text, $prov) = split /\t/, $l, 5;
    next unless defined $text;
    $entries++;
    my $t = $text;
    $t =~ s/\x5Cn/ /g;          # the literal backslash-n that encodes a paragraph break
    $t =~ s/\s+/ /g;

    my @hit;
    # a) a word glued to the next one
    while ($t =~ /([A-Za-z’']*[a-z][A-Z][A-Za-z’']*)/g) { push @hit, ["colado", $1, pos($t)] }
    # b) a short lowercase fragment left after a comma or a broken line
    while ($t =~ /,\s([a-z]{2,4})\./g) { my $w = $1; push @hit, ["fragmento", $w, pos($t)] unless $OK_SHORT{$w} }
    # c) a run of letters with no vowel at all
    while ($t =~ /\b([B-DF-HJ-NP-TV-Zb-df-hj-np-tv-z]{3,})\b/g) { push @hit, ["sem vogal", $1, pos($t)] }
    # d) a space sitting before its punctuation
    while ($t =~ /(\S\s[,.;:])/g) { push @hit, ["espaco antes de pontuacao", $1, pos($t)] }
    # e) the same word twice in a row
    while ($t =~ /\b(\w+)\s+\1\b/gi) { push @hit, ["repetida", $1, pos($t)] }
    # f) a lone letter adrift
    while ($t =~ /\s([b-hj-z])\s/g) { push @hit, ["letra solta", $1, pos($t)] }

    my $fb = (defined $prov && $prov =~ /FB/) ? " [gutter de fallback]" : "";
    next unless @hit || $fb;
    $flagged++;
    printf "\n=== %s  (%s, p.%s)%s\n", $name, $book, $page, $fb;
    my %seen;
    for my $h (@hit) {
        my ($kind, $w, $p) = @$h;
        next if $seen{"$kind|$w|$p"}++;
        $hits++;
        my $from = $p - 55; $from = 0 if $from < 0;
        my $ctx = substr($t, $from, 110);
        $ctx =~ s/^\S*\s//; $ctx =~ s/\s\S*$//;
        printf "   %-26s %-18s ...%s...\n", $kind, "«$w»", $ctx;
    }
    printf "   %-26s %s\n", "(nada apontado)", "so revisar por vir de calha inferida" if !@hit;
}
printf "\n%d entradas, %d com algo a olhar, %d apontamentos\n", $entries, $flagged, $hits;
