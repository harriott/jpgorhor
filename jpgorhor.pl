#!/usr/bin/perl
# Joseph Harriott - Mon 24 Jul 2023

# This script searches recursively in it's directory for jpegs,
# finds those with rotating orientation tags, and resets them to horizontal.
# It reports progress to the screen and to a log file.

# I wrote this (my first Perl program) without realising the excellent functionality
#  already built-in to command-line exiftool
#  ( https://metacpan.org/pod/distribution/Image-ExifTool/exiftool ).
# This Perl script can be replaced by this one-liner:
#  exiftool -r -ext jpg -overwrite_original -orientation=Horizontal -progress -if '$orientation =~ /Rotate/' .

# Prerequisites for this Perl script:  a system with Perl & module Image::ExifTool.

# Alternatively,  perl $onGH/jpgorhor/jpgorhor.pl

use strict;  use warnings;  use Image::ExifTool;  use File::Find;  use IO::Tee;

# first, create a time check:
END { print "This Perl program ran for ", time() - $^T, " seconds.  All changes reported.\n"}

# prepare an output log:
my $llf = "jpgorhor.txt";
my $llfh;
open( $llfh, '>', $llf ) or die("Can't initialise $llf: $!");
my $tee = IO::Tee->new( $llfh, \*STDOUT );
select $tee;

#  now work through the directory, recursively (looking for rotatable jpegs):
#
#  first define a suitable ExifTool object to be used in the subroutine (and two counters):
my $exifTool = new Image::ExifTool;  my $cdir = 0; my $cfls = 0; my $cjpg = 0; my $cchg = 0;

# now do all of the work:
find(\&rotatable_jpegs, ".");   # finished!
print "Finished! Looked in $cdir Directories at $cfls Files of which $cjpg were jpegs\n";
print "$cchg corrections were made to jpeg Orientation tags\n";

#  the subroutine to find those jpegs that are set for rotation, and clear that:
sub rotatable_jpegs
{
#   print the current directory, as a progress indicator:
    if (-d) {
	    print "looking in Directory > $_\n";
		$cdir++;
		} else {
        $cfls++;
#       (first check if the found item is named as a jpeg:)
        if (/\.jpg$/i) {
#       (this is matching the filename to .jpg case-insensitive)
            $cjpg++;
#           so pull out the contents of the Orientation tag:
            $exifTool->ImageInfo($_);
		    my $v = $exifTool->GetValue('Orientation');
#           check that $v exists (to avoid 'Use of uninitialized value $v' error)
#           and if it's a Rotation:
		    if (defined $v && $v =~ /Rotate/) {
#			    note as much (again to show progress):
		        print "jpeg: $_ > $v changed to Horizontal\n"; $cchg++;
#               then set it to Horizontal:
		        $exifTool->SetNewValue('Orientation#' => 1); $exifTool->WriteInfo($_);
		    }
	    }
	}
}
