use strict; use warnings;

open my $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
local $/; my $html = <$fh>; close $fh;

# ─────────────────────────────────────────────────────────────────────────────
# CATEGORY 1: Unit Extensions (internal exts + new charge cells, no dups)
# Existing Hospital Units already has: 909-942-1081, 909-654-0110,
# 909-266-6614, 909-654-0119, 909-654-0118, 909-289-9369, 909-665-2101,
# 909-665-0528, 909-665-4678, 909-654-0107, 909-654-0108, 909-531-0148,
# 909-685-5922, ICU Fellows 21601/21607
# ─────────────────────────────────────────────────────────────────────────────
my $sb_unit_ext = 'const SB_UNIT_EXTENSIONS = {
  id: \'sb-unit-ext\',
  name: \'Unit Extensions\',
  entries: [
    /* CCU / ICU sides via main line */
    { id:\'sbu01\', label:\'ER (Unit Ext)\',            display:\'909-883-8711 x17140\', dialString:\'9098838711,,2,,17140\' },
    { id:\'sbu02\', label:\'CCU Side 1 (Beds 1-6)\',    display:\'909-883-8711 x23845\', dialString:\'9098838711,,2,,23845\' },
    { id:\'sbu03\', label:\'CCU Side 2 (Beds 7-14)\',   display:\'909-883-8711 x23850\', dialString:\'9098838711,,2,,23850\' },
    { id:\'sbu04\', label:\'CCU Side 3 (Beds 15-20)\',  display:\'909-883-8711 x23853\', dialString:\'9098838711,,2,,23853\' },
    { id:\'sbu05\', label:\'CCU Side 4 (Beds 21-26)\',  display:\'909-883-8711 x25849\', dialString:\'9098838711,,2,,25849\' },
    { id:\'sbu06\', label:\'CCU Side 5 (Beds 27-30)\',  display:\'909-883-8711 x25852\', dialString:\'9098838711,,2,,25852\' },
    { id:\'sbu07\', label:\'CCU Side 6 (Beds 31-37)\',  display:\'909-883-8711 x25855\', dialString:\'9098838711,,2,,25855\' },
    { id:\'sbu08\', label:\'CCU Side 7 / DOU (38-47)\', display:\'909-883-8711 x23836\', dialString:\'9098838711,,2,,23836\' },
    /* OB / Maternal */
    { id:\'sbu09\', label:\'L&D (Ext)\',                display:\'909-883-8711 x22050\', dialString:\'9098838711,,2,,22050\' },
    { id:\'sbu10\', label:\'Post-Partum (Ext)\',         display:\'909-883-8711 x23867\', dialString:\'9098838711,,2,,23867\' },
    { id:\'sbu11\', label:\'NICU (Ext)\',               display:\'909-883-8711 x22070\', dialString:\'9098838711,,2,,22070\' },
    /* Floor 4 */
    { id:\'sbu12\', label:\'Floor 4 Charge Cell\',      display:\'909-654-0109\',         dialString:\'9096540109\',            note:\'Charge nurse cell – 4 NS & 4 EW\' },
    { id:\'sbu13\', label:\'4 NS / 4TW NS Tele\',       display:\'909-883-8711 x27201\', dialString:\'9098838711,,2,,27201\' },
    { id:\'sbu14\', label:\'4 EW\',                     display:\'909-883-8711 x22122\', dialString:\'9098838711,,2,,22122\' },
    { id:\'sbu15\', label:\'4TW E Ortho\',              display:\'909-883-8711 x22135\', dialString:\'9098838711,,2,,22135\' },
    { id:\'sbu16\', label:\'4TW W\',                    display:\'909-883-8711 x22121\', dialString:\'9098838711,,2,,22121\' },
    /* Floor 5 */
    { id:\'sbu17\', label:\'5 NS / 5TW N\',             display:\'909-883-8711 x25684\', dialString:\'9098838711,,2,,25684\' },
    { id:\'sbu18\', label:\'5 EW / 5TW E\',             display:\'909-883-8711 x22190\', dialString:\'9098838711,,2,,22190\' },
    { id:\'sbu19\', label:\'5TW W\',                    display:\'909-883-8711 x22180\', dialString:\'9098838711,,2,,22180\' },
    { id:\'sbu20\', label:\'5TW S\',                    display:\'909-883-8711 x25691\', dialString:\'9098838711,,2,,25691\' },
    /* Floor 6 */
    { id:\'sbu21\', label:\'6 NS / 6TW N Tele\',        display:\'909-883-8711 x23955\', dialString:\'9098838711,,2,,23955\' },
    { id:\'sbu22\', label:\'6 EW / 6TW W\',             display:\'909-883-8711 x22210\', dialString:\'9098838711,,2,,22210\' },
    { id:\'sbu23\', label:\'6TW E\',                    display:\'909-883-8711 x22220\', dialString:\'9098838711,,2,,22220\' },
    { id:\'sbu24\', label:\'6TW S\',                    display:\'909-883-8711 x23964\', dialString:\'9098838711,,2,,23964\' },
  ]
};

';

# ─────────────────────────────────────────────────────────────────────────────
# CATEGORY 2: Imaging Services (from DID list + File 2 charge cells)
# ─────────────────────────────────────────────────────────────────────────────
my $sb_imaging = 'const SB_IMAGING_SERVICES = {
  id: \'sb-imaging\',
  name: \'Imaging Services\',
  entries: [
    { id:\'sbi01\', label:\'Radiology Main\',              display:\'909-883-8711 x23630\', dialString:\'9098838711,,2,,23630\' },
    { id:\'sbi02\', label:\'Radiology Scheduling\',        display:\'909-883-8711 x23641\', dialString:\'9098838711,,2,,23641\' },
    { id:\'sbi03\', label:\'Radiology / Outpatient\',      display:\'909-883-8711 x23790\', dialString:\'9098838711,,2,,23790\' },
    { id:\'sbi04\', label:\'Radiology Tech\',              display:\'909-883-8711 x23798\', dialString:\'9098838711,,2,,23798\' },
    { id:\'sbi05\', label:\'Angio\',                       display:\'909-883-8711 x23652\', dialString:\'9098838711,,2,,23652\' },
    { id:\'sbi06\', label:\'Echocardiography (Line 1)\',   display:\'909-883-8711 x23200\', dialString:\'9098838711,,2,,23200\' },
    { id:\'sbi07\', label:\'Echocardiography (Line 2)\',   display:\'909-883-8711 x21592\', dialString:\'9098838711,,2,,21592\' },
    { id:\'sbi08\', label:\'File Room\',                   display:\'909-883-8711 x23659\', dialString:\'9098838711,,2,,23659\' },
    { id:\'sbi09\', label:\'Imaging Center (Direct)\',     display:\'909-881-4568\',         dialString:\'9098814568\' },
    { id:\'sbi10\', label:\'Interventional Radiology\',    display:\'909-883-8711 x22320\', dialString:\'9098838711,,2,,22320\' },
    { id:\'sbi11\', label:\'MRI\',                         display:\'909-883-8711 x23666\', dialString:\'9098838711,,2,,23666\' },
    { id:\'sbi12\', label:\'Neurodiagnostics / EEG\',      display:\'909-883-8711 x23686\', dialString:\'9098838711,,2,,23686\' },
    { id:\'sbi13\', label:\'Nuclear Medicine\',            display:\'909-883-8711 x23653\', dialString:\'9098838711,,2,,23653\' },
    { id:\'sbi14\', label:\'Ultrasound (Alt Line)\',       display:\'909-883-8711 x22700\', dialString:\'9098838711,,2,,22700\' },
    { id:\'sbi15\', label:\'Women\'s Center Scheduling (Line 1)\', display:\'909-883-8711 x14568\', dialString:\'9098838711,,2,,14568\' },
    { id:\'sbi16\', label:\'Women\'s Center Scheduling (Line 2)\', display:\'909-883-8711 x23633\', dialString:\'9098838711,,2,,23633\' },
    { id:\'sbi17\', label:\'CT Charge (Cell)\',            display:\'909-677-8384\',         dialString:\'9096778384\',            note:\'Direct charge tech cell\' },
    { id:\'sbi18\', label:\'US Charge (Cell)\',            display:\'909-677-8319\',         dialString:\'9096778319\',            note:\'Direct charge tech cell\' },
  ]
};

';

# ─────────────────────────────────────────────────────────────────────────────
# CATEGORY 3: Clinical Departments (from DID list)
# ─────────────────────────────────────────────────────────────────────────────
my $sb_clinical = 'const SB_CLINICAL_DEPTS = {
  id: \'sb-clinical\',
  name: \'Clinical Departments\',
  entries: [
    { id:\'sbc01\', label:\'Lab Services (Line 1)\',      display:\'909-883-8711 x23485\', dialString:\'9098838711,,2,,23485\' },
    { id:\'sbc02\', label:\'Lab Services (Line 2)\',      display:\'909-883-8711 x23486\', dialString:\'9098838711,,2,,23486\' },
    { id:\'sbc03\', label:\'Blood Bank\',                 display:\'909-883-8711 x23492\', dialString:\'9098838711,,2,,23492\' },
    { id:\'sbc04\', label:\'Pharmacy\',                   display:\'909-883-8711 x23577\', dialString:\'9098838711,,2,,23577\' },
    { id:\'sbc05\', label:\'Surgery Main\',               display:\'909-883-8711 x23715\', dialString:\'9098838711,,2,,23715\' },
    { id:\'sbc06\', label:\'PACU / Recovery\',            display:\'909-883-8711 x23670\', dialString:\'9098838711,,2,,23670\' },
    { id:\'sbc07\', label:\'Dialysis (Ext)\',             display:\'909-883-8711 x23930\', dialString:\'9098838711,,2,,23930\' },
    { id:\'sbc08\', label:\'Dialysis (Direct)\',          display:\'909-881-4356\',         dialString:\'9098814356\' },
    { id:\'sbc09\', label:\'ER (Line 2)\',                display:\'909-883-8711 x23365\', dialString:\'9098838711,,2,,23365\' },
    { id:\'sbc10\', label:\'ER Charge RN (Ext)\',         display:\'909-883-8711 x23388\', dialString:\'9098838711,,2,,23388\' },
    { id:\'sbc11\', label:\'ER Triage\',                  display:\'909-883-8711 x23367\', dialString:\'9098838711,,2,,23367\' },
    { id:\'sbc12\', label:\'House Supervisor (Ext 1)\',   display:\'909-883-8711 x14338\', dialString:\'9098838711,,2,,14338\' },
    { id:\'sbc13\', label:\'House Supervisor (Ext 2)\',   display:\'909-883-8711 x23278\', dialString:\'9098838711,,2,,23278\' },
  ]
};

';

# ─────────────────────────────────────────────────────────────────────────────
# CLINICIANS: Imaging staff from File 2 (cell phones)
# ─────────────────────────────────────────────────────────────────────────────
my $sb_clinicians = 'const SB_CLINICIANS = [
  /* Management */
  { id:\'sbcl001\', name:\'Wesley Toh\',              role:\'Sr Director Ancillary Services\',  display:\'909-488-2532\', dialString:\'9094882532\' },
  { id:\'sbcl002\', name:\'Ranilo Blasco\',           role:\'Imaging Manager\',                 display:\'714-496-0388\', dialString:\'7144960388\' },
  { id:\'sbcl003\', name:\'Jeff Freeman\',            role:\'Imaging Supervisor\',              display:\'909-300-5261\', dialString:\'9093005261\' },
  { id:\'sbcl004\', name:\'Daniel Prokopij\',         role:\'PACS Administrator\',              display:\'909-641-1129\', dialString:\'9096411129\' },
  { id:\'sbcl005\', name:\'Shelley Becker\',          role:\'RSO\',                             display:\'626-616-5135\', dialString:\'6266165135\' },
  /* CT Technologists */
  { id:\'sbcl006\', name:\'Eric Estrada\',            role:\'CT Technologist\',                 display:\'909-533-0744\', dialString:\'9095330744\' },
  { id:\'sbcl007\', name:\'Veronica Cantor\',         role:\'CT Technologist\',                 display:\'909-534-8125\', dialString:\'9095348125\' },
  { id:\'sbcl008\', name:\'Eric Dahlberg\',           role:\'CT Technologist\',                 display:\'909-894-6403\', dialString:\'9098946403\' },
  { id:\'sbcl009\', name:\'Adrienne Durgin\',         role:\'CT Technologist\',                 display:\'909-567-7897\', dialString:\'9095677897\' },
  { id:\'sbcl010\', name:\'Natalie Guevara\',         role:\'CT Technologist\',                 display:\'909-565-7161\', dialString:\'9095657161\' },
  { id:\'sbcl011\', name:\'Jessica Holguin\',         role:\'CT Technologist\',                 display:\'951-205-6330\', dialString:\'9512056330\' },
  { id:\'sbcl012\', name:\'Michael Janini\',          role:\'CT Technologist\',                 display:\'909-955-5478\', dialString:\'9099555478\' },
  { id:\'sbcl013\', name:\'Cynthia Ledesma\',         role:\'CT Technologist\',                 display:\'909-518-6142\', dialString:\'9095186142\' },
  { id:\'sbcl014\', name:\'Paul Leograndis\',         role:\'CT Technologist\',                 display:\'760-912-1062\', dialString:\'7609121062\' },
  { id:\'sbcl015\', name:\'Francisco Rivera\',        role:\'CT Technologist\',                 display:\'909-213-2540\', dialString:\'9092132540\' },
  { id:\'sbcl016\', name:\'Lucy Ruiz\',               role:\'CT Technologist\',                 display:\'951-383-5680\', dialString:\'9513835680\' },
  { id:\'sbcl017\', name:\'Viktoria Taylor\',         role:\'CT Technologist\',                 display:\'562-266-8027\', dialString:\'5622668027\' },
  /* MRI Technologists */
  { id:\'sbcl018\', name:\'Elise Allemand\',          role:\'MRI Technologist\',                display:\'760-508-7431\', dialString:\'7605087431\' },
  { id:\'sbcl019\', name:\'Tammy La Ford\',           role:\'MRI Technologist\',                display:\'909-644-5987\', dialString:\'9096445987\' },
  { id:\'sbcl020\', name:\'Rosalyn Tacchia\',         role:\'MRI Technologist\',                display:\'760-774-9119\', dialString:\'7607749119\' },
  { id:\'sbcl021\', name:\'JR Mora\',                 role:\'MRI Technologist\',                display:\'626-664-1778\', dialString:\'6266641778\' },
  /* Ultrasound Technologists */
  { id:\'sbcl022\', name:\'Margareth Freire\',        role:\'US Technologist\',                 display:\'951-965-7695\', dialString:\'9519657695\' },
  { id:\'sbcl023\', name:\'Nicole Christianson\',     role:\'US Technologist\',                 display:\'760-983-1072\', dialString:\'7609831072\' },
  { id:\'sbcl024\', name:\'Destiny Cooksey\',         role:\'US Technologist\',                 display:\'310-989-0957\', dialString:\'3109890957\' },
  { id:\'sbcl025\', name:\'Brittney Digiantomasso\',  role:\'US Technologist\',                 display:\'909-276-1494\', dialString:\'9092761494\' },
  { id:\'sbcl026\', name:\'Crystal Ferris\',          role:\'US Technologist\',                 display:\'951-751-3704\', dialString:\'9517513704\' },
  { id:\'sbcl027\', name:\'Wendy Lopez\',             role:\'US Technologist\',                 display:\'951-905-7387\', dialString:\'9519057387\' },
  { id:\'sbcl028\', name:\'Gary Luong\',              role:\'US Technologist\',                 display:\'951-756-9314\', dialString:\'9517569314\' },
  { id:\'sbcl029\', name:\'Elisa Mena\',              role:\'US Technologist\',                 display:\'909-246-8670\', dialString:\'9092468670\' },
  { id:\'sbcl030\', name:\'Maria Ponce\',             role:\'US Technologist\',                 display:\'951-692-6960\', dialString:\'9516926960\' },
  { id:\'sbcl031\', name:\'Nick Reed\',               role:\'US Technologist\',                 display:\'909-648-7325\', dialString:\'9096487325\' },
  { id:\'sbcl032\', name:\'Ariell Rook\',             role:\'US Technologist\',                 display:\'760-981-9855\', dialString:\'7609819855\' },
  { id:\'sbcl033\', name:\'Sara Stowers\',            role:\'US Technologist\',                 display:\'909-251-6256\', dialString:\'9092516256\' },
  { id:\'sbcl034\', name:\'Chelsea Traxler\',         role:\'US Technologist\',                 display:\'909-272-8663\', dialString:\'9092728663\' },
  { id:\'sbcl035\', name:\'Yesenia Valdez Cardona\',  role:\'US Technologist\',                 display:\'619-343-0560\', dialString:\'6193430560\' },
  { id:\'sbcl036\', name:\'Kailey Wachter\',          role:\'US Technologist\',                 display:\'760-220-2476\', dialString:\'7602202476\' },
  { id:\'sbcl037\', name:\'Mia Wrinkle\',             role:\'US Technologist\',                 display:\'951-529-8529\', dialString:\'9515298529\' },
  /* Nuclear Medicine */
  { id:\'sbcl038\', name:\'Nenita Mendoza\',          role:\'NM Technologist\',                 display:\'909-289-7937\', dialString:\'9092897937\' },
  { id:\'sbcl039\', name:\'Justin Komenkul\',         role:\'NM Technologist\',                 display:\'951-442-9608\', dialString:\'9514429608\' },
  { id:\'sbcl040\', name:\'Freddy Ruiz\',             role:\'NM Technologist\',                 display:\'951-347-4006\', dialString:\'9513474006\' },
  /* Special Procedure */
  { id:\'sbcl041\', name:\'Roza Ali-Lewis\',          role:\'Special Procedure Tech\',          display:\'909-496-1232\', dialString:\'9094961232\' },
  { id:\'sbcl042\', name:\'Sitha Ath\',               role:\'Special Procedure Tech\',          display:\'909-213-7657\', dialString:\'9092137657\' },
  { id:\'sbcl043\', name:\'Brian Soria\',             role:\'Special Procedure Tech\',          display:\'909-449-9909\', dialString:\'9094499909\' },
  { id:\'sbcl044\', name:\'Prince Tshuma\',           role:\'Special Procedure Tech\',          display:\'909-534-3010\', dialString:\'9095343010\' },
  /* Diagnostic Technologists */
  { id:\'sbcl045\', name:\'Elvis Akoto\',             role:\'Diagnostic Technologist\',         display:\'909-834-9055\', dialString:\'9098349055\' },
  { id:\'sbcl046\', name:\'Ashley Ali\',              role:\'Diagnostic Technologist\',         display:\'909-912-9465\', dialString:\'9099129465\' },
  { id:\'sbcl047\', name:\'Michelle Baeza\',          role:\'Diagnostic Technologist\',         display:\'909-906-8464\', dialString:\'9099068464\' },
  { id:\'sbcl048\', name:\'De Anna Bartley\',         role:\'Diagnostic Technologist\',         display:\'909-264-4385\', dialString:\'9092644385\' },
  { id:\'sbcl049\', name:\'Fabian Cano\',             role:\'Diagnostic Technologist\',         display:\'909-708-9862\', dialString:\'9097089862\' },
  { id:\'sbcl050\', name:\'Mandy Gettman\',           role:\'Diagnostic Technologist\',         display:\'909-647-7738\', dialString:\'9096477738\' },
  { id:\'sbcl051\', name:\'Domingo Huipe\',           role:\'Diagnostic Technologist\',         display:\'951-312-3314\', dialString:\'9513123314\' },
  { id:\'sbcl052\', name:\'Dale Jabonillo\',          role:\'Diagnostic Technologist\',         display:\'909-239-6423\', dialString:\'9092396423\' },
  { id:\'sbcl053\', name:\'Betsy Kerns\',             role:\'Diagnostic Technologist\',         display:\'909-522-0717\', dialString:\'9095220717\' },
  { id:\'sbcl054\', name:\'Traci McDaniel\',          role:\'Diagnostic Technologist\',         display:\'909-645-9884\', dialString:\'9096459884\' },
  { id:\'sbcl055\', name:\'Andrea Nielsen\',          role:\'Diagnostic Technologist\',         display:\'909-472-9444\', dialString:\'9094729444\' },
  { id:\'sbcl056\', name:\'Oko Okorie\',              role:\'Diagnostic Technologist\',         display:\'909-232-6404\', dialString:\'9092326404\' },
  { id:\'sbcl057\', name:\'Julie-Maree Popescu\',     role:\'Diagnostic Technologist\',         display:\'909-492-4081\', dialString:\'9094924081\' },
  { id:\'sbcl058\', name:\'Julyanna Rios\',           role:\'Diagnostic Technologist\',         display:\'626-264-2269\', dialString:\'6262642269\' },
  { id:\'sbcl059\', name:\'Alexis Ritunban\',         role:\'Diagnostic Technologist\',         display:\'909-677-6742\', dialString:\'9096776742\' },
  { id:\'sbcl060\', name:\'Roy Rud\',                 role:\'Diagnostic Technologist\',         display:\'909-362-1280\', dialString:\'9093621280\' },
  { id:\'sbcl061\', name:\'Billie Smith\',            role:\'Diagnostic Technologist\',         display:\'909-520-9031\', dialString:\'9095209031\' },
  { id:\'sbcl062\', name:\'Shelly Wilson\',           role:\'Diagnostic Technologist\',         display:\'209-628-5416\', dialString:\'2096285416\' },
  /* Radiology Assistants */
  { id:\'sbcl063\', name:\'James Bengtson\',          role:\'Radiology Assistant\',             display:\'951-323-3913\', dialString:\'9513233913\' },
  { id:\'sbcl064\', name:\'Pete Cortez\',             role:\'Radiology Assistant\',             display:\'909-499-3518\', dialString:\'9094993518\' },
  { id:\'sbcl065\', name:\'Steven Cortez\',           role:\'Radiology Assistant\',             display:\'909-965-3438\', dialString:\'9099653438\' },
  { id:\'sbcl066\', name:\'Jesus Hernandez\',         role:\'Radiology Assistant\',             display:\'951-241-4932\', dialString:\'9512414932\' },
  { id:\'sbcl067\', name:\'Chris Lopez\',             role:\'Radiology Assistant\',             display:\'951-407-3300\', dialString:\'9514073300\' },
  { id:\'sbcl068\', name:\'Hector Marcelo\',          role:\'Radiology Assistant\',             display:\'310-290-6730\', dialString:\'3102906730\' },
  { id:\'sbcl069\', name:\'Jacqueline Martinez-Valdez\', role:\'Radiology Assistant\',          display:\'951-663-5827\', dialString:\'9516635827\' },
  { id:\'sbcl070\', name:\'Michelle Paramo\',         role:\'Radiology Assistant\',             display:\'909-827-6708\', dialString:\'9098276708\' },
  { id:\'sbcl071\', name:\'Mike Sandoval\',           role:\'Radiology Assistant\',             display:\'909-927-1637\', dialString:\'9099271637\' },
  { id:\'sbcl072\', name:\'Stephanie Schnabel\',      role:\'Radiology Assistant\',             display:\'951-836-9998\', dialString:\'9518369998\' },
  { id:\'sbcl073\', name:\'Justin Smith\',            role:\'Radiology Assistant\',             display:\'909-961-3509\', dialString:\'9099613509\' },
  { id:\'sbcl074\', name:\'Austin Soria\',            role:\'Radiology Assistant\',             display:\'909-687-9071\', dialString:\'9096879071\' },
  { id:\'sbcl075\', name:\'Rebekah Teal\',            role:\'Radiology Assistant\',             display:\'760-686-4864\', dialString:\'7606864864\' },
  /* Schedulers */
  { id:\'sbcl076\', name:\'Jenny Barraza\',           role:\'Imaging Scheduler\',               display:\'279-465-5530\', dialString:\'2794655530\' },
  { id:\'sbcl077\', name:\'Amelia Santamaria\',       role:\'Imaging Scheduler\',               display:\'951-255-4011\', dialString:\'9512554011\' },
  { id:\'sbcl078\', name:\'Sandy Sayegh\',            role:\'Imaging Scheduler\',               display:\'480-529-8968\', dialString:\'4805298968\' },
  { id:\'sbcl079\', name:\'Joel Wills\',              role:\'Office Assistant\',                display:\'760-552-1145\', dialString:\'7605521145\' },
  /* IR Nurses */
  { id:\'sbcl080\', name:\'Deb Howard\',              role:\'IR Nurse\',                        display:\'951-966-8537\', dialString:\'9519668537\' },
  { id:\'sbcl081\', name:\'Danny Lopez\',             role:\'IR Nurse\',                        display:\'951-902-5744\', dialString:\'9519025744\' },
  { id:\'sbcl082\', name:\'Patrick Marcos\',          role:\'IR Nurse\',                        display:\'408-838-5400\', dialString:\'4088385400\' },
  { id:\'sbcl083\', name:\'Rima Sagala\',             role:\'IR Nurse\',                        display:\'909-908-4021\', dialString:\'9099084021\' },
  { id:\'sbcl084\', name:\'Freddie Valenzuela\',      role:\'IR Nurse\',                        display:\'909-730-5349\', dialString:\'9097305349\' },
  { id:\'sbcl085\', name:\'Jon Weaver\',              role:\'IR Nurse\',                        display:\'909-435-6423\', dialString:\'9094356423\' },
  /* Radiologists (Envision Health) */
  { id:\'sbcl086\', name:\'Shahnawaz Ansari, MD\',    role:\'Radiologist – Envision\',          display:\'858-212-4009\', dialString:\'8582124009\' },
  { id:\'sbcl087\', name:\'Alaa Beydoun, MD\',        role:\'Radiologist – Envision\',          display:\'949-334-7237\', dialString:\'9493347237\' },
  { id:\'sbcl088\', name:\'Tammam Beydoun, MD\',      role:\'Radiologist – Envision\',          display:\'949-331-6677\', dialString:\'9493316677\' },
  { id:\'sbcl089\', name:\'Khalid Saleh, MD\',        role:\'Radiologist – Envision\',          display:\'601-667-7428\', dialString:\'6016677428\' },
  { id:\'sbcl090\', name:\'Omar Saleh, MD\',          role:\'Radiologist – Envision\',          display:\'601-918-3286\', dialString:\'6019183286\' },
  { id:\'sbcl091\', name:\'Fred Shu, MD\',            role:\'Radiologist – Envision\',          display:\'951-897-0063\', dialString:\'9518970063\' },
];

';

# ── 1. Append all constants into the existing plain <script> block ────────────
my $all_new = $sb_unit_ext . $sb_imaging . $sb_clinical . $sb_clinicians;
$html =~ s|(</script>\n<script type="text/babel">)|$all_new$1|;

# ── 2. Add new categories to SB DEFAULT_HOSPITALS ────────────────────────────
# SB already has: Departments category + SB_HOSPITAL_UNITS appended
# Append the 3 new categories after SB_HOSPITAL_UNITS in DEFAULT_HOSPITALS
$html =~ s|(id: 'sb',\n    name: 'SB',\n    fullName: 'St\. Bernardine Medical Center',\n    color: '#34C759',\n    categories: \[\n      \{)(.*?)(,\n      SB_HOSPITAL_UNITS\n    \],\n    clinicians: \[\]\n  \})|$1$2$3|s;

# More targeted: replace 'SB_HOSPITAL_UNITS\n    ],\n    clinicians: []'
$html =~ s/SB_HOSPITAL_UNITS\n    \],\n    clinicians: \[\]/SB_HOSPITAL_UNITS,\n      SB_UNIT_EXTENSIONS,\n      SB_IMAGING_SERVICES,\n      SB_CLINICAL_DEPTS\n    ],\n    clinicians: SB_CLINICIANS/;

# ── 3. Update migration to include all new SB categories + clinicians ─────────
my $old_sb_migrate = "        if (h.id === 'sb' && !h.categories.find(c => c.id === 'sb-units'))\n          return { ...h, categories: [...h.categories, SB_HOSPITAL_UNITS] };";

my $new_sb_migrate = "        if (h.id === 'sb') {
          let cats = h.categories;
          if (!cats.find(c => c.id === 'sb-units'))     cats = [...cats, SB_HOSPITAL_UNITS];
          if (!cats.find(c => c.id === 'sb-unit-ext'))  cats = [...cats, SB_UNIT_EXTENSIONS];
          if (!cats.find(c => c.id === 'sb-imaging'))   cats = [...cats, SB_IMAGING_SERVICES];
          if (!cats.find(c => c.id === 'sb-clinical'))  cats = [...cats, SB_CLINICAL_DEPTS];
          const clins = (!h.clinicians || h.clinicians.length < 10) ? SB_CLINICIANS : h.clinicians;
          return { ...h, categories: cats, clinicians: clins };
        }";

$html =~ s/\Q$old_sb_migrate\E/$new_sb_migrate/;

# ── Write ─────────────────────────────────────────────────────────────────────
open my $out, '>', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
print $out $html; close $out;

# ── Verify ────────────────────────────────────────────────────────────────────
open $fh, '<', 'C:/Users/youha/Claude projects/radiology-directory/index.html' or die $!;
$html = <$fh>; close $fh;

printf "SB_UNIT_EXTENSIONS constant:   %s\n", ($html =~ /const SB_UNIT_EXTENSIONS/   ? 'YES' : 'NO');
printf "SB_IMAGING_SERVICES constant:  %s\n", ($html =~ /const SB_IMAGING_SERVICES/  ? 'YES' : 'NO');
printf "SB_CLINICAL_DEPTS constant:    %s\n", ($html =~ /const SB_CLINICAL_DEPTS/    ? 'YES' : 'NO');
printf "SB_CLINICIANS constant:        %s\n", ($html =~ /const SB_CLINICIANS/        ? 'YES' : 'NO');
printf "DEFAULT_HOSPITALS updated:     %s\n", ($html =~ /SB_IMAGING_SERVICES,\n      SB_CLINICAL_DEPTS/ ? 'YES' : 'NO');
printf "Migration logic updated:       %s\n", ($html =~ /sb-imaging/                 ? 'YES' : 'NO');
my $unit_n  = () = $html =~ /id:'sbu\d+'/g;
my $imag_n  = () = $html =~ /id:'sbi\d+'/g;
my $clin_n  = () = $html =~ /id:'sbc\d+'/g;
my $clin2_n = () = $html =~ /id:'sbcl\d+'/g;
printf "Unit ext entries:   %d\n", $unit_n;
printf "Imaging entries:    %d\n", $imag_n;
printf "Clinical entries:   %d\n", $clin_n;
printf "Clinicians:         %d\n", $clin2_n;
printf "File size:          %.1f KB\n", (-s 'C:/Users/youha/Claude projects/radiology-directory/index.html')/1024;
