(local bf (require :fnl2bf))

(print
  (..
    (bf.commentln "This program generates a QOI image containing all possible combinations of two color channels")

    (bf.commentln "\nwrite qoi header: width=256 height=768 RGB")
    (bf.print!
      (..
        "qoif"
        "\0\0\1\0" ; width
        "\0\0\3\0" ; height
        "\3" ; channels
        "\0")) ; colorspace


    (bf.commentln "\nred/green:")
    (bf.print! "\254\0\0\0") (bf.comment " write the first pixel (black)\n")
    (bf.inc 254)
    ">+\n"
    (bf.double "[")
    "\n"
    "<.>  write 0xfe (QOI_OP_RGB)\n"
    ".    write R\n"
    ">>>. write G\n"
    "<.   write B\n"
    "<<\n"
    (bf.double "+ increment color\n]")


    (bf.commentln "\nred/blue:")
    (bf.print! "\254\0\0\0") (bf.comment " write the first pixel (black)\n")
    (bf.inc 254)
    ">+\n"
    (bf.double "[")
    "\n"
    "<.>  write 0xfe (QOI_OP_RGB)\n"
    ".    write R\n"
    ">>.  write G\n"
    ">.   write B\n"
    "<<<\n"
    (bf.double "+ increment color\n]")


    (bf.commentln "\ngreen/blue:")
    (bf.print! "\254\0\0\0") (bf.comment " write the first pixel (black)\n")
    (bf.inc 254)
    ">+\n"
    (bf.double "[")
    "\n"
    "<.>  write 0xfe (QOI_OP_RGB)\n"
    ">.<  write R\n"
    ".    write G\n"
    ">>>. write B\n"
    "<<<\n"
    (bf.double "+ increment color\n]")

    (bf.commentln "\nwrite the end of stream mark")
    (bf.print! "\0\0\0\0\0\0\0\1")))
