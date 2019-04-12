#lang slideshow

(require pict rsvg slideshow/text racket/draw)
(require "vsc.rkt")

(begin

  (title-slide "Introduction to Linux"
	       '("Thomas Danckaert" "Stefan Becuwe"))

  (slide
   #:title "Goals of this course"

   (para "The VSC clusters, like most HPC clusters worldwide, use Linux-based operating systems.")

   (para "Basic concepts:")
   (mysub "Files and the file system")
   (mysub "Processes, threads")

   (para "Using the command-line")
   (mysub "Starting (and stopping!) programs")
   (mysub "Files and directories: find, read, create, write, move, copy, delete, ...")

   (para "Scripts: store a series of commands in a file, so we can (re-)use them later.")))


(begin

  (slide
   #:title "Linux-like environments"

   (para "Microsoft Windows")
   (mysub "Cygwin: www.cygwin.com")
   (mysub "Microsoft Subsystem for Linux (Windows 10, 64bit version)")

   (para "macOS")
   (mysub "Terminal app (or iTerm2)")
   (mysub "For identical commands: install GNU tools using MacPorts "
	    "(macports.org) or Homebrew (brew.sh)")

   (para "or in your browser:")
   (mysub "www.tutorialspoint.com/unix_terminal_online.php"))


  (slide
   #:title "Text formatting"

   (para "Do any of these" (it "text formatting") (bt "functions") " even work?")
   (para "Let's see about inline '" (with-font inconsolata (t "fixed-width text"))
	 "' probably fails?  No, seems like it works and we can describe"
	 (colorize  (with-font inconsolata (bt "$")) vsc-gray)
	 (colorize  (with-font inconsolata (t "commands")) vsc-gray)
	 "like this.  But how could we fix those quotes?")
   (para "One way could be to add them directly ‘like this’?")
   (para "Or, abstracting it in a function:"
	 (prompt "cat myfile.txt") ", like that.")
   (para "What about newlines, and nice looking `quotes'?")
   (with-font inconsolata (para "fixed-width text"))
   (with-font inconsolata (t "fixed-width text"))
   )

  (define script06 "#!/bin/bash

count=1
while [ $count -le 5 ]; do
  echo $count
  count=$((count + 1))
done
echo \"value of count: $count\"

echo \"Finished.\"")

  (slide
   #:title "Displaying scripts"
   (para
    (show-script script06 "script06.sh"))))
