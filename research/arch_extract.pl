use strict; use warnings; use utf8;   # literais do proprio script tem travessao e aspas curvas
# arch_extract.pl  -- one archetype description per line of TSV: name \t book \t printed page \t text
# Text keeps paragraph breaks as literal \n\n. Precedence follows research/README.md
# (core first), extended to the other game lines for a World of Darkness sheet.
binmode(STDOUT, ':encoding(UTF-8)');
binmode(STDERR, ':encoding(UTF-8)');
my $SC = $ENV{ARCH_DIR} || "./";   # onde estao books/*.txt e arch_names.txt (veja README)

# file tag => [ title for block 1, page offset (pdf = printed + offset) ]
my @BOOKS = (
  ["vampire_the_masquerade___20th_anniversary_edition", "Vampire: The Masquerade 20th Anniversary Edition", 8],
  ["Werewolf_W20",            "Werewolf: The Apocalypse 20th Anniversary Edition", 2],
  ["Mage___The_Ascension",    "Mage: The Ascension 20th Anniversary Edition",      1],
  ["_Vampiro_V20___Dark_Ages___Livro_Base", "Vampire: The Dark Ages 20th Anniversary Edition", 1],
  ["Mage___Book_of_Secrets",  "Mage: The Book of Secrets",                         1],
  ["Vampiro_V20___Lore_of_the_Clans", "Lore of the Clans",                          1],
  ["Vampiro_V20___Dark_Ages___Lore_of_the_Bloodlines", "Lore of the Bloodlines",    1],
  ["Vampire_V20___Anarchs_Unbound", "Anarchs Unbound",                              1],
  ["Mage___Technocracy_Reloaded", "Mage: Technocracy Reloaded",                     1],
);

