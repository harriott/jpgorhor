jpgorhor
========

A neat Perl script to reset all Orientation tags to `Horizontal`.  It works recursively, on all the jpegs found in the current directory, and all subdirectories.  There is no undo!

This script just wraps [Phil Harvey's excellent ExifTool](http://en.wikipedia.org/wiki/ExifTool).
It only changes the Orientation tags of files that have them definitely set to something other than `Horizontal`.  It displays progress.  If you want to capture what it's done, run it from a terminal.

---
[Dave Perrett's post](http://www.daveperrett.com/articles/2012/07/28/exif-orientation-handling-is-a-ghetto/), which explains the `Orientation` problem well.  Like Dave, I was annoyed by image rotations not being treat consistantly across various systems.  Finding no simple program that would batch reset them, I learned enough Perl to wrap ExifTool.

Now I run this script on all of my received digital images, and I rotate images manually myself, which I prefer.

If you want to use it, you'll need Perl installed, of course.

