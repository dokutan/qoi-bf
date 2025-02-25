(local bf (require :fnl2bf))

(local op_ignore
  {:rgb   false
   :rgba  false
   :index false
   :diff  false
   :luma  false})

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
      "A decoder for the Quite OK Image Format"
      ""
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

      (bf.commentln "read width")
      (bf.at
        [3 ","
         2 ","
         1 ","
         0 ","])

      (bf.ptr 5)
      (bf.commentln "read height")
      (bf.at
        [3 ","
         2 ","
         1 ","
         0 ","])

      (bf.ptr 5)
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

            (bf.at 40
              (bf.commentln
                "insert code that is run for each pixel here:"
                "→R G B A"
                ""
                ""
                ""))

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
        (bf.quadruple "-")
        (bf.at 4
          (bf.commentln
            "insert code that is run after each row here:"
            ""
            ""
            ""))))))

(-> main
    bf.optimize
    bf.format
    print)
