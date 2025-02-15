(local bf (require :fnl2bf))

(local break "#[-]+[]")

(local op_ignore
  {:rgb   false
   :rgba  false
   :index false
   :diff  false
   :luma  false})

(local print-base64-digit
  (..
    (bf.case! 1
      0 (bf.print! "A")
      1 (bf.print! "B")
      2 (bf.print! "C")
      3 (bf.print! "D")
      4 (bf.print! "E")
      5 (bf.print! "F")
      6 (bf.print! "G")
      7 (bf.print! "H")
      8 (bf.print! "I")
      9 (bf.print! "J")
      10 (bf.print! "K")
      11 (bf.print! "L")
      12 (bf.print! "M")
      13 (bf.print! "N")
      14 (bf.print! "O")
      15 (bf.print! "P")
      16 (bf.print! "Q")
      17 (bf.print! "R")
      18 (bf.print! "S")
      19 (bf.print! "T")
      20 (bf.print! "U")
      21 (bf.print! "V")
      22 (bf.print! "W")
      23 (bf.print! "X")
      24 (bf.print! "Y")
      25 (bf.print! "Z")
      26 (bf.print! "a")
      27 (bf.print! "b")
      28 (bf.print! "c")
      29 (bf.print! "d")
      30 (bf.print! "e")
      31 (bf.print! "f")
      32 (bf.print! "g")
      33 (bf.print! "h")
      34 (bf.print! "i")
      35 (bf.print! "j")
      36 (bf.print! "k")
      37 (bf.print! "l")
      38 (bf.print! "m")
      39 (bf.print! "n")
      40 (bf.print! "o")
      41 (bf.print! "p")
      42 (bf.print! "q")
      43 (bf.print! "r")
      44 (bf.print! "s")
      45 (bf.print! "t")
      46 (bf.print! "u")
      47 (bf.print! "v")
      48 (bf.print! "w")
      49 (bf.print! "x")
      50 (bf.print! "y")
      51 (bf.print! "z")
      52 (bf.print! "0")
      53 (bf.print! "1")
      54 (bf.print! "2")
      55 (bf.print! "3")
      56 (bf.print! "4")
      57 (bf.print! "5")
      58 (bf.print! "6")
      59 (bf.print! "7")
      60 (bf.print! "8")
      61 (bf.print! "9")
      62 (bf.print! "+")
      63 (bf.print! "/"))))

(fn check-qoif []
  "Read four bytes and check that they are 'qoif'.
   Set the current cell to 1 if the header is valid, else to 0."
  (..
    ",>,>,>,\n"
    ">>[-]+<< set flag\n"

    "\n"
    (bf.case! 1
      "f" ""
          (bf.at 1 "[-]"))

    "\n<"
    (bf.case! 1
      "i" ""
           (bf.at 2 "[-]"))

    "\n<"
    (bf.case! 1
      "o" ""
          (bf.at 3 "[-]"))

    "\n<"
    (bf.case! 1
      "q" ""
          (bf.at 4 "[-]"))

    "\n\ncheck flag:\n"
    "[-]"
    (bf.at 5
      (bf.case! 1
        0 (.. (bf.print! "qoif header is invalid\n"))
          (bf.at -6 "[-]+")))

    "\n\n"))