open(my $nf, '<:encoding(UTF-8)', $SC."arch_names.txt") or die $!;
my @names = grep { /\S/ } map { my $x = $_; $x =~ s/\s+$//; $x } <$nf>;
close $nf;
my %isName = map { $_ => 1 } @names;

sub gutter {
    my @l = @_;
    my $w = 0; for (@l) { $w = length($_) if length($_) > $w }
    return 0 if $w < 60;
    my @blank;
    for my $c (0..$w-1) {
        my ($n,$t) = (0,0);
        for my $line (@l) { next unless $line =~ /\S/; $t++;
            my $ch = ($c < length($line)) ? substr($line,$c,1) : ' '; $n++ if $ch eq ' ' }
        push @blank, $c if $t >= 5 && $n >= $t*0.97;
    }
    my (@runs,@cur);
    for my $c (@blank) { if (@cur && $c==$cur[-1]+1) { push @cur,$c } else { push @runs,[@cur] if @cur; @cur=($c) } }
    push @runs, [@cur] if @cur;
    @runs = grep { @$_ >= 3 && $_->[0] > $w*0.30 && $_->[0] < $w*0.75 } @runs;
    # Tie-break on the column, ALWAYS: two runs of equal width are otherwise ordered by
    # whatever sort happens to do, and the whole extraction downstream changes with it.
    @runs = sort { scalar(@$b) <=> scalar(@$a) || $a->[0] <=> $b->[0] } @runs;
    return @runs ? $runs[0][0] : 0;
}

my %got;
for my $bk (@BOOKS) {   # NAO chamar de $b: sombreia o $b do sort e a ordem vira aleatoria
    my ($tag, $title, $off) = @$bk;
    my $path = $SC."books/$tag.txt";
    open(my $fh, '<:encoding(UTF-8)', $path) or do { warn "sem $tag\n"; next };
    local $/; my $txt = <$fh>; close $fh;
    my @pages = split /\f/, $txt;

    # A page whose gutter cannot be detected - one wide line straddling it is enough - would
    # lose every heading in its right column. The book's OWN most common gutter is the right
    # fallback: these are laid out to one grid, so the page that hides it still sits on it.
    my %gcount;
    for my $pg (@pages) { my $g = gutter(split /\n/, $pg); $gcount{$g}++ if $g }
    # Perl randomises hash order PER PROCESS, so a tie here made the whole extraction come out
    # different on every run - 31, 34, 39, 42 accepted from the same input. The tie-break on
    # the column number is what makes this reproducible at all.
    my ($modeG) = sort { $gcount{$b} <=> $gcount{$a} || $a <=> $b } keys %gcount;
    $modeG = 0 unless defined $modeG;

    for my $pi (0..$#pages) {
        my @raw = split /\n/, $pages[$pi];
        my $g = gutter(@raw);
        # The book's usual gutter is only a candidate, NEVER a command: a page laid out
        # differently gets sliced mid-word by a foreign split, and the corruption is silent -
        # "apathetic cowards" came out "apathet cowards" and read almost like prose. So the
        # fallback has to pass the SAME blank test on THIS page, just at a lower bar.
        my $viaFallback = 0;
        if (!$g && $modeG) {
            my ($n, $t) = (0, 0);
            for my $line (@raw) {
                next unless $line =~ /\S/;
                $t++;
                my $ch = ($modeG < length($line)) ? substr($line, $modeG, 1) : ' ';
                $n++ if $ch eq ' ';
            }
            if ($t >= 5 && $n >= $t * 0.90) { $g = $modeG; $viaFallback = 1 }
        }
        my @lin;
        if ($g) {
            push @lin, map { my $s=substr($_,0,$g); $s=~s/\s+$//; $s } @raw;
            push @lin, "";
            push @lin, map { my $s=(length($_)>$g)?substr($_,$g):""; $s=~s/\s+$//; $s } @raw;
        } else { @lin = @raw }

        for my $i (0..$#lin) {
            my $h = $lin[$i]; $h =~ s/^\s+|\s+$//g;
            next unless $isName{$h};
            next if $got{$h};
            # collect until the next known heading, capped
            my @body;
            for my $j ($i+1 .. ($i+70 > $#lin ? $#lin : $i+70)) {
                my $t = $lin[$j]; my $tt = $t; $tt =~ s/^\s+|\s+$//g;
                last if $isName{$tt};
                push @body, $t;
            }
            # a heading with no prose under it is a table-of-contents hit, not the entry
            my $prose = join(" ", grep { /\S/ } @body);
            next if length($prose) < 220;
            $got{$h} = { title => $title, page => $pi + 1 - $off, body => [@body], fb => $viaFallback };
        }
    }
}

# Debris the page/column seam leaves that no rule can spot generically - a word cut in two by
# a page break, a stray letter carried over from the neighbouring column. Confirmed against the
# books by the user 2026-08-30. Kept as data so re-running the extractor cannot lose them, and
# so each one stays auditable against its page (V20 p.88, M20 p.268).
my %FIX = (
    "Autocrat"    => [ ["a cote- , rie.", "a coterie."] ],
    "Dabbler"     => [ ["but focuses , on nothing", "but focuses on nothing"] ],
    "Deviant"     => [ ["you are able e to flout", "you are able to flout"] ],
    # The Dark Ages book puts Regain in its own paragraph and writes it WITHOUT the em dash
    # V20 uses - the other five DA entries already come out that way, so this one is being
    # put back onto its book's own shape, not onto V20's (user 2026-08-30).
    "Philosopher" => [ ["and patterns. . Regain", "and patterns.\\n\\nRegain"] ],

    # Confirmed against the book text itself, not guessed: the fragment was looked up in the
    # source and the full reading taken from there.
    "Celebrant"   => [ ["foiling her riva or reading", "foiling her rivals, or reading"] ],
    "Conniver"    => [ ["salespeople urchins", "salespeople, urchins"] ],
    "Hacker"      => [ ["limits just you off", "limits just piss you off"] ],
    "Rebel"       => [ ["likely that he be authority figures", "likely that he bears authority figures"] ],
    "Sadist"      => [ ["at one time or ars another", "at one time or another"] ],

    # The typesetter's own hyphenation, split by the column cut and left as two tokens.
    "Curmudgeon"  => [ ["very littl esteem", "very little esteem"] ],
    "Director"    => [ ["Coaches, teach ers,", "Coaches, teachers,"] ],
    "Judge"       => [ ["most effi cient model", "most efficient model"] ],
    "Traditionalist" => [ ["Conservatives, judgt es,", "Conservatives, judges,"] ],
    "Masochist"   => [ ["He - gains satisfaction", "He gains satisfaction"] ],

    # Seam debris the source could not settle either way; read and confirmed by the user
    # 2026-08-30. Enigma's missing full stop is the only NORMALISATION here - the other three
    # are characters the column cut carried in from somewhere else.
    "Fanatic"     => [ ["- — Regain a point", "— Regain a point"] ],
    "Machine"     => [ ["managed to do. d.", "managed to do."] ],
    "Soldier"     => [ ["A Storyteller discretion, pulling", "At Storyteller discretion, pulling"] ],
    "Enigma"      => [ ["the Enigma Archetype\\n\\n", "the Enigma Archetype.\\n\\n"] ],
);

my ($kept, %why) = (0);
for my $n (@names) {
    next unless $got{$n};
    my @b = @{ $got{$n}{body} };

    # Running heads and folios are page furniture, not prose, and they land INSIDE an entry
    # that spans a page break: "88  CHAPTER THREE: CHARACTER AND TRAITS", "APPENDIX  487",
    # "VAMPIRE THE MASQUERADE 20th ANNIVERSARY EDITION". Drop them before paragraphs form.
    @b = grep {
        my $s = $_; $s =~ s/^\s+|\s+$//g;
        !( $s =~ /^\d{1,4}$/                       # a bare folio
        || $s =~ /^\d{1,4}\s+[A-Z][A-Z .:'’-]{6,}$/ # folio then running head
        || $s =~ /^[A-Z][A-Z .:'’-]{6,}\s+\d{1,4}$/ # running head then folio
        || $s =~ /^[A-Z][A-Z0-9 .:'’-]{14,}$/      # an all-caps running head alone
        || $s =~ /^[A-Z][A-Za-z0-9 .:'’-]{14,}$/   # ... including "20th" inside it, and the
                                                   # column cut can lop its first letters off,
                                                   # so this must not anchor on a whole word
           && $s !~ /[a-z]{4,}/ )                   # but real prose has long lowercase runs
    } @b;

    while (@b && $b[-1] !~ /\S/) { pop @b }
    my @paras; my $cur = "";
    for my $l (@b) {
        if ($l !~ /\S/) { push @paras, $cur if $cur =~ /\S/; $cur = ""; next }
        my $s = $l; $s =~ s/^\s+//; $s =~ s/\s+$//;
        if ($cur =~ /\S/) {
            # A trailing hyphen is only a LINE BREAK when the word continues in lower case.
            # "Thrill-" + "Seeker" is the term's own hyphen, and eating it gave "ThrillSeeker".
            if ($cur =~ /\w-$/ && $s =~ /^[a-z]/) { $cur =~ s/-$//; $cur .= $s }
            else { $cur .= " " . $s }
        } else { $cur = $s }
    }
    push @paras, $cur if $cur =~ /\S/;

    # A page turn splits a sentence and pdftotext reports the halves as two paragraphs:
    # "...may crave a title, or" + "he may wish to be recognized...". The tell is unambiguous -
    # the first half ends on no terminal punctuation and the second opens in lower case - so
    # these are joined back rather than shipped as a paragraph break the book never had.
    my @j;
    for my $p (@paras) {
        if (@j && $j[-1] !~ /[.!?:;”"’']\s*$/ && $p =~ /^[a-z]/) { $j[-1] .= " " . $p }
        else { push @j, $p }
    }
    @paras = @j;

    # EVERY archetype entry in every one of these books ends on its "Regain ... Willpower"
    # line. That is the boundary, and it is the book's own - not a line count I picked. Cutting
    # there is what stops an entry from swallowing the heading that follows it, which is how
    # `Bravo` came out carrying the whole of `Capitalist`.
    my $end = -1;
    for my $i (0..$#paras) { if ($paras[$i] =~ /Regain\b/) { $end = $i; last } }
    if ($end < 0) { $why{$n} = "sem linha Regain"; next }
    @paras = @paras[0..$end];
    my $text = join("\\n\\n", @paras);
    $text =~ s/\t/ /g;
    $text =~ s/\s{2,}/ /g;
    if ($FIX{$n}) {
        for my $p (@{ $FIX{$n} }) {
            my ($from, $to) = @$p;
            warn "FIX nao casou em $n: '$from'\n" unless index($text, $from) >= 0;
            $text =~ s/\Q$from\E/$to/g;
        }
    }

    # Two Regains in one entry means the columns bled into each other: the page was split at
    # the wrong place and the neighbouring entry is riding along. Unusable, and it reads like
    # prose, so it has to be REFUSED here rather than spotted by eye later.
    my $regains = () = $text =~ /Regain\b/g;
    if ($regains > 1)        { $why{$n} = "sopa de coluna ($regains x Regain)"; next }
    if (length($text) < 200) { $why{$n} = "curta demais"; next }

    $kept++;
    print join("\t", $n, $got{$n}{title}, $got{$n}{page}, $text, $got{$n}{fb} ? "FB" : "OK"), "\n";
}
printf STDERR "aceitas: %d de %d achadas (%d nomes na lista)\n", $kept, scalar(keys %got), scalar(@names);
printf STDERR "  recusadas: %s\n", join("; ", map { "$_ [$why{$_}]" } sort keys %why) if %why;
