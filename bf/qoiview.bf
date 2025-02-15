memory layout:
00: w w w w 0， h h h h 0， channels has_alpha 0 colorspace 0 (decoded header)
20: h h h h 0， 0 0 0 0 0， w w w w 0， 0 0 0 0 0 (loop variables)
40: decoded_pixels 0 0 0 0， decoder temp … (decoder state)
70: R G B A (previous/current pixel)
90: R G B A 1 R G B A 1 … (array of previous pixels)

set initial value of the previous pixel (0，0，0，255)
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<
initialize array of the previous pixels
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>
>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>
>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>
>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+>>>>>+[<<<<<]
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
check qoif header
,>,>,>,
>>[-]+<< set flag

>[-]+<------------------------------------------------------------------------------------------------------[[-]>[>[-]<[
-]]<]>[-]<
[-]+<---------------------------------------------------------------------------------------------------------[[-]>[>>[-
]<<[-]]<]>[-]<
[-]+<---------------------------------------------------------------------------------------------------------------[[-]
>[>>>[-]<<<[-]]<]>[-]<
[-]+<-----------------------------------------------------------------------------------------------------------------[[
-]>[>>>>[-]<<<<[-]]<]>[-]<

check flag:
[-]>>>>>>[-]+<[[-]>[<<<<<<[-]+>>>>>>[-]]<]>[[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++.--.------.---.[-]++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++.---.----.+++.+.+++++++++++++.[-]++++++++++++++++++++++++++++++++.+++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.++++++++++.[-]++++++++++++++++++++++++++++++++.++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.+++++.++++++++.---------------------.+++++++++++.---.---
--.[-]++++++++++.[-]]<<<<<<


only continue if the header is valid:
[
  [-]
  read width
  >>>,<,<,<,>>>>>
  read height
  >>>,<,<,<,>>>>>
  read channels: →channels has_alpha temp temp temp
  ,[>>+>+<<<-]>>>[<<<+>>>-]+<----[[-]>[
      else: set has_alpha to 0
      <<[-]>>[-]]<]>[
    RGBA: set has_alpha to 1
    <<[-]+>>[-]]
  read colorspace: →colorspace temp temp temp
  ,
  decode image
  <<<<<<<<
  copy height
  [>>>>>>>>>>>>>>>+<<<<<<<<<<<+<<<<-]>>>>[<<<<+>>>>-]<<<[>>>>>>>>>>>>>>>+<<<<<<<<<<<<+<<<-]>>>[<<<+>>>-]<<[>>>>>>>>>>>>>
  >>+<<<<<<<<<<<<<+<<-]>>[<<+>>-]<[>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<+<-]>[<+>-]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[
  <<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[
  >>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<
  +>>>>>]<<<<<[[-]>while rows are remaining:
    copy width
    >>>>>>>>>>[-]<<<<<<<<<<<<<<<<<<<<<<<<<<[-]<<<<[>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<<<<<+<<<<-]>>>>[
    <<<<+>>>>-]>>>>>>>>>>>>>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]<<<[>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<
    <<<<<<<<<<<<<<<<<+<<<-]>>>[<<<+>>>-]>>>>>>>>>>>>>>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]<<[>>>>>>>>>>>>>>>
    >>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<<<<<<<+<<-]>>[<<+>>-]>>>>>>>>>>>>>>>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<<<<<<<<<<<
    <<<<[-]<[>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<<<<<<<<+<-]>[<+>-]>>>>>>>>>>>>>>>>>>>>>>>>>>[>>>>+>>>>
    >+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-
    ]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<
    <<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>while pixels in this row are remaining>>>>>>>>>>>[-]>[-]<<
      only read the next byte if decoded_pixels is zero
      [>+>+<<-]>>[<<+>>-]<[>-<-]>[[-]<+>]<-[>>>>[-],>[-]>[-]<<[>+>+<<-]>>[<<+>>-]+<++[-[[-]>[
              2 bit tags
              [-]>[-]<<<[>>+>+<<<-]>>>[<<<+>>>-]<
              multiply with carry by 4 to get the first two bits
              >>>>[-]<<<<[->>+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<<<]
              move tag
              >>>>>>>>>>>>>>[-]<<<<<<<<<[-]<[>>>>>>>>>>+<<<<<<<<<+<-]>[<+>-]<<<<<
              get lower 6 bits
              >[---->+<]>>>[-]<<<[-]>[<+>-]<<
              decode tag
              >>>>>>>>>>>>>>>[-]+<[-[-[-[->[-]<]>[
                      QOI_OP_RUN
                      <<<<<<<<<<<<<<
                      move length of the run
                      <[-]>[<+>-]>>>>>>>>>>>>>>[-]]<]>[
                    QOI_OP_LUMA
                    <<<<<<<<<<<<<<
                    subtract dg bias
                    --------------------------------
                    add dg to G
                    [>>>>>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<+<-]>[<+>-]>>>>>>>>>>>>>
                    read second byte of QOI_OP_LUMA
                    ,
                    multiply with carry by 16 to get the upper four bits
                    >>>>[-]<<<<[->>+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>
                    -]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[
                    ->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<<<]
                    add dg to dr－dg
                    <<<<<<<<<<<<<<[>>>>>>>>>>>>>>>>>>+<+<<<<<<<<<<<<<<<<<-]>>>>>>>>>>>>>>>>>[<<<<<<<<<<<<<<<<<+>>>>>>>>>
                    >>>>>>>>-]>
                    subtract dr bias
                    --------
                    add dr to R
                    [>>>>+<<<<-]<<<<
                    get the lower 4 bits
                    [-]>[----------------<+>]<
                    add dg to db－dg
                    <<<<<<<<<<<<<<[>>>>>>>>>>>>>>+>+<<<<<<<<<<<<<<<-]>>>>>>>>>>>>>>>[<<<<<<<<<<<<<<<+>>>>>>>>>>>>>>>-]<
                    subtract db bias
                    --------
                    add db to B
                    [>>>>>>>>>>+<<<<<<<<<<-]]<]>[
                  QOI_OP_DIFF
                  <<<<<<<<<<<<<<
                  multiply with carry by 16 to get dr
                  >[-]>>>[-]<<<<[->>+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[
                  >-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[-
                  >>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<<<]>[<+>-]<
                  add dr to R
                  >>>>--[>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<-]<<<<
                  multiply with carry by 4 to get dg
                  >[-]>>>[-]<<<<[->>+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<<<]>[<+>-]<
                  add dg to G
                  >>>>--[>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<-]<<<<
                  get db
                  >[-]<[---------------------------------------------------------------->+<]
                  add db to B
                  >--[>>>>>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<<-]>>>>>>>>>>>>>[-]]<]>[
                QOI_OP_INDEX
                <<<<<<<<<<<<<<
                move index
                >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[>>>>>>>>>>>>>>>>>>>>
                >>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<-]>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                get color from array
                <+[>>>>>>[>>>>>]<<<<<[>>>>>+<<<<<-]>>>>[-]<<<<<[>>>>>+<<<<<-]>>>>[-]<<<<<[>>>>>+<<<<<-]>>>>[-]<<<<<[>>>>
                >+<<<<<-]>>>>[-]<<<<<[>>>>>+<<<<<-]<[<<<<<]<-]>>>>>>[>>>>>]>[<<+>+>-]<[>+<-]<[-<<<<[<<<<<]<<<<<<<+>>>>>>
                >>>>>>[>>>>>]<]<<<[-]>>>>>[<<<<<+>>>>>-]>[<<<+>>+>-]<[>+<-]<<[-<<<<[<<<<<]<<<<<<+>>>>>>>>>>>[>>>>>]<]<<[
                -]>>>>>[<<<<<+>>>>>-]>[<<<<+>>>+>-]<[>+<-]<<<[-<<<<[<<<<<]<<<<<+>>>>>>>>>>[>>>>>]<]<[-]>>>>>[<<<<<+>>>>>
                -]>[<<<<<+>>>>+>-]<[>+<-]<<<<[-<<<<[<<<<<]<<<<+>>>>>>>>>[>>>>>]<]>>>>>[<<<<<+>>>>>-]<<<<[-]>>>>>[<<<<<+>
                >>>>-]>>>>>[<<<<[<<<<<+>>>>>-]>[<<<<<+>>>>>-]>[<<<<<+>>>>>-]>[<<<<<+>>>>>-]>[<<<<<+>>>>>-]>>>>>]<<<<<<<<
                <<[<<<<<]
                move color
                <<<<<<<<<<<<<<<<<<<[-]>>>>>>>>>>>>[<<<<<<<<<<<<+>>>>>>>>>>>>-]<<<<<<<<<<<[-]>>>>>>>>>>>>[<<<<<<<<<<<<+>>
                >>>>>>>>>>-]<<<<<<<<<<<[-]>>>>>>>>>>>>[<<<<<<<<<<<<+>>>>>>>>>>>>-]<<<<<<<<<<<[-]>>>>>>>>>>>>[<<<<<<<<<<<
                <+>>>>>>>>>>>>-]<<<<<<<<<<<<<<<<<<<<<<<[-]]<<<<<<<<<<<<<<<
              move number of decoded pixels
              +<<<<<<<[-]>>>>>>>[<<<<<<<+>>>>>>>-]>[-]>>>[-]<<<<[-]]<]>[
            QOI_OP_RGBA
            >>>>>>>>>>>>>>>>>>>>>>>,>,>,>,<<<<<<<<<<<<<<<<<<<<<<<<<<[-]]<]>[
          QOI_OP_RGB
          >>>>>>>>>>>>>>>>>>>>>>>,>,>,<<<<<<<<<<<<<<<<<<<<<<<<<[-]]<<<<<<[-]]<<<<<<<<<<<
      print current pixel
      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>[>+>+<<-]>>[<<+>>-]<[>+>+<<-]>>[<<+>>-]<[>-<-]>[[-]<+>]<-[
        if alpha is 0: use terminal background color
        [-]+++++++++++++++++++++++++++.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.----------------
        ---------------------------.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++
        +++++++++++++..[-]]<[[-]
        if alpha is ＞0:
        [-]+++++++++++++++++++++++++++.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.----------------
        -----------------------.++++.+++.---------.+++++++++.[-]<<<<[>>>>+>+<<<<<-]>>>>>[<<<<<+>>>>>-]>++++++++++<<[->+>
        -[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>
        [-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]++++++++++++++++++++++++++++++++++++
        +++++++++++++++++++++++.[-]<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>
        >++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[
        -]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]<<[>>+>+
        <<<-]>>>[<<<+>>>-]>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<
        ]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]
        +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-
        ]++++++++++++++++++++++++++++++++..[-]]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<[-]>>>>>>>>>>>>>>>>>>>>>>>>>
      hash current pixel: (r*3＋g*5＋b*7＋a*11)%64
      r g b a temp hash
      >>>>[-]<<<<
      R:
      [->>>>+>+++<<<<<]>>>>[<<<<+>>>>-]<<<<
      G:
      >[->>>+>+++++<<<<]>>>[<<<+>>>-]<<<
      B:
      >[->>+>+++++++<<<]>>[<<+>>-]<<
      A:
      >[->+>+++++++++++<<]>[<+>-]<
      hash = hash % 64
      >>>>----[<+>----]<+<[>->+<[>]>[<+>-]<<[<]>-]>[-]<[-]>>[<<+>>-]<<
      store current pixel in array
      >>>>>>>>>[-]<<<<<<<<<<[-]<<<<[>>>>>>>>>>>>>>+<<<<<<<<<<+<<<<-]>>>>[<<<<+>>>>-]>>>>>>>>>>>[-]<<<<<<<<<<<[-]<<<[>>>>
      >>>>>>>>>>+<<<<<<<<<<<+<<<-]>>>[<<<+>>>-]>>>>>>>>>>>>[-]<<<<<<<<<<<<[-]<<[>>>>>>>>>>>>>>+<<<<<<<<<<<<+<<-]>>[<<+>>
      -]>>>>>>>>>>>>>[-]<<<<<<<<<<<<<[-]<[>>>>>>>>>>>>>>+<<<<<<<<<<<<<+<-]>[<+>-]>>>>>>>>>>>>>>[-]<<<<<<<<<<<<<[>>>>>>>>
      >>>>>+<<<<<<<<<<<<<-]>>>>>>>>>>>>>+[>>>>>>[>>>>>]<<<<<[>>>>>+<<<<<-]>>>>[-]<<<<<[>>>>>+<<<<<-]>>>>[-]<<<<<[>>>>>+<
      <<<<-]>>>>[-]<<<<<[>>>>>+<<<<<-]>>>>[-]<<<<<[>>>>>+<<<<<-]<[<<<<<]<-]>>>>>>[>>>>>]>[-]>[-]>[-]>[-]<<<<<<<<<[<<<<<]
      <<[->>>>>>>[>>>>>]>>>>+<<<<<<<<<[<<<<<]<<]<[->>>>>>>>[>>>>>]>>>+<<<<<<<<[<<<<<]<<<]<[->>>>>>>>>[>>>>>]>>+<<<<<<<[<
      <<<<]<<<<]<[->>>>>>>>>>[>>>>>]>+<<<<<<[<<<<<]<<<<<]>>>>>>>>>>[>>>>>]>>>>>[<<<<[<<<<<+>>>>>-]>[<<<<<+>>>>>-]>[<<<<<
      +>>>>>-]>[<<<<<+>>>>>-]>[<<<<<+>>>>>-]>>>>>]<<<<<<<<<<[<<<<<]<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      decrement decoded_pixels
      >[-]>[-]<<[>+>+<<-]>>[<<+>>-]<[<->[-]]<<<<<<<<<<<[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<
      <-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>
      >-<<<]>>-<<]>-[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>
      >>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>
      ]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]<<<<<<<<<
    next row
    [<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>
    >>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>->>>>[-]+++++++++++++++++++++++++++.++++
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.-------------------------------------------.+++++++++++
    ++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++.[-]<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>
    >>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+
    <<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]
    <<<<<]>
  reset terminal colors
  [-]+++++++++++++++++++++++++++.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.----------------------
  ---------------------.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]]
