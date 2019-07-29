# vim: set et fdl=4 tw=0:

# Joseph Harriott http://momentary.eu/  Mon 29 Jul 2019
#
# Recursively find all *.jpg files in the current directory and set  -orientation=Horizontal
# if necessary.
#
param( [switch]$minor )
if ($minor) {$minorOverride="-m"} else {$minorOverride=""}

exiftool $minorOverride -r -ext jpg -overwrite_original -orientation=Horizontal -progress -if '$orientation =~ /Rotate/' .
