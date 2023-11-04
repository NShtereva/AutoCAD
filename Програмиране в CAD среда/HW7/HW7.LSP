(defun c:rings ( / )
  	(dialog)
  	(create_layers)
  	(if (/= flg 1) (draw))
) ;end defun

(defun dialog ( / dcl_id flag1)
	(setq flag1 0 flg 0)
  
	(while (/= flag1 1)
		(setq dcl_id (load_dialog "c:/Vlisp/dcl/HW7_81971.dcl"))
		(if (not (new_dialog "RINGS" dcl_id)) (exit))

	  	(if (and (not typeN) (not typeM)) (setq typeN "1" typeM "0"))
  		(set_tile "N" typeN) (set_tile "M" typeM)

	  	(setq x1 (dimx_tile "SlideType") y1 (dimy_tile "SlideType"))
		(start_image "SlideType") (slide_image 0 -10 x1 y1 "HW7_Type") (end_image)

	  	(if (and (not colorG) (not colorS) (not colorB)) (setq colorG "0" colorS "1" colorB "0"))
  		(set_tile "G" colorG) (set_tile "S" colorS) (set_tile "B" colorB)

	  	(if (and (not w2) (not w4) (not w6) (not w8)) (setq w2 "0" w4 "1" w6 "0" w8 "0"))
  		(set_tile "W2" w2) (set_tile "W4" w4) (set_tile "W6" w6) (set_tile "W8" w8)

	  	(setq x2 (dimx_tile "SlideRHS") y2 (dimy_tile "SlideRHS"))
		(start_image "SlideRHS") (slide_image 5 -10 x2 y2 "HW7_RHS") (end_image)
       
	  	(action_tile "cancel" "(done_dialog) (setq flg 1 flag1 1)")
		(action_tile "accept" "(set_vars) (done_dialog)")
	  	(start_dialog) (unload_dialog dcl_id)
	) ; end while
) ;end defun

(defun set_vars ( / )
	(setq typeN  (get_tile "N")
	      typeM  (get_tile "M")
	      colorG (get_tile "G")
	      colorS (get_tile "S")
	      colorB (get_tile "B")
	      w2     (get_tile "W2")
	      w4     (get_tile "W4")
	      w6     (get_tile "W6")
	      w8     (get_tile "W8")
	      size   (get_tile "Size")
	      shape  (get_tile "RHS")
	) ;end setq
  	
  	(cond ((and (= shape "1") (= typeM "1")) (setq flag1 0) (alert "The \"Butterfly\" ring head is only compatible with normal type ring!"))
	      ((and (= shape "2") (= typeM "1")) (setq flag1 0) (alert "The \"Flower\" ring head is only compatible with normal type ring!"))
	      ((and (= shape "4") (= typeM "1")) (setq flag1 0) (alert "The \"Star\" ring head is only compatible with normal type ring!"))
	      ((and (= shape "6") (= typeN "1")) (setq flag1 0) (alert "The \"Anchor\" ring head is only compatible with massive type ring!"))
	      ((= shape "0") (setq flag1 0) (alert "Please, select a ring head shape!"))
	      ((= size "0") (setq flag1 0) (alert "Please, select a size!"))
	      ((setq flag1 1))
	) ;end cond
) ;end defun

(defun create_layers()
	(command "layer" "n" "Golden" "c" "yellow" "Golden" "")
	(command "layer" "n" "Silver" "c" "white" "Silver" "")
	(command "layer" "n" "Black" "c" 250 "Black" "")
) ;end defun

(defun change_layer(layer_name)
	(command "layer" "s" layer_name "")
) ;end defun

(defun i_block (name center scale_x scale_y scale_z angl / )
	  (command "insert" name center scale_x scale_y scale_z angl)
) ;end defun

