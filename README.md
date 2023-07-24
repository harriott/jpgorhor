
jpgorhor
========

Reset all `Orientation` tags to `Horizontal`  using Phil Harvey's excellent [ExifTool](http://en.wikipedia.org/wiki/ExifTool).

[Dave Perrett's post](http://www.daveperrett.com/articles/2012/07/28/exif-orientation-handling-is-a-ghetto/) explains the `Orientation` problem well.
Like Dave, I was annoyed by image rotations not being treat consistantly across various systems.

[$onGH\jpgorhor\jpgorhor.ps1](https://github.com/harriott/jpgorhor/blob/master/jpgorhor.ps1) is now where I'm at.

## deprecated Perl script

[$onGH/jpgorhor/jpgorhor.pl](https://github.com/harriott/jpgorhor/blob/master/jpgorhor.pl) (unnecessarily) wraps
works recursively, on all the jpegs found in the current directory, and all subdirectories.  There is no undo!

Only changes the Orientation tags of files that have them definitely set to something other than `Horizontal`.

Displays progress.  If you want to capture what it's done, run it from a terminal.

