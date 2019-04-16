vsc-slideshow
=============
This package sets up the [Racket](https://racket-lang.org)
[slideshow](https://docs.racket-lang.org/slideshow/index.html) library
to produce a slideshow according to the style guide for the Flemish
Supercomputing Center (VSC -- [vscentrum.be](https://vscentrum.be)).

### Requirements ###

- Flanders Art Sans and Inconsolata fonts.

- Racket, with packages slideshow and rsvg (and its external
dependency, [libRSVG](https://wiki.gnome.org/Projects/LibRsvg)).

### Installation ###

Install with `$ raco pkg install
https://github.com/tdanckaert/vsc-slideshow.git`.  Now you can start a
slideshow using this style as follows:

```scheme
#lang slideshow

(require vsc-slideshow)

(begin

  (title-slide #:title "My first slideshow"
		    #:subtitle "using vsc-slideshow"
		    #:authors '("Me"))

  (slide #:title "My first slide"))
```
