(local bf (require :fnl2bf))

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
      "70: R G B A")

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
                          (bf.at [23 ","
                                  24 ","
                                  25 ","]))

                        255
                        (..
                          (bf.commentln "QOI_OP_RGBA")
                          (bf.at [23 ","
                                  24 ","
                                  25 ","
                                  26 ","]))

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
                                ;; (bf.at -14 (bf.print-cell\))
                                ;; (bf.print! "\n")
                                )
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
                                    (bf.add! 18))

                                  (bf.commentln "multiply with carry by 4 to get dg")
                                  (bf.at [1 (bf.zero) 4 (bf.zero)])
                                  (bf.loop "->" (bf.double (bf.inc 4)) "<")
                                  (bf.at 1 (bf.mov! -1))

                                  (bf.commentln "add dg to G")
                                  (bf.at 4
                                    (bf.inc -2)
                                    (bf.add! 19))

                                  (bf.commentln "get db")
                                  (bf.at 1 (bf.zero))
                                  (bf.loop
                                    (bf.inc -64)
                                    (bf.at 1 "+"))

                                  (bf.commentln "add db to B")
                                  (bf.at 1
                                    (bf.inc -2)
                                    (bf.add! 23))))
                              2
                              (..
                                (bf.commentln "QOI_OP_LUMA")
                                (bf.at -14
                                  (bf.commentln "subtract dg bias")
                                  (bf.inc -32)
                                  (bf.commentln "add dg to G")
                                  (bf.add 23 1))

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
                                  (bf.add! 4))

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
                                (bf.add! 10))
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
                                  4 (bf.zero)])))))

                  )))
            
            (bf.commentln "print current pixel")
            (bf.at 44
              (bf.print! "\x1b[48;2;")
              (bf.zero)
              (bf.at [-4 (bf.mov 4 5)
                      0  (bf.print-cell\)
                      0  (bf.print! ";")
                      0  (bf.zero)
                      -3 (bf.mov 3 4)
                      0  (bf.print-cell\)
                      0  (bf.print! ";")
                      0  (bf.zero)
                      -2 (bf.mov 2 3)
                      0  (bf.print-cell\)
                      0  (bf.print! "m  ")
                      0  (bf.zero)]))

            (bf.at 15 (bf.zero)) ; ?

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
          (bf.print! "\x1b[0m\n")
          (bf.zero)))

      (bf.commentln "reset terminal colors")
      (bf.print! "\x1b[0m")
      (bf.zero))))

(-> main
    bf.optimize
    bf.format
    print)
