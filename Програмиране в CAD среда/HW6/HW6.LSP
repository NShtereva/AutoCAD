(defun c:main_func ( / flg a1 a2 tita1 tita2 tita1_from tita1_to tita2_from tita2_to)
	(setq tita1_from 0.0
	      tita1_to 90.0
	      tita2_from 0.0
	      tita2_to 180.0
	) ;end setq
  	(dialog)
	(if (/= flg 1) ((draw_position) (draw_workspace)))
) ;end defun

; 1. Input
(defun dialog ( / dcl_id flag1)
	(setq flag1 0 flg 0)
  
	(while (/= flag1 1)
		(setq dcl_id (load_dialog "c:/Vlisp/dcl/HW6_81971.dcl"))
		(if (not (new_dialog "ROBOT" dcl_id)) (exit))
  
		(if (not a1) (setq a1 150.0)) (if (not a2) (setq a2 100.0))
	  	(set_tile "a1" (rtos a1)) (set_tile "a2" (rtos a2))

	  	(if (not tita1) (setq tita1 30.0)) (if (not tita2) (setq tita2 45.0))
	  	(set_tile "tita1" (rtos tita1)) (set_tile "tita2" (rtos tita2))
       
	  	(action_tile "cancel" "(done_dialog) (setq flg 1 flag1 1)")
		(action_tile "accept" "(set_vars) (done_dialog)")
	  	(start_dialog) (unload_dialog dcl_id)
	) ; end while
) ;end defun

(defun set_vars ( / )
	(setq a1    (atof (get_tile "a1"))
       	      a2    (atof (get_tile "a2"))
	      tita1 (atof (get_tile "tita1"))
	      tita2 (atof (get_tile "tita2"))
	      flag1 1
        ) ;end setq

  	(cond ((<= a1 0.0) (setq flag1 0) (alert "Incorrect value for first length!"))
	      ((<= a2 0.0) (setq flag1 0) (alert "Incorrect value for second length!"))
	      ((or (<= tita1 tita1_from) (>= tita1 tita1_to)) (setq flag1 0) (alert "Incorrect value for tita1!"))
	      ((or (<= tita2 tita2_from) (>= tita2 tita2_to)) (setq flag1 0) (alert "Incorrect value for tita2!"))
	) ;end cond
)

; 2 and 3
(defun draw_line (point1 point2 layer color / )
	(entmake (list '(0 . "LINE") (cons 8 layer) (cons 62 color) (cons 10 point1) (cons 11 point2)))
  	(princ)
) ;end defun

(defun draw_circle (center r color layer / )
  	(setq enlist (list '(0 . "CIRCLE") '(100 . "AcDbEntity") '(100 . "AcDbCircle") (cons 8 layer)
			   (cons 62 color) (cons 10 center) (cons 40 r) '(100 . "AcDbArc")
		     ) ;end list
	) ;end setq
  
  	(entmake enlist)
  	(princ)
) ;end defun

(defun draw_support ( / p1 p2 p3 p4)
	(setq p1 (list 0.0 0.0)
      	      p2 (polar p1 (/ pi 2.0) (- 30.0))
      	      p3 (polar p2 0.0 22.0)
       	      p4 (polar p2 pi 22.0)
      	) ;end setq

  	(draw_line p1 p3 "Support" 4) (draw_line p1 p4 "Support" 4) (draw_line p3 p4 "Support" 4)
  	(draw_circle p1 8.0 4 "Support")
) ;end defun

(defun draw_link (point1 point2 / tita r p1 p2)
	(setq tita (angle point1 point2)
      	      r 8.0
  	      p1 (polar point1 tita r)
    	      p2 (polar point2 tita (- r))  
  	) ;end setq

  	(draw_circle point1 r 4 "Link")
  	(draw_circle point2 r 4 "Link")
  	(draw_line p1 p2 "Link" 4)
) ;end defun

(defun dtr (x) (* pi (/ x 180.0)))

(defun draw_position ( / link1_end link2_end)
	(draw_line (list 0.0 0.0) (list 0.0 300.0) "Axis" 6)
  	(draw_line (list 0.0 0.0) (list 300.0 0.0) "Axis" 6)
  	(draw_support)

  	(setq link1_end (polar (list 0.0 0.0) (dtr tita1) a1)
	      link2_end (polar link1_end (dtr (+ tita1 tita2)) a2)
	) ;end setq

  	(draw_link (list 0.0 0.0) link1_end)
  	(draw_link link1_end link2_end)
) ;end defun

; 4. Workspace
(defun draw_workspace ( / )
  	(draw_circle (list 0.0 0.0) (+ a1 a2) 1 "Workspace")
  	(if (/= a1 a2) (draw_circle (list 0.0 0.0) (abs (- a1 a2)) 1 "Workspace"))

  	(setq angl1 tita1_from angl2 tita2_from)

  	(while (<= angl1 tita1_to)
	  	(while (<= angl2 tita2_to)
	  		(setq link1_end (polar (list 0.0 0.0) (dtr angl1) a1)
	      	      	      link2_end (polar link1_end (dtr (+ angl1 angl2)) a2)
			) ;end setq
		  	(draw_circle link2_end 8.0 1 "Workspace")
		  	(setq angl2 (+ angl2 5))
		) ;end while
	  	(setq angl1 (+ angl1 5) angl2 0)
	) ;end while
) ;end defun