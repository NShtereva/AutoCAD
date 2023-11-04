(defun c:yin-yang ( / flg d1 d2)
	(dialog)
	(if (/= flg 1) (draw_symbol))
)

(defun dialog ( / dcl_id flag1)
	(setq flag1 0 flg 0)
  
	(while (/= flag1 1)
		(setq dcl_id (load_dialog "c:/Vlisp/dcl/HW5_81971.dcl"))
		(if (not (new_dialog "YINYANG" dcl_id)) (exit))
  
		(if (not d1) (setq d1 120.0)) (if (not d2) (setq d2 30.0))
	  	(set_tile "D1" (rtos d1)) (set_tile "D2" (rtos d2))

	  	(setq x (dimx_tile "Slide1") y (dimy_tile "Slide1"))
		(start_image "Slide1") (slide_image 20 3 x y "HW5") (end_image)
       
	  	(action_tile "cancel" "(done_dialog) (setq flg 1 flag1 1)")
		(action_tile "accept" "(set_vars) (done_dialog)")
	  	(start_dialog) (unload_dialog dcl_id)
	) ; end while
);end defun

(defun set_vars ( / )
	(setq d1 (atof (get_tile "D1"))
       	      d2 (atof (get_tile "D2"))
	      flag1 1
        )

  	(cond ((<= d1 0.0) (setq flag1 0) (alert "Incorrect value!"))
	      ((<= d2 0.0) (setq flag1 0) (alert "Incorrect value!"))
	      ((/= d2 (/ d1 4)) (setq flag1 0) (alert "Irregular proportions of the diameters (1:4)!"))
	) ;end cond
 )

(defun draw_symbol (/ c1 c2 arc1p1 arc1p2 arc1p3 arc2p1 arc2p2 arc2p3)
	  (setq oldsnap (getvar "osmode"))
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