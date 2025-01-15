(local bf (require :fnl2bf))


(fn validate-ppm-header []
  "Read three bytes and check that they are 'P6\\n'.
   Set the current cell to 1 if the header is valid, else to 0."
  (..
    ",>,>, read PPM header\n"
    ">>[-]+<< set flag\n"

    "\n"
    (bf.case! 1
      "\n" ""
           ">[-]<")
    
    "\n<"
    (bf.case! 1
      "6" ""
          ">>[-]<<")

    "\n<"
    (bf.case! 1
      "P" ""
          ">>>[-]<<<")

    "\n\ncheck flag:\n"
    "[-]"
    (bf.at 4
      (bf.case! 1
        0 (.. (bf.print! "Invalid PPM header (expected P6)\n"))
          (bf.at -5 "[-]+")))
    
    "\n\n"))

(fn validate-maximum-value []
  "Read four bytes and check that they are '255\\n'.
   Set the current cell to 1 if the header is valid, else to 0."
  (..
    ",>,>,>, read maximum value\n"
    ">>[-]+<<   set flag\n"

    "\n"
    (bf.case! 1
      "\n" ""
           ">[-]<")
    
    "\n<"
    (bf.case! 1
      "5" ""
          ">>[-]<<")

    "\n<"
    (bf.case! 1
      "5" ""
          ">>>[-]<<<")
    
    "\n<"
    (bf.case! 1
      "2" ""
          ">>>>[-]<<<<")

    "\n\ncheck flag:\n"
    "[-]"
    (bf.at 5
      (bf.case! 1
        0 (.. (bf.print! "Invalid maximum color value (expected 255)\n"))
          (bf.at -6 "[-]+")))
    
    "\n\n"))

(fn main []
  "Main loop"
  (..
    (validate-ppm-header)
    (bf.loop
      "[-]"

      ;; {height} {width} {width copy} 0xfe r g b prev_r prev_g prev_b temp1 temp2 diff_flag
      
      "\nread width and height (limited to 16 bit values)\n"
      (bf.D.read-int " " 1 2 3 8) ; read width
      (bf.D.at 2
        (bf.D.mov! -1) ; move width
        (bf.D.read-int "\n" 1 2 3 8) ; read height
        (bf.D.at 2
          (bf.D.mov! -4))) ; move height

      "\ncopy width\n"
      (bf.D.ptr 1)
      (bf.D.mov 1 true)
      (bf.D.ptr 2)

      "\nvalidate the maximum value for each color\n"
      (validate-maximum-value) 
      (bf.loop
        "[-]"
        
        "\nwrite qoi header\n"
        (bf.print! "qoif") "[-]\n"

        "\nwrite width\n"
        (bf.D.at -2
          ">..>>.<<<.")

        "\nwrite height\n"
        (bf.D.at -3
          ">..>>.<<<.")

        "\nwrite channels (3=RGB) and colorspace (0=sRGB)\n"
        (bf.print! "\3\0") "[-]\n"

        "\nset 0xfe\n"
        (bf.set2 254 1)

        "\nwhile pixels remain convert them\n"

        (bf.D.ptr -3)
        (bf.double "[") ; while height
          (bf.D.at 2
            (bf.double "[") ; while copy of width
              
              ;; convert a single RGB pixel
              (bf.D.at 1
              
                ; read r g b
                ">,>,>,"

                ; prev_b –= b (using temp1)
                (bf.mov 4 5 true)
                (bf.at 4 (bf.sub! -1))

                ; prev_g –= g (using temp1)
                "<"
                (bf.mov 5 6 true)
                (bf.at 5 (bf.sub! -2))

                ; prev_r –= r (using temp1)
                "<"
                (bf.mov 6 7 true)
                (bf.at 6 (bf.sub! -3))

                ;; set diff_flag
                (bf.at 8 (bf.set 1))

                ;; prepare qoi_op_diff byte
                (bf.at 7 (bf.set 64))

                ">>>" ; move to prev_r, add dr to qoi_op_diff byte
                (bf.case! 3
                  255 (bf.at 1 (bf.inc 48))
                  0   (bf.at 1 (bf.inc 32))
                  1   (bf.at 1 (bf.inc 16))
                  2   (bf.at 1 (bf.inc 0))
                      (bf.at 2 (bf.zero))) ; reset diff_flag if dr is outside the encodable range´
                
                ">" ; move to prev_g, add dg to qoi_op_diff byte
                (bf.case! 2
                  255 (bf.at 1 (bf.inc 12))
                  0   (bf.at 1 (bf.inc 8))
                  1   (bf.at 1 (bf.inc 4))
                  2   (bf.at 1 (bf.inc 0))
                      (bf.at 2 (bf.zero))) ; reset diff_flag if dg is outside the encodable range
                
                ">" ; move to prev_b, add db to qoi_op_diff byte
                (bf.case! 1
                  255 (bf.at 1 (bf.inc 3))
                  0   (bf.at 1 (bf.inc 2))
                  1   (bf.at 1 (bf.inc 1))
                  2   (bf.at 1 (bf.inc 0))
                      (bf.at 2 (bf.zero))) ; reset diff_flag if db is outside the encodable range

                (bf.at 3 ; move to diff_flag
                  (bf.case! -2
                    0
                    (..
                      (bf.ptr -7)
                      ".>.>.>."
                      (bf.ptr 4))
                    
                    ;; else
                    ">.<")) ; qoi_op_diff

                "<<<<<" ; move back to r



                ; prev_r = r (using temp1)
                (bf.mov 3 6 true)

                ; prev_g = g (using temp1)
                ">"
                (bf.mov 3 5 true)

                ; prev_b = b (using temp1)
                ">"
                (bf.mov 3 4 true)

                "<<<" ; move back to 0xfe 
                )

              (bf.double "-]")) ; end width loop
          
          ;; copy width
          (bf.D.at 1 (bf.D.mov 1))
          (bf.double "-]") ; end height loop
        
        "\nwrite end of stream mark (0000 0001)\n"
        (bf.print! "\0\0\0\0\0\0\0\1")
        
        "\nexit\n"
        (bf.zero)))))


(-> (main)
  bf.optimize
  bf.format
  print)
