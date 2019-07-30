#lang slideshow

(require pict rsvg slideshow/text racket/draw racket/runtime-path)

(provide title-slide
	 indent
	 prompt
	 key
	 show-script
	 inconsolata
	 vsc-gray
	 vsc-orange)

(define-runtime-path logofile "lion_logo.svg")

(define vsc-lion
  (svg-file->pict logofile))

(define flanders-art-light
  (make-font #:face "Flanders Art Sans"
	     #:weight 'light
	     #:size 28))

(define flanders-art-medium
  (make-font #:face "Flanders Art Sans"
	     #:weight 'medium
	     #:size 28))

(define flanders-art
  (make-font #:face "Flanders Art Sans"
	     #:size 28))

(define flanders-art-big
  (make-font #:face "Flanders Art Sans"
	     #:size 80))

(define flanders-art-logo
  (make-font #:face "Flanders Art Sans"
	     #:size 17))

(define flanders-art-medium-logo
  (make-font #:face "Flanders Art Sans"
	     #:weight 'medium
	     #:size 17))

(define inconsolata
  (make-font #:face "Inconsolata"
	     #:size 28))

(define vsc-background-blue
  (make-color 242 243 252))
(define vsc-lightblue
  (make-color 146 156 225))

(define vsc-slate
  (make-color 51 54 57))

(define vsc-bright
  (make-color 246 246 246))

(define vsc-gray1
  (make-color 238 239 241))
(define vsc-gray3
  (make-color 204 209 215))
(define vsc-gray
  (make-color 119 132 150))
(define vsc-darkgray
  (make-color 78 88 101))

(define vsc-orange
  (make-color 219 108 48))


(define (vsc-logo [color vsc-bright])
  (colorize
   (vl-append
    (clip-descent (text "VLAAMS" flanders-art-logo))
    (ghost (filled-rectangle 10 3))
    (clip-descent (text "SUPERCOMPUTER"  flanders-art-medium-logo))
    (ghost (filled-rectangle 10 3))
    (text "CENTRUM" flanders-art-medium-logo))
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

(define (flipped-trapeze w h)
  (dc (lambda (dc dx dy)
	(define old-brush (send dc get-brush))
	(define old-pen (send dc get-pen))
	(send dc set-brush
	      (new brush% [style 'solid] [color vsc-gray1]))
	(send dc set-pen (new pen% [style 'transparent]))
	(define path (new dc-path%))
	(send path move-to 0 0)
	(send path line-to w (/ h 2))
	(send path line-to w h)
	(send path line-to 0 h)
	(send path close)
	(send dc draw-path path dx dy)
	(send dc set-brush old-brush)
	(send dc set-pen old-pen))
      w h))

(define (bunch-of-lines w h)
  (dc (lambda (dc dx dy)
	(define old-brush (send dc get-brush))
	(define old-pen (send dc get-pen))
		(send dc set-brush
	      (new brush% [style 'transparent]))
	(send dc set-pen (new pen% [color vsc-gray] [style 'solid]))
	(define path (new dc-path%))
	(send path move-to (* w 0.35) 0)
	(send path line-to (* w 0.8) h)
	(send dc draw-path path dx dy)
	(send dc set-brush old-brush)
	(send dc set-pen old-pen))
      w h))

(define vsc-bg
  (let ([w (+ (* 2 margin) client-w)]
	[h (+ (* 2 margin) client-h)])
    (inset (rb-superimpose
	    (filled-rectangle w h #:draw-border? #f #:color vsc-background-blue)
	    (trapeze w 80)
	    (inset (scale-to-fit (vsc-logo)
				 (rectangle 60 60) #:mode 'preserve/max)
		   0 0 20 8))
	   (- margin))))

(define vsc-title
  (let ([w (+ (* 2 margin) client-w)]
	[h (+ (* 2 margin) client-h)])
    (inset
     (rt-superimpose
      (rb-superimpose
       (lb-superimpose
	(filled-rectangle w h #:draw-border? #f #:color vsc-background-blue)
	(bunch-of-lines w h)
	(flipped-trapeze (* 0.95 w) 180)
	(trapeze w 180)
	(inset (scale-to-fit (vsc-logo)
			     (rectangle 70 70) #:mode 'preserve/max)
	       60 0 30 8))
       (inset (colorize
	       (hc-append
		(with-font flanders-art-medium-logo (t "vscentrum"))
		(with-font flanders-art-logo (t ".be")))
	       vsc-bright)
	      0 0 20 30))
      (inset vsc-lion 0 30 0 0))

     (- margin))))

(define (prompt . txt)
  (let ((text (with-font inconsolata (para #:fill? #f
					   #:decode? #f
					   txt)))
	(margin 2))
    (pin-under
     (inset (colorize text vsc-slate) margin 0)
     0 0
     (filled-rounded-rectangle (+ (* 2 margin) (pict-width text))
			       (+ (* 2 margin) (pict-height text))
			       5
			       #:color vsc-gray3))))

(define (key txt)
  (let ((text (t txt))
	(margin 2))
    (pin-under
     (inset (colorize text vsc-bright) margin 0)
     0 0
     (filled-rounded-rectangle (+ (* 2 margin) (pict-width text))
			       (+ (* 2 margin) (pict-height text))
			       #:color vsc-orange
			       #:draw-border? #f))))

(define (indent s . rest)
  (let ((old-para-width (current-para-width)))
    (current-para-width (- old-para-width (* 2 (current-gap-size))))
    (let ((indent-par (para s rest)))
      (current-para-width old-para-width)
      (inset indent-par
	     (* 2 (current-gap-size))
	     (/ (current-gap-size) 4)
	     0
	     (/ (current-gap-size) 4)))))

(current-titlet
 (lambda (s)
   (colorize (text s flanders-art-medium) vsc-darkgray)))

(current-slide-assembler
 (lambda (title v-sep content)
   (let ([content (colorize content vsc-darkgray)])
     (lt-superimpose
      vsc-bg
      (if title
	  (vc-append v-sep (para (titlet title)) content)
	  content)))))

(current-para-width (* 7/8 client-w))
(current-main-font flanders-art)
(current-page-number-color vsc-bright)
(current-page-number-font flanders-art-logo)
(current-page-number-adjust
 ;; Center page number by appending a number of spaces that fills half
 ;; the page width...
 (lambda (num string)
   (let ([space-width (pict-width (text " " flanders-art-logo))]
	 [half-page-width (+ margin (/ client-w 2))])
     (string-append
      string
      (make-string
       (inexact->exact (round (/ half-page-width space-width)))
       #\space)))))

(define (title-assembler title v-sep content)
  (let ([content (colorize content vsc-slate)])
    (lt-superimpose
     vsc-title
     (if title
	 (vc-append v-sep (titlet title) content)
	 content))))

(define (title-slide #:title title
		     #:authors authors
		     #:subtitle [subtitle #f])
  (let ((old-slide-assembler (current-slide-assembler))
	(boldtitle (with-font flanders-art-big (bold (t title)))))
    (current-slide-assembler title-assembler)

    (slide
     (para #:align 'right
	   (hc-append
	    (colorize
	     (apply
	      vr-append
	      (cons (if subtitle
			(vl-append boldtitle (t subtitle))
			boldtitle)
		    (map t authors)))
	     vsc-darkgray)
	    (ghost (filled-rectangle (* 0.2 client-w) 10)))))

    (current-slide-assembler old-slide-assembler)))

(define (show-script content
		     #:title [title #f] #:width [width 0]
		     #:font [font inconsolata])
  (let* ([script (with-font font
		  (apply vl-append (map t (string-split content "\n"))))]
	 [text (if title
		   (vr-append
		    (colorize (t title) vsc-orange) script)
		   script)])
    (prompt (inset text margin))))

(module+ test
  (require rackunit))

(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  (check-equal? (+ 2 2) 4))

(module+ main
  ;; (Optional) main submodule. Put code here if you need it to be executed when
  ;; this file is run using DrRacket or the `racket` executable.  The code here
  ;; does not run when this file is required by another module. Documentation:
  ;; http://docs.racket-lang.org/guide/Module_Syntax.html#%28part._main-and-test%29

  (require racket/cmdline)
  (define who (box "world"))
  (command-line
    #:program "my-program"
    #:once-each
    [("-n" "--name") name "Who to say hello to" (set-box! who name)]
    #:args ()
    (printf "hello ~a~n" (unbox who))))
