(defun C:epicycloid ( / centerPoint r1 r2 lp)
	(initget 1)
	(setq centerPoint (getpoint "\nCenter point: "))

	(initget 7)
	(setq r1 (getdist "\nEnter the radius of the guidance circle: "))

	(initget 7)
	(while (not (= (rem r1 (setq r2 (getdist "\nEnter the radius of the epicycle: "))) 0))  )

  	(initget 6) ; lp must not be zero or neg
 	(setq lp (getint "\nPoints per rotation <30>: "))
	(cond ((null lp) (setq lp 30)))

  	(calculate centerPoint r1 r2 lp)
)

(defun calculate (centerPoint r1 r2 lp / tita)
  	(getsystvar)
	(setq k (fix (/ r1 r2)))
  	(setq begin (list (+ (car centerPoint) r1) (cadr centerPoint)))
  	(setq tita 0.0)
  	(setq anglInc (/ (* 2 pi) (* k lp)))
  	(turnofsyst)

  	(create_layer)

  	(change_layer "GuidanceCircle")
  	(command "circle" centerPoint r1)

  	(change_layer "Epicycloid")
 	(command "pline" begin) ; start spiral from base point and...
 	(repeat k
 		(repeat lp
 			(setq tp (list (+ (- (* (+ r1 r2) (cos tita)) (* r2 (cos (* (/ (+ r1 r2) r2) tita)))) (car centerPoint))
				       (+ (- (* (+ r1 r2) (sin tita)) (* r2 (sin (* (/ (+ r1 r2) r2) tita)))) (cadr centerPoint))
				 ))
 			(command tp) ; continue to the next point...
		  	(setq tita (+ tita anglInc))
 		)
 	)
 	(command) ; until done.
  
 	(setsystvar)
)

;GetVAR
(defun getsystvar ()
	(setq cs      (getvar "cmdecho") ; save old cmdecho
	      oldsnap (getvar "osmode")
        )
)

; turn off systems
(defun turnofsyst ()
	(setvar "cmdecho" 0) ; turn cmdecho off
	(setvar "osmode" 0)
)

(defun setsystvar ()
	(setvar "osmode" oldsnap)
	(setvar "cmdecho" cs)
)

(defun create_layer ()
	(command "layer" "n" "GuidanceCircle" "c" "blue" "GuidanceCircle" "")
	(command "layer" "n" "Epicycloid" "c" "red" "Epicycloid" "")
)

(defun change_layer (layer_name)
	(command "layer" "s" layer_name "")
)