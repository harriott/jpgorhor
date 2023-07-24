# vim: set et fdl=4 tw=0:

# Joseph Harriott - Mon 24 Jul 2023

# Recursively find all *.jpg (- that's case insensitive) files in the current directory
#  and set  -orientation=Horizontal   if necessary.

# $onGH\jpgorhor\jpgorhor.ps1  called by function  jpo  in  $MSWin10\PSProfile.ps1

param( [switch]$minor )
if ($minor) {$minorOverride="-m"} else {$minorOverride=""}

exiftool $minorOverride -r -ext jpg -overwrite_original -orientation=Horizontal -progress -if '$orientation =~ /Rotate/' .

