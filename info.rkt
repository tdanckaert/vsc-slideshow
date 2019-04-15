#lang info
(define collection "vsc-slideshow")
(define deps '("base"
	       "draw-lib"
	       "slideshow-lib"
	       "rsvg"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/vsc-slideshow.scrbl" ())))
(define pkg-desc "Sets up slideshow to create slides that look like the VSC style template.")
(define version "0.0")
