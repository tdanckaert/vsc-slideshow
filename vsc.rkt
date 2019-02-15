#lang slideshow

(require pict racket/draw ppict/2)

(define flanders-art
  (make-font #:face "Flanders Art Sans,Regular"
	     #:size 32))

(define flanders-art-light
  (make-font #:face "Flanders Art Sans,Light"
	     #:size 32))

(define flanders-art-large
  (make-font #:face "Flanders Art Sans,Regular"
	     #:size 35))

(define flanders-art-small
  (make-font #:face "Flanders Art Sans,Regular"
	     #:size 25))

(define helvetica
  (make-font #:face "Helvetica,Regular"
	     #:size 32))


(define vsc-orange
  (make-color 219 108 48))
(define vsc-dark
  (make-color 55 54 54))
(define vsc-gray
  (make-color 246 246 246))
(define vsc-background
  (make-color 242 243 252))

(define (vsc-logo [color vsc-gray])
  (colorize
   (vr-append
    (clip-descent (text "VLAAMS" flanders-art-light))
    (clip-descent (text "SUPERCOMPUTER"  flanders-art))
    (text "CENTRUM" flanders-art))
   color))

(define (trapeze w)
  (dc (lambda (dc dx dy)
	(define old-brush (send dc get-brush))
	(define old-pen (send dc get-pen))
	(send dc set-brush
	      (new brush% [style 'solid] [color vsc-orange]))
	(send dc set-pen (new pen% [style 'transparent]))
	(define path (new dc-path%))
	(send path move-to 0 20)
	(send path line-to w 0)
	(send path line-to w 100)
	(send path line-to 0 100)
	(send path close)
	(send dc draw-path path dx dy)
	(send dc set-brush old-brush)
	(send dc set-pen old-pen))
      w 100))

(define vsc-bg
  (let ([w (+ (* 2 margin) client-w)]
	[h (+ (* 2 margin) client-h)])
    (inset (rb-superimpose
	    (filled-rectangle w h #:draw-border? #f #:color vsc-background)
	    (trapeze w)
	    (inset (scale-to-fit (vsc-logo)
				 (rectangle 80 80) #:mode 'preserve/max)
		   0 0 20 10))
	   (- margin))))

(define (mysub s . rest)
  (subitem s rest #:bullet bullet))

(current-titlet
 (lambda (s)
   (colorize (text s flanders-art-large 50) vsc-dark)))

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
   #:title "My first VSC slideshow"
   (para "This uses the fancy slide-assembler method."))

  (slide
   (para "This one doesn't have a title."))

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

  ;; Try if it looks better with Helvetica
  (current-main-font helvetica)

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

  (current-main-font (make-font #:face "Gill Sans, Regular"
				#:size 28))

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

  (current-main-font (make-font #:face "Flanders Art Sans, Light"
				#:size 28))

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

)