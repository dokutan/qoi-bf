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

      ;; {height} {width} {width copy} 0xfe temp
      
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
                "." ; write 0xfe
                ">,.,.,.[-]<")

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
