use strict; use warnings;

open my $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
local $/; my $html = <$fh>; close $fh;

my $units_js = 'const CHSB_HOSPITAL_UNITS = {
  id: \'chsb-units\',
  name: \'Hospital Units\',
  entries: [
    /* Floors & Patient Units */
    { id:\'cu01\', label:\'3rd Floor\',                  display:\'909-887-6333 x37300\', dialString:\'9098876333,,9,,37300\' },
    { id:\'cu02\', label:\'4th Floor\',                  display:\'909-887-6333 x37400\', dialString:\'9098876333,,9,,37400\' },
    { id:\'cu03\', label:\'5th Floor (Line 1)\',          display:\'909-887-6333 x37500\', dialString:\'9098876333,,9,,37500\' },
    { id:\'cu04\', label:\'5th Floor (Line 2)\',          display:\'909-887-6333 x37550\', dialString:\'9098876333,,9,,37550\' },
    { id:\'cu05\', label:\'Couplet Care (Line 1)\',       display:\'909-887-6333 x33761\', dialString:\'9098876333,,9,,33761\' },
    { id:\'cu06\', label:\'Couplet Care (Line 2)\',       display:\'909-887-6333 x33762\', dialString:\'9098876333,,9,,33762\' },
    { id:\'cu07\', label:\'ER (Line 1)\',                 display:\'909-887-6333 x63550\', dialString:\'9098876333,,9,,63550\', note:\'ER Charge: x2310\' },
    { id:\'cu08\', label:\'ER (Line 2)\',                 display:\'909-887-6333 x33570\', dialString:\'9098876333,,9,,33570\' },
    { id:\'cu09\', label:\'ER Physician\',                display:\'909-887-6333 x33553\', dialString:\'9098876333,,9,,33553\' },
    { id:\'cu10\', label:\'ER RAP Room (Line 1)\',        display:\'909-887-6333 x61646\', dialString:\'9098876333,,9,,61646\' },
    { id:\'cu11\', label:\'ER RAP Room (Line 2)\',        display:\'909-887-6333 x37036\', dialString:\'9098876333,,9,,37036\' },
    { id:\'cu12\', label:\'ICCU 1 (Beds 1-11)\',          display:\'909-887-6333 x33310\', dialString:\'9098876333,,9,,33310\' },
    { id:\'cu13\', label:\'ICCU 2 (Beds 12-22)\',         display:\'909-887-6333 x33300\', dialString:\'9098876333,,9,,33300\' },
    { id:\'cu14\', label:\'L&D (Line 1)\',                display:\'909-887-6333 x37251\', dialString:\'9098876333,,9,,37251\' },
    { id:\'cu15\', label:\'L&D (Line 2)\',                display:\'909-887-6333 x37252\', dialString:\'9098876333,,9,,37252\' },
    { id:\'cu16\', label:\'Nursery / NICU (Line 1)\',     display:\'909-887-6333 x37242\', dialString:\'9098876333,,9,,37242\' },
    { id:\'cu17\', label:\'Nursery / NICU (Line 2)\',     display:\'909-887-6333 x37241\', dialString:\'9098876333,,9,,37241\' },
    { id:\'cu18\', label:\'NCUW (Beds 1-16)\',            display:\'909-887-6333 x33151\', dialString:\'9098876333,,9,,33151\' },
    { id:\'cu19\', label:\'NCUE (Beds 17-31)\',           display:\'909-887-6333 x33191\', dialString:\'9098876333,,9,,33191\' },
    { id:\'cu20\', label:\'NCUN (Beds 32-48)\',           display:\'909-887-6333 x33100\', dialString:\'9098876333,,9,,33100\' },
    { id:\'cu21\', label:\'Pediatrics\',                  display:\'909-887-6333 x33700\', dialString:\'9098876333,,9,,33700\' },
    { id:\'cu22\', label:\'Post Partum\',                 display:\'909-887-6333 x37231\', dialString:\'9098876333,,9,,37231\' },
    { id:\'cu23\', label:\'Psych - Open (901-923)\',      display:\'909-887-6333 x33900\', dialString:\'9098876333,,9,,33900\' },
    { id:\'cu24\', label:\'Psych - North (930-939)\',     display:\'909-887-6333 x33830\', dialString:\'9098876333,,9,,33830\' },
    { id:\'cu25\', label:\'Psych - West (1-6)\',          display:\'909-887-6333 x33800\', dialString:\'9098876333,,9,,33800\' },
    { id:\'cu26\', label:\'Psych - East (7-15)\',         display:\'909-887-6333 x33850\', dialString:\'9098876333,,9,,33850\' },
    { id:\'cu27\', label:\'PSA\',                         display:\'909-887-6333 x34571\', dialString:\'9098876333,,9,,34571\' },
    /* Surgery */
    { id:\'cu28\', label:\'OP Surgery (2nd Floor)\',      display:\'909-887-6333 x33245\', dialString:\'9098876333,,9,,33245\' },
    { id:\'cu29\', label:\'OP Surgery Scheduling\',       display:\'909-887-6333 x33206\', dialString:\'9098876333,,9,,33206\' },
    { id:\'cu30\', label:\'PACU - Recovery\',             display:\'909-887-6333 x37276\', dialString:\'9098876333,,9,,37276\' },
    { id:\'cu31\', label:\'Surgery (Line 1)\',            display:\'909-887-6333 x37297\', dialString:\'9098876333,,9,,37297\' },
    { id:\'cu32\', label:\'Surgery (Line 2)\',            display:\'909-887-6333 x37299\', dialString:\'9098876333,,9,,37299\' },
    /* Departments */
    { id:\'cu33\', label:\'Admitting - Tower (Line 1)\',  display:\'909-887-6333 x61302\', dialString:\'9098876333,,9,,61302\' },
    { id:\'cu34\', label:\'Admitting - Tower (Line 2)\',  display:\'909-887-6333 x61308\', dialString:\'9098876333,,9,,61308\' },
    { id:\'cu35\', label:\'Admitting - CMP\',             display:\'909-887-6333 x4811\',  dialString:\'9098876333,,9,,4811\'  },
    { id:\'cu36\', label:\'Cardiopulmonary (Line 1)\',    display:\'909-887-6333 x61425\', dialString:\'9098876333,,9,,61425\' },
    { id:\'cu37\', label:\'Cardiopulmonary (Line 2)\',    display:\'909-887-6333 x62361\', dialString:\'9098876333,,9,,62361\' },
    { id:\'cu38\', label:\'Echo Lab\',                    display:\'909-887-6333 x61423\', dialString:\'9098876333,,9,,61423\' },
    { id:\'cu39\', label:\'EEG Lab\',                     display:\'909-887-6333 x61453\', dialString:\'9098876333,,9,,61453\' },
    { id:\'cu40\', label:\'Laboratory (Line 1)\',         display:\'909-887-6333 x61432\', dialString:\'9098876333,,9,,61432\' },
    { id:\'cu41\', label:\'Laboratory (Line 2)\',         display:\'909-887-6333 x61471\', dialString:\'9098876333,,9,,61471\' },
    { id:\'cu42\', label:\'Medical Records (Line 1)\',    display:\'909-887-6333 x61500\', dialString:\'9098876333,,9,,61500\' },
    { id:\'cu43\', label:\'Medical Records (Line 2)\',    display:\'909-887-6333 x61555\', dialString:\'9098876333,,9,,61555\' },
    { id:\'cu44\', label:\'Pharmacy\',                    display:\'909-887-6333 x61402\', dialString:\'9098876333,,9,,61402\' },
    { id:\'cu45\', label:\'Stress Lab\',                  display:\'909-887-6333 x33872\', dialString:\'9098876333,,9,,33872\' },
    { id:\'cu46\', label:\'House Supervisor\',            display:\'909-887-6333 x61800\', dialString:\'9098876333,,9,,61800\' },
    /* Medical Imaging */
    { id:\'cu47\', label:\'Angio (Line 1)\',              display:\'909-887-6333 x37171\', dialString:\'9098876333,,9,,37171\' },
    { id:\'cu48\', label:\'Angio (Line 2)\',              display:\'909-887-6333 x37159\', dialString:\'9098876333,,9,,37159\' },
    { id:\'cu49\', label:\'Angio (Line 3)\',              display:\'909-887-6333 x37156\', dialString:\'9098876333,,9,,37156\' },
    { id:\'cu50\', label:\'CT\',                          display:\'909-887-6333 x37169\', dialString:\'9098876333,,9,,37169\' },
    { id:\'cu51\', label:\'Front Desk (Line 1)\',         display:\'909-887-6333 x37151\', dialString:\'9098876333,,9,,37151\' },
    { id:\'cu52\', label:\'Front Desk (Line 2)\',         display:\'909-887-6333 x37152\', dialString:\'9098876333,,9,,37152\' },
    { id:\'cu53\', label:\'Front Desk (Line 3)\',         display:\'909-887-6333 x37179\', dialString:\'9098876333,,9,,37179\' },
    { id:\'cu54\', label:\'Mammography\',                 display:\'909-887-6333 x61466\', dialString:\'9098876333,,9,,61466\' },
    { id:\'cu55\', label:\'MRI\',                         display:\'909-887-6333 x61709\', dialString:\'9098876333,,9,,61709\' },
    { id:\'cu56\', label:\'NM (Line 1)\',                 display:\'909-887-6333 x37161\', dialString:\'9098876333,,9,,37161\' },
    { id:\'cu57\', label:\'NM (Line 2)\',                 display:\'909-887-6333 x37164\', dialString:\'9098876333,,9,,37164\' },
    { id:\'cu58\', label:\'Operation Area (Line 1)\',     display:\'909-887-6333 x37165\', dialString:\'9098876333,,9,,37165\' },
    { id:\'cu59\', label:\'Operation Area (Line 2)\',     display:\'909-887-6333 x37172\', dialString:\'9098876333,,9,,37172\' },
    { id:\'cu60\', label:\'Operation Area (Line 3)\',     display:\'909-887-6333 x37177\', dialString:\'9098876333,,9,,37177\' },
    { id:\'cu61\', label:\'Radiologist Reading Room\',    display:\'909-887-6333 x37163\', dialString:\'9098876333,,9,,37163\' },
    { id:\'cu62\', label:\'Ultrasound\',                  display:\'909-887-6333 x61678\', dialString:\'9098876333,,9,,61678\' },
    { id:\'cu63\', label:\'US Room #1\',                  display:\'909-887-6333 x37160\', dialString:\'9098876333,,9,,37160\' },
    { id:\'cu64\', label:\'Scheduling (Direct)\',         display:\'909-806-1225\',         dialString:\'9098061225\' },
    /* ER Detail */
    { id:\'cu65\', label:\'ER - Castle\',                 display:\'909-887-6333 x33593\', dialString:\'9098876333,,9,,33593\' },
    { id:\'cu66\', label:\'ER - Breakroom\',              display:\'909-887-6333 x37035\', dialString:\'9098876333,,9,,37035\' },
    { id:\'cu67\', label:\'ER - Triage 1\',               display:\'909-887-6333 x33575\', dialString:\'9098876333,,9,,33575\' },
    { id:\'cu68\', label:\'ER - Triage 2\',               display:\'909-887-6333 x33578\', dialString:\'9098876333,,9,,33578\' },
    { id:\'cu69\', label:\'ER - Triage 3\',               display:\'909-887-6333 x33573\', dialString:\'9098876333,,9,,33573\' },
    { id:\'cu70\', label:\'ER - Triage 4\',               display:\'909-887-6333 x33592\', dialString:\'9098876333,,9,,33592\' },
    /* Imaging Management / PACS */
    { id:\'cu71\', label:\'Tim Seavey - DMI Director (Direct)\', display:\'909-806-1936\', dialString:\'9098061936\' },
    { id:\'cu72\', label:\'Tim Seavey - DMI Director (Cell)\',   display:\'909-936-4607\', dialString:\'9099364607\' },
    { id:\'cu73\', label:\'Amy Baglin - DMI Manager (Direct)\',  display:\'909-806-1935\', dialString:\'9098061935\' },
    { id:\'cu74\', label:\'Amy Baglin - DMI Manager (Cell)\',    display:\'760-688-9348\', dialString:\'7606889348\' },
    { id:\'cu75\', label:\'Matt Quiba - PACS Admin\',            display:\'909-887-6333 x61499\', dialString:\'9098876333,,9,,61499\' },
    { id:\'cu76\', label:\'Gerrad Smith - PACS On-Call (Cell)\', display:\'909-641-1547\', dialString:\'9096411547\' },
  ]
};

';

# 1. Insert constant before DEFAULT_HOSPITALS comment
$html =~ s|(\/\* ── Default Data ──)|$units_js$1|;

# 2. Append CHSB_HOSPITAL_UNITS to CHSB categories array in DEFAULT_HOSPITALS
# The CHSB block ends with: clinicians: []  }  (after categories array)
$html =~ s|(id: 'chsb',\n    name: 'CHSB',\n    fullName: 'Community Hospital San Bernardino',\n    color: '#007AFF',\n    categories: \[\n      \{)(.*?)(\n    \],\n    clinicians: \[\]\n  \})|$1$2,\n      CHSB_HOSPITAL_UNITS$3|s;

# 3. Update useState migration
my $old = "      return base.map(h => {\n        if (h.id === 'rch' && (!h.clinicians || h.clinicians.length < 100))\n          return { ...h, clinicians: RCH_CLINICIANS };\n        if (h.id === 'chsb' && !h.categories.find(c => c.id === 'chsb-units'))\n          return { ...h, categories: [...h.categories, CHSB_HOSPITAL_UNITS] };\n        return h;\n      });";

# Only update if not already done
unless ($html =~ /chsb-units/) {
    my $old2 = "      return base.map(h =>\n        h.id === 'rch' && (!h.clinicians || h.clinicians.length < 100)\n          ? { ...h, clinicians: RCH_CLINICIANS }\n          : h\n      );";
    my $new2 = "      return base.map(h => {\n        if (h.id === 'rch' && (!h.clinicians || h.clinicians.length < 100))\n          return { ...h, clinicians: RCH_CLINICIANS };\n        if (h.id === 'chsb' && !h.categories.find(c => c.id === 'chsb-units'))\n          return { ...h, categories: [...h.categories, CHSB_HOSPITAL_UNITS] };\n        return h;\n      });";
    $html =~ s/\Q$old2\E/$new2/;
}

open my $out, '>', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
print $out $html; close $out;

# Verify
my $units_count = () = $html =~ /id:'cu\d+'/g;
my $has_const   = $html =~ /const CHSB_HOSPITAL_UNITS/ ? 'YES' : 'NO';
my $has_migrate = $html =~ /chsb-units/ ? 'YES' : 'NO';
printf "CHSB_HOSPITAL_UNITS constant: %s\n", $has_const;
printf "Migration logic: %s\n", $has_migrate;
printf "Entries injected: %d\n", $units_count;
printf "File size: %.1f KB\n", (-s 'C:/Users/youha/Claude projects/radiology-directory/index.html')/1024;
