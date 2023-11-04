;task1.1
(defun C:message ()
  (alert "This is my first program.")
  (princ)
)

;task1.2
(defun dtr (x) (* pi (/ x 180.0)))
(princ)

(defun C:square (/ ipoint a p2 p3 p4 c r)
  (setq oldsnap (getvar "osmode"))

  (setvar "osmode" 32)
  (setq ipoint (getpoint "\nInsertion point: "))
  (setvar "osmode" 0)
  
  (initget (+ 1 2 4))
  (setq a (getdist "\nEnter length of the side of the square: "))

  (setq p2 (polar ipoint (dtr 0.0) a))
  (setq p3 (polar p2 (dtr 90.0) a))
  (setq p4 (polar p3 (dtr 180.0) a))

  (setq c (list (+ (car ipoint) (/ a 2)) (+ (cadr ipoint) (/ a 2)) 0)) ;circle center
  (setq r (/ a 2)) ; circle radius

  (command "line" ipoint p2 p3 p4 ipoint "")
  (command "circle" c r "")

  (setvar "osmode" 32)
  (setvar "osmode" oldsnap)
  (princ)
)

(defun C:rsquare (/ ipoint a angl p2 p3 p4 diam c r)
  (setq oldsnap (getvar "osmode"))

  (setvar "osmode" 32)
  (setq ipoint (getpoint "\nInsertion point: "))
  (setvar "osmode" 0)
  
  (initget (+ 1 2 4))
  (setq a (getdist "\nEnter length of the side of the square: "))

  (setq angl (getangle "\nEnter angle: "))

  (setq p2 (polar ipoint (+ (dtr 0.0) angl) a))
  (setq p3 (polar p2 (+ (dtr 90.0) angl) a))
  (setq p4 (polar p3 (+ (dtr 180.0) angl) a))

  (setq diam (sqrt (* 2 a a)))

  (setq c (polar ipoint (+ (dtr 45.0) angl) (/ diam 2))) ;circle center
  (setq r (/ a 2)) ; circle radius

  (command "line" ipoint p2 p3 p4 ipoint "")
  (command "circle" c r "")
  
  (setvar "osmode" 32)
  (setvar "osmode" oldsnap)
  (princ)
)

;task1.3
(defun C:yin-yang (/ d1 d2 c1 c2 arc1p1 arc1p2 arc1p3 arc2p1 arc2p2 arc2p3)
  (setq oldsnap (getvar "osmode"))
  (setvar "osmode" 0)
  
  (initget (+ 1 2 4))
  (setq d1 (getdist "\nEnter a diameter for the big circle: "))
  (initget (+ 1 2 4))
  (while (not (< (setq d2 (getdist "\nEnter a diameter for the small circles: ")) (/ d1 3))))

  (setvar "osmode" 32)
  
  (while
  	(setq ipoint (getpoint "\nInsertion Point : "))
  	(setvar "osmode" 0)

    	(setq c1 (list (car ipoint) (+ (cadr ipoint) (/ d1 4)) 0))
    	(setq c2 (list (car ipoint) (- (cadr ipoint) (/ d1 4)) 0))

    	(setq arc1p1 (list (car ipoint) (+ (cadr ipoint) (/ d1 2)) 0))
    	(setq arc1p2 (list (- (car c1) (/ d1 4)) (cadr c1) 0))
    	(setq arc1p3 ipoint)

    	(setq arc2p1 ipoint)
    	(setq arc2p2 (list (+ (car c2) (/ d1 4)) (cadr c2) 0))
    	(setq arc2p3 (list (car ipoint) (- (cadr ipoint) (/ d1 2)) 0)) 

    	(command "circle" ipoint (/ d1 2) "")
    	(command "circle" c1 (/ d2 2) "")
    	(command "circle" c2 (/ d2 2) "")
    	(command "arc" arc1p1 arc1p2 arc1p3 "")
    	(command "arc" arc2p1 arc2p2 arc2p3 "")

    	(setvar "osmode" 32)
  )
  (setvar "osmode" oldsnap)
  (princ)
)