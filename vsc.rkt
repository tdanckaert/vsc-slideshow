#lang slideshow

(require pict slideshow/text racket/draw)

(define flanders-art
  (make-font #:face "FlandersArtSans-Regular"
	     #:size 32))

(define flanders-art-light
  (make-font #:face "Flanders Art Sans,Light"
	     #:size 32))

(define flanders-art-medium
  (make-font #:face "Flanders Art Sans,Medium"
	     #:size 32))

(define flanders-art-small
  (make-font #:face "FlandersArtSans-Regular"
	     #:size 28))

(define inconsolata
  (make-font #:face "Inconsolata"
	     #:size 28))

(define vsc-orange
  (make-color 219 108 48))
(define vsc-dark
  (make-color 78 88 101))
(define vsc-gray
  (make-color 119 132 150))
(define vsc-bright
  (make-color 246 246 246))
(define vsc-background
  (make-color 242 243 252))

(define (vsc-logo [color vsc-bright])
  (colorize
   (vr-append
    (clip-descent (text "VLAAMS" flanders-art-light))
    (clip-descent (text "SUPERCOMPUTER"  flanders-art-medium))
    (text "CENTRUM" flanders-art-medium))
   color))

(define (trapeze w h)
  (dc (lambda (dc dx dy)
	(define old-brush (send dc get-brush))
	(define old-pen (send dc get-pen))
	(send dc set-brush
	      (new brush% [style 'solid] [color vsc-orange]))
	(send dc set-pen (new pen% [style 'transparent]))
	(define path (new dc-path%))
	(send path move-to 0 (/ h 2))
	(send path line-to w 0)
	(send path line-to w h)
	(send path line-to 0 h)
	(send path close)
	(send dc draw-path path dx dy)
	(send dc set-brush old-brush)
	(send dc set-pen old-pen))
      w h))

(define vsc-bg
  (let ([w (+ (* 2 margin) client-w)]
	[h (+ (* 2 margin) client-h)])
    (inset (rb-superimpose
	    (filled-rectangle w h #:draw-border? #f #:color vsc-background)
	    (trapeze w 80)
	    (inset (scale-to-fit (vsc-logo)
				 (rectangle 60 60) #:mode 'preserve/max)
		   0 0 20 8))
	   (- margin))))

(define (prompt txt)
  (colorize (hc-append (with-font inconsolata (bt "$ "))
		       (with-font inconsolata (t txt))) vsc-gray))

(define (mysub s . rest)
  (subitem s rest #:bullet bullet))

(current-titlet
 (lambda (s)
   (colorize (text s flanders-art-medium) vsc-dark)))

(current-slide-assembler
 (lambda (title v-sep content)
   (let ([content (colorize content vsc-dark)])
     (lt-superimpose
      vsc-bg
      (if title
	  (vc-append v-sep (para (titlet title)) content)
	  content)))))

(current-para-width (* 7/8 client-w))

(begin
  (current-main-font flanders-art-small)
  
  (slide
   #:title "Goals of this course"

   (para "The VSC clusters, like most HPC clusters worldwide, use Linux-based operating systems.")

   (para "Basic concepts:")
   (mysub "Files and the file system")
   (mysub "Processes, threads")
   
   (para "Using the command-line")
   (mysub "Starting (and stopping!) programs")
   (mysub "Files and directories: find, read, create, write, move, copy, delete, ...")

   (para "Scripts: store a series of commands in a file, so we can (re-)use them later."))
  
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

   (para "Do any of these" (it "text formatting") "functions even work?")
   (para "Let's see about inline" (with-font inconsolata (t "fixed-width text"))
	 "probably fails?  No, seems like it works and we can describe"
	 (colorize  (with-font inconsolata (bt "$")) vsc-gray)
	 (colorize  (with-font inconsolata (t "commands")) vsc-gray)
	 "like this.")
   (para "Or, abstracting it in a function:"
	 (prompt "cat myfile.txt") ", like that.")
   (with-font inconsolata (para "fixed-width text"))
   (with-font inconsolata (t "fixed-width text"))
   )


)
