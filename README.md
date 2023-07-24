
jpgorhor
========

Reset all `Orientation` tags to `Horizontal`  using Phil Harvey's excellent [ExifTool](http://en.wikipedia.org/wiki/ExifTool).

[Dave Perrett's post](http://www.daveperrett.com/articles/2012/07/28/exif-orientation-handling-is-a-ghetto/) explains the `Orientation` problem well.
Like Dave, I was annoyed by image rotations not being treat consistantly across various systems.

I define a command `jpo` in my [$Bash/bashrc-wm](https://github.com/harriott/OS-ArchBuilds/blob/master/jo/Bash/bashrc-wm) and my [$MSWin10\PSProfile.ps1](https://github.com/harriott/OS-MSWin10/blob/master/PSProfile.ps1).

---
### deprecated Perl script

[$onGH/jpgorhor/jpgorhor.pl](https://github.com/harriott/jpgorhor/blob/master/jpgorhor.pl) (unnecessarily) wraps
works recursively, on all the jpegs found in the current directory, and all subdirectories.  There is no undo!

Only changes the Orientation tags of files that have them definitely set to something other than `Horizontal`.

Displays progress.  If you want to capture what it's done, run it from a terminal.

I was proud of this little script, but then I realised it solves a problem already solved by Phil.

