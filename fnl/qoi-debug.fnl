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

(fn main []
  (..
    (bf.commentln
      "memory layout:"
      "0 w w w w 0 h h h h 0 channels has_alpha 0 colorspace")

    (bf.commentln "check qoif header")
    (check-qoif)

    (bf.if (bf.comment "only continue if the header is valid:")

      (bf.print! "qoif header is valid\n")
      "[-]>"

      (bf.commentln "read width")
      (bf.print! "width: ") (bf.zero)
      (bf.at
        [3 ","
         2 ","
         1 ","
         0 ","])
      
      (bf.commentln "print width")
      (bf.Q.print-cell\)

      (bf.ptr 5)
      (bf.commentln "read height")
      (bf.print! "\nheight: ") (bf.zero)
      (bf.at
        [3 ","
         2 ","
         1 ","
         0 ","])

      (bf.commentln "print height")
      (bf.Q.print-cell\)

      (bf.ptr 5)
      (bf.commentln "read channels: →channels has_alpha temp temp temp")
      (bf.print! "\n") (bf.zero)
      ","
      (bf.mov 2 3)
      (bf.at 2
        (bf.case! 1
          3
          (..
              (bf.at -2 "[-]") (bf.commentln "RGB: set has_alpha to 0")
              (bf.print2! "RGB\n" 1))
          4
          (..
              (bf.at -2 "[-]+") (bf.commentln "RGBA: set has_alpha to 1")
              (bf.print2! "RGBA\n" 1))
          (..
              (bf.at -2 "[-]") (bf.commentln "else: set has_alpha to 0")
              (bf.print2! "invalid channels: " 1)
              (bf.zero)
              (bf.at -3 (bf.print-cell\))
              (bf.print! "\n"))))

      (bf.ptr 3)
      (bf.commentln "read colorspace: →colorspace temp temp temp")
      ","
      (bf.mov 1 2)
      (bf.at 1
        (bf.case! 1
          0 (bf.print2! "sRGB\n" 1)
          1 (bf.print2! "linear\n" 1)
          (..
              (bf.print2! "invalid colorspace: " 1)
              (bf.zero)
              (bf.at -2 (bf.print-cell\))
              (bf.print! "\n"))))


    )))

(print (main))
