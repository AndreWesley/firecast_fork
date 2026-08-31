use strict; use warnings; use utf8;
# gen_nature.pl <tsv> <half:en|pt> <out.lua>
# TSV columns: name \t book title \t printed page \t text (paragraphs as literal \n\n)
binmode(STDOUT, ':encoding(UTF-8)');
my ($TSV, $HALF, $OUT) = @ARGV;
my $pageWord = ($HALF eq 'pt') ? 'pág.' : 'p.';

open(my $t, '<:encoding(UTF-8)', $TSV) or die "$TSV: $!";
my @rows;
while (my $l = <$t>) {
    chomp $l;
    next unless $l =~ /\S/;
    # five columns: the fifth is the extractor's provenance flag and never reaches the module
    my ($name, $book, $page, $text, $prov) = split /\t/, $l, 5;
    die "linha sem texto: $name\n" unless defined $text && length $text;
    push @rows, [$name, $book, $page, $text];
}
close $t;

my $head = <<"HEAD";
-- Nature/Demeanor archetype descriptions, the [$HALF] half (SPEC I102e, I21, V210 / T838).
--
-- One entry per item of PICKER_LIST["nature"], which IS PICKER_LIST["demeanor"] - one table
-- serves both rows (WoD20th.lfm), so one module serves both. Keyed in ENGLISH because that is
-- what the sheet saves (SPEC V24). Three blocks, exactly as the ten description modules
-- already do: "<Book>, p. <n>" - blank - blank - <Name> - blank - blank - <text>. The book
-- title does not translate; only p./pág. does (SPEC I100e).
--
-- PARTIAL BY MEASURE, and that is a decision, not a gap (user 2026-08-30): the picker offers
-- 68 archetypes and 46 have a usable description in the books on disk. The other 22 open the
-- box and fall to V360c's sentence through descText's empty answer (SPEC V365c, V364b) - the
-- right reply, because what they lack is a FILE. Six of the 22 - Bureaucrat, Comedian,
-- Grifter, Optimist, Pragmatist and Trendsetter - appear ZERO times across all 25 PDFs in the
-- library, so they come from a book nobody here has yet.
--
-- Eighteen seam repairs are recorded in the extractor, each confirmed against its page by the
-- user: a page turn cuts a word in half and the halves read like prose, so they cannot be
-- spotted by rule. The extractor is deterministic - it was NOT, and every count taken before
-- that was a sample of a coin toss (a `my $b` loop variable was shadowing sort's $b).
--
-- One module PER LANGUAGE and never both halves in one file (SPEC V210).
--
-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24).
-- Extracted from the PDFs by scratchpad/arch_extract.pl; page numbers are the PRINTED page,
-- taken with each book's offset from research/README.md. Do not hand-edit.

return {
\t\t\t\t-- >>> NATURE_DESC_BEGIN (generated - SPEC T838)
HEAD

open(my $o, '>:encoding(UTF-8)', $OUT) or die "$OUT: $!";
print $o $head;
for my $r (@rows) {
    my ($name, $book, $page, $text) = @$r;
    $text =~ s/\\n/\n/g;                 # literal \n in the TSV becomes a real newline
    print $o "\t\t\t\t[\"$name\"] = {\n";
    print $o "\t\t\t\t\t$HALF = [==[$book, $pageWord $page\n\n\n$name\n\n\n$text]==],\n";
    print $o "\t\t\t\t},\n";
}
print $o "\t\t\t\t-- <<< NATURE_DESC_END\n};\n";
close $o;
printf STDERR "%s: %d entradas\n", $OUT, scalar(@rows);
