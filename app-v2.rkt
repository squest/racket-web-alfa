#lang racket

(require (planet dmac/spin)
	 web-server/templates)

(get "/"
     (lambda () (rhome-page "Joni")))

(get "/resources/app.js"
     (lambda (req) (include-template "resources/app.js")))

(define (rhome-page nama)
  (let [(pname nama)
	(public-dir "resources/")]
    (include-template "templates/index.html")))

(run)