(defun draw_ring (layer / name center scale_x scale_y scale_z angl)
  	(setq name    "Non-adjustable_4mm"
	      center  (list 0 0 0)
	      scale_x 1
	      scale_y 1
	      scale_z 1
	      angl    0
	) ; end setq
  
	(cond ((= typeN "1") (cond ((= w2 "1") (setq name "Non-adjustable_2mm"))
				   ((= w4 "1") (setq name "Non-adjustable_4mm"))
				   ((= w6 "1") (setq name "Non-adjustable_6mm"))
				   ((= w8 "1") (setq name "Non-adjustable_8mm"))
	                     ) ;end cond
	      ) ;end case1
	      ((= typeM "1") (cond ((= w2 "1") (setq name "Massive_2mm"))
				   ((= w4 "1") (setq name "Massive_4mm"))
				   ((= w6 "1") (setq name "Massive_6mm"))
				   ((= w8 "1") (setq name "Massive_8mm"))
	                     ) ;end cond
	      ) ;end case2
	) ;end cond

  	(cond ((= size "2") (setq scale_x (* scale_x 1.0540540541)
				  scale_y (* scale_y 1.0540540541)
			    ) ;end setq
	      ) ;end case1
	      ((= size "3") (setq scale_x (* scale_x 1.1216216216)
				  scale_y (* scale_y 1.1216216216)
			    ) ;end setq
	      ) ;end case2
	      ((= size "4") (setq scale_x (* scale_x 1.1621621622)
				  scale_y (* scale_y 1.1621621622)
			    ) ;end setq
	      ) ;end case3
	      ((= size "5") (setq scale_x (* scale_x 1.222972973)
				  scale_y (* scale_y 1.222972973)
			    ) ;end setq
	      ) ;end case4
	      ((= size "6") (setq scale_x (* scale_x 1.2905405405)
				  scale_y (* scale_y 1.2905405405)
			    ) ;end setq
	      ) ;end case5
	      ((= size "7") (setq scale_x (* scale_x 1.3310810811)
				  scale_y (* scale_y 1.3310810811)
			    ) ;end setq
	      ) ;end case6
	) ;end cond
  
  	(change_layer layer)
  	(i_block name center scale_x scale_y scale_z angl)
)

(defun draw_head (layer / name center scale_x scale_y scale_z angl r)
  	(setq name    "Butterfly"
	      center  (list 0 0 0)
	      scale_x 1
	      scale_y 1
	      scale_z 1
	      angl    0
	      r	      7.4
	) ; end setq
  
 	(cond ((= shape "2") (setq name "Flower"))
	      ((= shape "3") (setq name "Heart"))
	      ((= shape "4") (setq name "Star"))
	      ((= shape "5") (setq name "Sun"))
	      ((= shape "6") (setq name "Anchor"))
	      ((= shape "7") (setq name "Compass"))
	) ;end cond

  	(cond ((= size "2") (setq r 7.8))
	      ((= size "3") (setq r 8.3))
	      ((= size "4") (setq r 8.6))
	      ((= size "5") (setq r 9.05))
	      ((= size "6") (setq r 9.55))
	      ((= size "7") (setq r 9.85))
	) ;end cond

  	(cond ((and (= typeM "1") (= shape "7")) (setq r (+ r 2)))
	      ((and (= typeM "1") (and (/= shape "6") (/= shape "7")) (setq r (+ r 1.5))))
	      ((and (= typeN "1") (= shape "7")) (setq r (+ r 0.6)))
	) ;end cond

  	(cond ((= shape "6") (setq r (+ r 1.5)))
	      ((and (= shape "7") (/= size "1")) (setq r (+ r (* (atoi size) 0.06))))
	) ;end cond

  	(setq center (list 0 0 r))

  	(i_block name center scale_x scale_y scale_z angl)
) ;end defun

(defun draw ( / layer)
	(setq layer "Silver")

  	(cond ((= colorG "1") (setq layer "Golden"))
	      ((= colorS "1") (setq layer "Silver"))
	      ((= colorB "1") (setq layer "Black"))
	) ;end cond
  
  	(draw_ring layer)
  	(draw_head layer)
) ;end defun
