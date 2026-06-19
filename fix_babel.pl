use strict; use warnings;

open my $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
local $/; my $html = <$fh>; close $fh;

# Extract CHSB_HOSPITAL_UNITS block from inside <script type="text/babel">
# and RCH_CLINICIANS block — move them to a plain <script> tag before Babel

# 1. Pull out the two const declarations from the babel script
my ($rch_block)   = $html =~ /(const RCH_CLINICIANS = \[.*?\];\n\n)/s;
my ($units_block) = $html =~ /(const CHSB_HOSPITAL_UNITS = \{.*?\};\n\n)/s;

unless ($rch_block && $units_block) {
    die "Could not extract data blocks!\nRCH found: " . (defined $rch_block ? 'yes' : 'no') .
        "\nUnits found: " . (defined $units_block ? 'yes' : 'no') . "\n";
}

print "RCH block: " . length($rch_block) . " bytes\n";
print "Units block: " . length($units_block) . " bytes\n";

# 2. Remove them from inside the babel script
$html =~ s/\Q$rch_block\E//s;
$html =~ s/\Q$units_block\E//s;

# 3. Create a plain <script> tag with both blocks and insert before <script type="text/babel">
my $plain_script = "<script>\n/* Pre-defined data — outside Babel to avoid parse overhead */\n$rch_block$units_block</script>\n";

$html =~ s|(<script type="text/babel">)|$plain_script$1|;

open my $out, '>', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
print $out $html; close $out;

printf "Done. File size: %.1f KB\n", (-s 'C:/Users/youha/Claude projects/radiology-directory/index.html')/1024;

# Quick sanity checks
open $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
$html = <$fh>; close $fh;
print "Plain script tag with data: " . ($html =~ /Pre-defined data/ ? 'YES' : 'NO') . "\n";
print "RCH_CLINICIANS still defined: " . ($html =~ /const RCH_CLINICIANS/ ? 'YES' : 'NO') . "\n";
print "CHSB_HOSPITAL_UNITS still defined: " . ($html =~ /const CHSB_HOSPITAL_UNITS/ ? 'YES' : 'NO') . "\n";

# Count how many const declarations are in the babel tag (should be 0 for the two big ones)
my ($babel_content) = $html =~ /<script type="text\/babel">(.*?)<\/script>/s;
print "RCH in babel tag: " . ($babel_content =~ /const RCH_CLINICIANS/ ? 'YES (bad!)' : 'NO (good)') . "\n";
print "Units in babel tag: " . ($babel_content =~ /const CHSB_HOSPITAL_UNITS/ ? 'YES (bad!)' : 'NO (good)') . "\n";
