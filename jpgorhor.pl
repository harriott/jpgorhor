#!/usr/bin/perl
# Joseph Harriott (http://momentary.eu/) 2014

# This script searches recursively in it's directory for jpegs, 
# finds those with rotating orientation tags, and resets them to horizontal.
# It reports progress to the screen.

# I wrote this (my first Perl program) without realising the excellent functionality
# already built-in to command-line exiftool:
# http://search.cpan.org/~exiftool/Image-ExifTool-9.76/exiftool
# So, most simply, one can, in a folder of images: $ exiftool orientation= *
# Still, this script does a little more than that.

# Prerequisites:  a system with Perl & module Image::ExifTool.

# Drop this file into the parent folder that you want to work on, open a Terminal there,
# enter the name of this file, hit return, and watch the progress!

use strict;  use warnings;  use Image::ExifTool;  use File::Find;

# first, create a time check:
END { print "This Perl program ran for ", time() - $^T, " seconds.  All changes reported.\n"}

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
