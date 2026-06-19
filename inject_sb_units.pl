use strict; use warnings;

open my $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
local $/; my $html = <$fh>; close $fh;

# ── SB Hospital Units constant ──────────────────────────────────────────────
# Main SB line: 9098838711,,2 (press 2 then extension)
# Direct lines dial straight through

my $sb_units_js = 'const SB_HOSPITAL_UNITS = {
  id: \'sb-units\',
  name: \'Hospital Units\',
  entries: [
    /* ICU */
    { id:\'sb01\', label:\'ICU (Direct)\',                   display:\'909-654-0110\',          dialString:\'9096540110\' },
    { id:\'sb02\', label:\'ICU Fellows (Line 1, 24/7)\',     display:\'909-883-8711 x21601\',   dialString:\'9098838711,,2,,21601\', note:\'Held 24/7 — use for ICU critical findings\' },
    { id:\'sb03\', label:\'ICU Fellows (Line 2, 24/7)\',     display:\'909-883-8711 x21607\',   dialString:\'9098838711,,2,,21607\', note:\'Held 24/7 — use for ICU critical findings\' },
    /* OB / Maternal */
    { id:\'sb04\', label:\'Mother Baby\',                    display:\'909-654-0119\',          dialString:\'9096540119\' },
    { id:\'sb05\', label:\'Labor & Delivery\',               display:\'909-266-6614\',          dialString:\'9092666614\' },
    { id:\'sb06\', label:\'NICU\',                           display:\'909-654-0118\',          dialString:\'9096540118\' },
    /* Floors */
    { id:\'sb07\', label:\'4 NS\',                           display:\'909-289-9369\',          dialString:\'9092899369\' },
    { id:\'sb08\', label:\'4 EW\',                           display:\'909-665-2101\',          dialString:\'9096652101\' },
    { id:\'sb09\', label:\'5 NS\',                           display:\'909-665-0528\',          dialString:\'9096650528\' },
    { id:\'sb10\', label:\'5 EW\',                           display:\'909-665-4678\',          dialString:\'9096654678\' },
    { id:\'sb11\', label:\'6 NS\',                           display:\'909-654-0107\',          dialString:\'9096540107\' },
    { id:\'sb12\', label:\'6 EW\',                           display:\'909-654-0108\',          dialString:\'9096540108\' },
    { id:\'sb13\', label:\'6 TN\',                           display:\'909-654-0107\',          dialString:\'9096540107\' },
    /* Other Units */
    { id:\'sb14\', label:\'Respiratory\',                    display:\'909-531-0148\',          dialString:\'9095310148\' },
    { id:\'sb15\', label:\'House Supervisor\',               display:\'909-685-5922\',          dialString:\'9096855922\' },
    { id:\'sb16\', label:\'ED Charge Nurse\',                display:\'909-942-1081\',          dialString:\'9099421081\' },
  ]
};

';

# ── 1. Insert SB_HOSPITAL_UNITS into plain <script> block (alongside CHSB) ──
# Find the closing of the existing plain script tag and insert before it
$html =~ s|(</script>\n<script type="text/babel">)|$sb_units_js$1|;

# ── 2. Append SB_HOSPITAL_UNITS to SB categories in DEFAULT_HOSPITALS ────────
$html =~ s|(id: 'sb',\n    name: 'SB',\n    fullName: 'St\. Bernardine Medical Center',\n    color: '#34C759',\n    categories: \[\n      \{)(.*?)(\n    \],\n    clinicians: \[\]\n  \})|$1$2,\n      SB_HOSPITAL_UNITS$3|s;

# ── 3. Add migration logic for SB alongside CHSB migration ──────────────────
my $old_migrate = "        if (h.id === 'chsb' && !h.categories.find(c => c.id === 'chsb-units'))\n          return { ...h, categories: [...h.categories, CHSB_HOSPITAL_UNITS] };";
my $new_migrate = "        if (h.id === 'chsb' && !h.categories.find(c => c.id === 'chsb-units'))\n          return { ...h, categories: [...h.categories, CHSB_HOSPITAL_UNITS] };\n        if (h.id === 'sb' && !h.categories.find(c => c.id === 'sb-units'))\n          return { ...h, categories: [...h.categories, SB_HOSPITAL_UNITS] };";

$html =~ s/\Q$old_migrate\E/$new_migrate/;

# ── Write ─────────────────────────────────────────────────────────────────────
open my $out, '>', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
print $out $html; close $out;

# ── Verify ────────────────────────────────────────────────────────────────────
open $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
$html = <$fh>; close $fh;

my $sb_entries = () = $html =~ /id:'sb\d+'/g;
printf "SB_HOSPITAL_UNITS constant:  %s\n", ($html =~ /const SB_HOSPITAL_UNITS/     ? 'YES' : 'NO');
printf "SB DEFAULT_HOSPITALS inject: %s\n", ($html =~ /SB_HOSPITAL_UNITS\n    \]/   ? 'YES' : 'NO');
printf "SB migration logic:          %s\n", ($html =~ /sb-units/                    ? 'YES' : 'NO');
printf "SB entries found:            %d\n", $sb_entries;
printf "File size:                   %.1f KB\n", (-s 'C:/Users/youha/Claude projects/radiology-directory/index.html')/1024;