(local main
  (..
    (bf.commentln
      "memory layout:"
      "00: w w w w 0, h h h h 0, channels has_alpha 0 colorspace 0 (decoded header)"
      "20: h h h h 0, 0 0 0 0 0, w w w w 0, 0 0 0 0 0 (loop variables)"
      "40: decoded_pixels 0 0 0 0, decoder temp … (decoder state)"
      "70: R G B A (previous/current pixel)"
      "90: R G B A 1 R G B A 1 … (array of previous pixels)")

    (bf.commentln "set initial value of the previous pixel (0,0,0,255)")
    (bf.at 73
      "-")

    (bf.commentln "initialize array of the previous pixels")
    (bf.at 90
      (string.rep ">>>>+>" 64)
      "<[<<<<<]>")

    (bf.commentln "check qoif header")
    (check-qoif)

    (bf.commentln "only continue if the header is valid:")
    (bf.if "\n"
      "[-]"

      (bf.commentln "kitty graphics")
      (bf.print! "\x1b_Ga=T,f=32,s=") "[-]"

      (bf.commentln "read width")
      (bf.at
        [3 ","
         2 ","
         1 ","
         0 ","])

      (bf.commentln "print width")
      (bf.Q.print-cell\)

      (bf.ptr 5)
      (bf.print! ",v=") "[-]"
      (bf.commentln "read height")
      (bf.at
        [3 ","
         2 ","
         1 ","
         0 ","])
      
      (bf.commentln "print height")
      (bf.Q.print-cell\)

      (bf.ptr 5)
      (bf.print! ",m=1;\x1b\\") "[-]"

      (bf.commentln "read channels: →channels has_alpha temp temp temp")
      ","
      (bf.mov 2 3)
      (bf.at 2
        (bf.case! 1
          4
          (..
              (bf.commentln "RGBA: set has_alpha to 1")
              (bf.at -2 "[-]+"))
          (..
              (bf.commentln "else: set has_alpha to 0")
              (bf.at -2 "[-]"))))

      (bf.ptr 3)
      (bf.commentln "read colorspace: →colorspace temp temp temp")
      ","

      (bf.commentln "decode image")
      (bf.ptr -8)
      (bf.commentln "copy height")
      (bf.Q.mov 3)
      (bf.Q.ptr 3)
      (bf.Q.loop (bf.comment "while rows are remaining:")
        (bf.commentln "copy width")
        (bf.Q.at -4
          (bf.Q.mov 6 true))
        (bf.Q.at 2
          (bf.Q.loop (bf.comment "while pixels in this row are remaining")

            (bf.at 10
              (bf.at [1 "[-]" 2 "[-]"])
              (bf.commentln "only read the next byte if decoded_pixels is zero")
              (bf.if= 0 1 2
                (bf.at -11

                  (bf.Q.at 3
                    "[-],"
                    (bf.mov 1 2 true)
                    (bf.at 1
                      (bf.case! 1
                        254
                        (..
                          (bf.commentln "QOI_OP_RGB")
                          (if op_ignore.rgb
                            ",,,[-]"
                            (bf.at [23 ","
                                    24 ","
                                    25 ","])))

                        255
                        (..
                          (bf.commentln "QOI_OP_RGBA")
                          (if op_ignore.rgba
                            ",,,,[-]"
                            (bf.at [23 ","
                                    24 ","
                                    25 ","
                                    26 ","])))

                        ; else
                        (..
                          (bf.commentln "2 bit tags")
                          (bf.zero)
                          (bf.at -2
                            (bf.mov 2 3 true))

                          (bf.commentln "multiply with carry by 4 to get the first two bits")
                          (bf.at 4 (bf.zero))
                          (bf.loop "->" (bf.double "++++") "<")

                          (bf.commentln "move tag")
                          (bf.at 4 (bf.mov 10 1 true))

                          (bf.commentln "get lower 6 bits")
                          (bf.at 1
                            "[---->+<]"
                            (bf.at 3 (bf.zero))
                            (bf.at 1 (bf.mov! -1)))

                          (bf.commentln "decode tag")
                          (bf.at 14
                            (bf.case! 1
                              0
                              (..
                                (bf.commentln "QOI_OP_INDEX")
                                (if op_ignore.index
                                  ""
                                  (..
                                    (bf.at -14
                                      (bf.commentln "move index")
                                      (bf.mov! (- 89 49)))
                                    (bf.at (- 90 63)
                                      (bf.commentln "get color from array")
                                      (bf.mirror (bf.arrayN.get 4))
                                      (bf.commentln "move color")
                                      (bf.at [-7 (bf.mov! -12)
                                              -6 (bf.mov! -12)
                                              -5 (bf.mov! -12)
                                              -4 (bf.mov! -12)])))))
                              1
                              (..
                                (bf.commentln "QOI_OP_DIFF")

                                (bf.at -14
                                  (bf.commentln "multiply with carry by 16 to get dr")
                                  (bf.at [1 (bf.zero) 4 (bf.zero)])
                                  (bf.loop "->" (bf.double (bf.inc 16)) "<")
                                  (bf.at 1 (bf.mov! -1))

                                  (bf.commentln "add dr to R")
                                  (bf.at 4
                                    (bf.inc -2)
                                    (if op_ignore.diff
                                      "[-]"
                                      (bf.add! 18)))

                                  (bf.commentln "multiply with carry by 4 to get dg")
                                  (bf.at [1 (bf.zero) 4 (bf.zero)])
                                  (bf.loop "->" (bf.double (bf.inc 4)) "<")
                                  (bf.at 1 (bf.mov! -1))

                                  (bf.commentln "add dg to G")
                                  (bf.at 4
                                    (bf.inc -2)
                                    (if op_ignore.diff
                                      "[-]"
                                      (bf.add! 19)))

                                  (bf.commentln "get db")
                                  (bf.at 1 (bf.zero))
                                  (bf.loop
                                    (bf.inc -64)
                                    (bf.at 1 "+"))

                                  (bf.commentln "add db to B")
                                  (bf.at 1
                                    (bf.inc -2)
                                    (if op_ignore.diff
                                      "[-]"
                                      (bf.add! 23)))))
                              2
                              (..
                                (bf.commentln "QOI_OP_LUMA")
                                (bf.at -14
                                  (bf.commentln "subtract dg bias")
                                  (bf.inc -32)
                                  (bf.commentln "add dg to G")
                                  (if op_ignore.luma
                                    ""
                                    (bf.add 23 1)))

                                (bf.commentln "read second byte of QOI_OP_LUMA")
                                ","

                                (bf.commentln "multiply with carry by 16 to get the upper four bits")
                                (bf.at 4 (bf.zero))
                                (bf.loop "->" (bf.double (bf.inc 16)) "<")

                                (bf.commentln "add dg to dr-dg")
                                (bf.at -14
                                  (bf.add 18 17))

                                (bf.at 4
                                  (bf.commentln "subtract dr bias")
                                  (bf.inc -8)
                                  (bf.commentln "add dr to R")
                                  (if op_ignore.luma
                                    "[-]"
                                    (bf.add! 4)))

                                (bf.commentln "get the lower 4 bits")
                                (bf.zero)
                                (bf.at 1
                                  (bf.loop
                                    (bf.inc -16)
                                    "<+>"))

                                (bf.commentln "add dg to db-dg")
                                (bf.at -14
                                  (bf.add 14 15))

                                (bf.commentln "subtract db bias")
                                (bf.inc -8)
                                (bf.commentln "add db to B")
                                (if op_ignore.luma
                                  "[-]"
                                  (bf.add! 10)))
                              3
                              (..
                                (bf.commentln "QOI_OP_RUN")
                                (bf.at -14
                                  ;; "+"
                                  ;; (bf.print-cell\)
                                  ;; "-"
                                  (bf.commentln "move length of the run")
                                  (bf.mov! -1)))))

                          (bf.commentln "move number of decoded pixels")
                          :+ (bf.mov! -7)

                          (bf.at [1 (bf.zero)
                                  4 (bf.zero)]))))))))

            (bf.commentln "print current pixel")
            (bf.at 44
              (bf.print! "\x1b_Gm=1;")
              (bf.zero)
              (bf.commentln "base64 encode RGBA")

              ;; first 6 bits of R
              (bf.at -4 (bf.mov 4 5))
              (bf.at 1 (bf.set 4))
              (bf.at 2 (bf.set 1))
              (bf.divmod\!)
              (bf.at [1 "[-]"
                      2 (bf.mov! 10)
                      3 print-base64-digit])
              
              ;; last 2 bits of R + first 4 bits of G
              (bf.at -3 (bf.mov 3 4))
              (bf.at 1 (bf.set 16))
              (bf.at 2 (bf.set 1))
              (bf.divmod\!)
              (bf.at [1 "[-]"
                      2 (bf.mov! 8)
                      12 (bf.multiply-add! 16 -9)
                      3 print-base64-digit])

              ;; last 4 bits of G + first 2 bits of B
              (bf.at -2 (bf.mov 2 3))
              (bf.at 1 (bf.set 64))
              (bf.at 2 (bf.set 1))
              (bf.divmod\!)
              (bf.at [1 "[-]"
                      10 (bf.multiply-add! 4 -7)
                      2 (bf.mov! 9)
                      3 print-base64-digit])
              
              ;; last 6 bits of B
              (bf.at 11 print-base64-digit)

              ;; A
              (bf.at -1 (bf.mov 1 2))
              (bf.at 1 (bf.set 4))
              (bf.at 2 (bf.set 1))
              (bf.divmod\!)
              (bf.at [1 "[-]"
                      3 print-base64-digit
                      3 (bf.zero)
                      2 (bf.multiply-add! 16 1)
                      3 print-base64-digit
                      3 (bf.zero)])

              (bf.print! "==\x1b\\")
              (bf.zero))

            (bf.at 15 (bf.zero)) ; ?

            (bf.at 40
              (bf.commentln
                "hash current pixel: (r*3+g*5+b*7+a*11)%64"
                "r g b a temp hash")
              (bf.at 4 "[-]")
              (bf.commentln "R:")
              (bf.loop
                (bf.at [0 "-"
                        4 "+"
                        5 "+++"]))
              (bf.at 4 (bf.mov! -4))
              (bf.commentln "G:")
              ">"
              (bf.loop
                (bf.at [0 "-"
                        3 "+"
                        4 "+++++"]))
              (bf.at 3 (bf.mov! -3))
              (bf.commentln "B:")
              ">"
              (bf.loop
                (bf.at [0 "-"
                        2 "+"
                        3 "+++++++"]))
              (bf.at 2 (bf.mov! -2))
              (bf.commentln "A:")
              ">"
              (bf.loop
                (bf.at [0 "-"
                        1 "+"
                        2 "+++++++++++"]))
              (bf.at 1 (bf.mov! -1))
              (bf.commentln "hash = hash % 64")
              ">>>" (bf.inc2 64 1) "<"
              (bf.mod\!)
              (bf.at [1 "[-]" 2 (bf.mov! -2)])
              (bf.commentln "store current pixel in array")
              (bf.at [-5 (bf.mov 14 4 true)
                      -4 (bf.mov 14 3 true)
                      -3 (bf.mov 14 2 true)
                      -2 (bf.mov 14 1 true)
                      0  (bf.mov! 13)])
              (bf.at 14 (bf.mirror (bf.arrayN.set 4)))
              "<<<<<")

            (bf.at 10
              (bf.commentln "decrement decoded_pixels")
              (bf.mov 1 2 true)
              (bf.at 1
                (bf.if "<->")))

            ;; next pixel
            (bf.quadruple "-")))

        (bf.commentln "next row")
        (bf.quadruple "-"))

      (bf.commentln "end kitty image")
      (bf.print! "\x1b_Gm=0;\x1b\\\n")
      (bf.zero))))

(-> main
    bf.optimize
    bf.format
    print)
