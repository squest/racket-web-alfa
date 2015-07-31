#lang racket

(require web-server/servlet
	 web-server/servlet-env
	 web-server/templates
	 web-server/dispatch)

(define (home-page req nama) '(rhome-page ,nama))
(define (land-page req) '(rland-page))

(define (rhome-page nama)
  (let [(pname nama)]
    (include-template "templates/index.html")))

(define (rland-page)
  (rhome-page "World!"))

(define-values (page-dispatch route)
  (dispatch-rules
   [("") land-page]
   [("hello" (string-arg)) home-page]))

(define (app-page page)
  (response/full
   200 #"Okay"
   (current-seconds) TEXT/HTML-MIME-TYPE
   empty
   (list (string->bytes/utf-8 page))))

(define (app req)
  (begin (display req)
	 (page-dispatch req)))

(define public-dir "/Users/questmac/public/learning/racket/web/alfa/")

(serve/servlet
 app	       
 #:launch-browser? #t
 #:quit? #f
 #:port 3000
 #:extra-files-paths (list (build-path "js")
			   (build-path "css"))
 #:servlet-path "")



               
