memory layout:
00: w w w w 0， h h h h 0， channels has_alpha 0 colorspace 0 (decoded header)
20: h h h h 0， 0 0 0 0 0， w w w w 0， 0 0 0 0 0 (loop variables)
40: decoded_pixels 0 0 0 0， decoder temp … (decoder state)

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
  [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.-
  -.------.---.[-]++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  +++.---.----.+++.+.+++++++++++++.[-]++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++.++++++++++.[-]++++++++++++++++++++++++++++++++.++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++.---------------------.+++++++++++.---.-----.[-]++++++++++.[-]
  read width
  [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++.--------------.-----.++++++++++++++++.------------.----------------------------------------------.---------------
  -----------.[-]>>>,<,<,<,
  print width
  >>>>>[-]>[-]>[-]>[-]>>[-]>[-]>[-]>[-]<<<+>>>>>[-]>[-]>[-]>[-]<<<+<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>
  >>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<
  <-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-
  ]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<
  <<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<
  <<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>
  >+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>
  >-<<<]>>-<<]>-<<<<<[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]
  ]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<<<<<<[>>>>+>>>>>+<<
  <<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<
  [[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>
  >>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>
  >>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>->>>>>+[
  <+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>
  >>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<
  [->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<
  [->>>>+<<<<]]]<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<
  <<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>
  >]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+
  >>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<
  <<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<
  <<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[
  <<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<
  <<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<
  <<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[
  >>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-
  ]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<
  <+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<<<<<]>++++++++++>>>>>[-]>[-]>[-]>[-]<<<+>>>>>[-]>[-]>[-]>[-]>>[-]>[-]>[-]>[-]>>[-]>[-]>[-]>[-]<<<<<
  <<<<<<<<<<<<<<<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<
  <<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>
  >]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<
  <<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<
  <<[->>>>-<<<<]>>>-<<<]>>-<<]>->>>>>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>
  >[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-[>>>>+>>
  >>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-
  ]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<
  <<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>>>>>>+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<
  <[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>>
  >>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<
  <<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-
  ]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-
  ]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<
  <<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[>>>>+>>>>>+
  <<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>
  >>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>
  >>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<
  +[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+
  >>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>
  >>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<
  <-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>+
  [<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>
  >>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<
  <[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<
  <[->>>>+<<<<]]]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<
  <<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>
  >>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]<<<<<<<<<<<<<<<<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-
  ]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<
  <+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<<<<<]>>>>>>>>>>>-[-<<<<<<<<<<+>>>>>>>>>>]<<<<<[-]++++++++[-<<<<<++++++>>>>>]>>>>>>>>>>[>>>>+>>>>>+<
  <<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<
  <[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>
  >>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>
  >>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<<
  <<<<+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[
  <<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<
  <<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>
  >>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>
  ]<<<<<]<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>
  >>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>
  >>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]<<<<[.[-]<<<<<]
  read height
  [-]++++++++++.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.---.++++.
  --.+.++++++++++++.----------------------------------------------------------.--------------------------.[-]>>>,<,<,<,
  print height
  >>>>>[-]>[-]>[-]>[-]>>[-]>[-]>[-]>[-]<<<+>>>>>[-]>[-]>[-]>[-]<<<+<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>
  >>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<
  <-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-
  ]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<
  <<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<
  <<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>
  >+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>
  >-<<<]>>-<<]>-<<<<<[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]
  ]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<<<<<<[>>>>+>>>>>+<<
  <<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<
  [[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>
  >>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>
  >>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>->>>>>+[
  <+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>
  >>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<
  [->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<
  [->>>>+<<<<]]]<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<
  <<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>
  >]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+
  >>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<
  <<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<
  <<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[
  <<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<
  <<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<
  <<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[
  >>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-
  ]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<
  <+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<<<<<]>++++++++++>>>>>[-]>[-]>[-]>[-]<<<+>>>>>[-]>[-]>[-]>[-]>>[-]>[-]>[-]>[-]>>[-]>[-]>[-]>[-]<<<<<
  <<<<<<<<<<<<<<<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<
  <<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>
  >]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<
  <<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<
  <<[->>>>-<<<<]>>>-<<<]>>-<<]>->>>>>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>
  >[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-[>>>>+>>
  >>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-
  ]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<
  <<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>>>>>>+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<
  <[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>>
  >>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<
  <<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-
  ]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-
  ]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<
  <<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[>>>>+>>>>>+
  <<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>
  >>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>
  >>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<
  +[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+
  >>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>
  >>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<
  <-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>+
  [<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>
  >>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<
  <[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<
  <[->>>>+<<<<]]]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<
  <<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>
  >>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]<<<<<<<<<<<<<<<<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-
  ]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<
  <+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<
  <<[[-]<<<<<+>>>>>]<<<<<]>>>>>>>>>>>-[-<<<<<<<<<<+>>>>>>>>>>]<<<<<[-]++++++++[-<<<<<++++++>>>>>]>>>>>>>>>>[>>>>+>>>>>+<
  <<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<
  <[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>
  >>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<[[-]>[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>
  >>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-<<<<<<
  <<<<+[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>+[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>+[
  <<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>+<<<<]]]>>>>>>>>>>>[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<
  <<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>
  >>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>
  ]<<<<<]<<<<<<<<<[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>>>
  >>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>
  >>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]<<<<[.[-]<<<<<]
  read channels: →channels has_alpha temp temp temp
  [-]++++++++++.[-],[>>+>+<<<-]>>>[<<<+>>>-]+<---[-[[-]>[<<[-]>>
        else: set has_alpha to 0
        [-]>---[<->-----]<++.+++++.++++++++.>-----[<---->+]<-.+++++++++++.---.-----.>----[<+++>----]<-.>----[<--->----]<
        .+++++.-------.+++++++++++++..---------.+++++++.+++++++.>-[<->+++++++++]<.>-----[<----->+]<-.[-]<++++++++++<<[->
        +>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>
        +>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]>>[-]++++++++++.[-]]<]>[<<[-]+>>
      RGBA: set has_alpha to 1
      [-]>-[<->+++]<---.-----------.-----.-.[-]++++++++++.[-]]<]>[<<[-]>>
    RGB: set has_alpha to 0
    [-]>-[<->+++]<---.-----------.-----.[-]++++++++++.[-]]
  read colorspace: →colorspace temp temp temp
  ,[>+>+<<-]>>[<<+>>-]+<[-[[-]>[[-]>---[<->-----]<++.+++++.++++++++.>-----[<---->+]<-.+++++++++++.---.-----.>----[<+++>-
  ---]<-.>----[<--->----]<.++++++++++++.---.+++.+++.+.---.---------------.++.++.>--[<->++++++]<.>-----[<----->+]<-.[-]++
  ++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>
  ]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]>[-]++++++++++.[-]]<]>[[-]>--[<->----
  ---]<--.---.+++++.---------.----.>----[<---->-]<+.[-]++++++++++.[-]]<]>[[-]>--[<->---------]<+.[-]>-[<->+++]<---.-----
  ------.-----.[-]++++++++++.[-]]<<
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
                      [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.--.------.+++
                      +++++++++++++++++++.----------------.+.+++++++++++++++.-------------.+++.-------.-----------------
                      ---.--------------------------.<<<<<<<<<<<<<<+>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]
                      >>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++
                      [->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<-
                      move length of the run
                      <[-]>[<+>-]>>>>>>>>>>>>>>[-]++++++++++.[-]]<]>[
                    QOI_OP_LUMA
                    [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.--.------.+++++
                    +++++++++++++++++.----------------.+.+++++++++++++++.-------------------.+++++++++.--------.--------
                    ----.-------.--------------------------.<<<<<<<<<<<<<<
                    subtract dg bias
                    --------------------------------
                    print dg
                    >>>[-]>[-]<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<+>[-]>>--[<<+>>--]>[-]<<<[->>+<[->-]>[<<[-]>>->]<<<]>[
                    [-]<+>]<[[-]>--[<+>++++++]<++.<-<[>-<-]>[<->+]>[-]++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]
                    >>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[-
                    >++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[>-<-]>[<->+]>[-]]<[[-]>[-]++++++++++<<[->+>-[>+
                    >>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]
                    <.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]]>>>>>>>>>>>>>[-]+++
                    +++++++++++++++++++++++++++++.
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
                    print dg
                    >>>[-]>[-]<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<+>[-]>>--[<<+>>--]>[-]<<<[->>+<[->-]>[<<[-]>>->]<<<]>[
                    [-]<+>]<[[-]>--[<+>++++++]<++.<-<[>-<-]>[<->+]>[-]++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]
                    >>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[-
                    >++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[>-<-]>[<->+]>[-]]<[[-]>[-]++++++++++<<[->+>-[>+
                    >>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]
                    <.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]]<[-]+++++++++++++++
                    +++++++++++++++++.[-]<<<<
                    get the lower 4 bits
                    [-]>[----------------<+>]<
                    add dg to db－dg
                    <<<<<<<<<<<<<<[>>>>>>>>>>>>>>+>+<<<<<<<<<<<<<<<-]>>>>>>>>>>>>>>>[<<<<<<<<<<<<<<<+>>>>>>>>>>>>>>>-]<
                    subtract db bias
                    --------
                    print db
                    >>>[-]>[-]<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<+>[-]>>--[<<+>>--]>[-]<<<[->>+<[->-]>[<<[-]>>->]<<<]>[
                    [-]<+>]<[[-]>--[<+>++++++]<++.<-<[>-<-]>[<->+]>[-]++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]
                    >>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[-
                    >++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[>-<-]>[<->+]>[-]]<[[-]>[-]++++++++++<<[->+>-[>+
                    >>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]
                    <.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]]<[-]++++++++++.[-]]
                    <]>[
                  QOI_OP_DIFF
                  [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.--.------.+++++++
                  +++++++++++++++.----------------.+.+++++++++++++++.---------------------------.+++++.---..------------
                  .--------------------------.<<<<<<<<<<<<<<
                  multiply with carry by 16 to get dr
                  >[-]>>>[-]<<<<[->>+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[
                  >-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[-
                  >>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<<<]>[<+>-]<
                  print dr
                  >>>>-->>>[-]>[-]<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<+>[-]>>--[<<+>>--]>[-]<<<[->>+<[->-]>[<<[-]>>->]<<
                  <]>[[-]<+>]<[[-]>--[<+>++++++]<++.<-<[>-<-]>[<->+]>[-]++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[
                  -]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[-
                  >++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[>-<-]>[<->+]>[-]]<[[-]>[-]++++++++++<<[->+>-[>+>>
                  ]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<
                  +>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]]<[-]+++++++++++++++++++++
                  +++++++++++.[-]<<<<
                  multiply with carry by 4 to get dg
                  >[-]>>>[-]<<<<[->>+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<+<+[>-]>[->>+<]<<<]>[<+>-]<
                  print dg
                  >>>>-->>>[-]>[-]<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<+>[-]>>--[<<+>>--]>[-]<<<[->>+<[->-]>[<<[-]>>->]<<
                  <]>[[-]<+>]<[[-]>--[<+>++++++]<++.<-<[>-<-]>[<->+]>[-]++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[
                  -]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[-
                  >++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[>-<-]>[<->+]>[-]]<[[-]>[-]++++++++++<<[->+>-[>+>>
                  ]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<
                  +>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]]<[-]+++++++++++++++++++++
                  +++++++++++.[-]<<<<
                  get db
                  >[-]<[---------------------------------------------------------------->+<]
                  print db
                  >-->>>[-]>[-]<<<<[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<+>[-]>>--[<<+>>--]>[-]<<<[->>+<[->-]>[<<[-]>>->]<<<]>
                  [[-]<+>]<[[-]>--[<+>++++++]<++.<-<[>-<-]>[<->+]>[-]++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>
                  >>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++
                  ++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[>-<-]>[<->+]>[-]]<[[-]>[-]++++++++++<<[->+>-[>+>>]>[
                  +[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+
                  >[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]]<[-]>>>>>>>>>>>>>[-]++++++++
                  ++.[-]]<]>[
                QOI_OP_INDEX
                [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.--.------.+++++++++
                +++++++++++++.----------------.+.+++++++++++++++.----------------------.+++++.----------.+.+++++++++++++
                ++++++.------------------------------.--------------------------.<<<<<<<<<<<<++++++++++<<[->+>-[>+>>]>[+
                [-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-
                ]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]>>>>>>>>>>>>>[-]++++++++++.[-]]<<<
                <<<<<<<<<<<<
              move number of decoded pixels
              +<<<<<<<[-]>>>>>>>[<<<<<<<+>>>>>>>-]>[-]>>>[-]<<<<[-]]<]>[
            QOI_OP_RGBA
            [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.--.------.+++++++++++++
            +++++++++.----------------.+.+++++++++++++++.-------------.-----------.-----.-.-------.---------------------
            -----.[-],>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[
            -]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-
            ]++++++++++++++++++++++++++++++++.[-],>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-
            [>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[
            -<++++++++>]<.[-]<<[-<+>]<[-]++++++++++++++++++++++++++++++++.[-],>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<
            <<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++
            [->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]++++++++++++++++++++++++++++++++.[-],>>++++++++++<<
            [->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>
            ]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]++++++++++.[-]]<]>[
          QOI_OP_RGB
          [-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.--.------.+++++++++++++++
          +++++++.----------------.+.+++++++++++++++.-------------.-----------.-----.--------.--------------------------
          .[-],>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>+
          +++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]++++++++
          ++++++++++++++++++++++++.[-],>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-
          <+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<
          .[-]<<[-<+>]<[-]++++++++++++++++++++++++++++++++.[-],>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++
          ++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-
          ]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]++++++++++.[-]]<<<<<<[-]]>>>>[-]<<<<<
      decrement decoded_pixels
      >[-]>[-]<<[>+>+<<-]>>[<<+>>-]<[<->[-]]<<<<<<<<<<<[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>[<<+>>>>>+<<
      <-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>>-<<<<]>>
      >-<<<]>>-<<]>-[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<[>>>+>>>>>+<<<<<<<<-]>
      >>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>>>>>>>-]<<<<<[[-]<<<<<+>>>>>
      ]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]<<<<<<<<<[<+>>>>>+<<<<-]<[>+<-]+>>>>>[<<<<<->>
      >>>[-]]<<<<<[->>[<<+>>>>>+<<<-]<<[>>+<<-]+>>>>>[<<<<<->>>>>[-]]<<<<<[->>>[<<<+>>>>>+<<-]<<<[>>>+<<<-]+>>>>>[<<<<<-
      >>>>>[-]]<<<<<[->>>>-<<<<]>>>-<<<]>>-<<]>-[>>>>+>>>>>+<<<<<<<<<-]>>>>>>>>>[<<<<<<<<<+>>>>>>>>>-]<<<<<[[-]<<<<<+>>>
      >>]<<<[>>>+>>>>>+<<<<<<<<-]>>>>>>>>[<<<<<<<<+>>>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<[>>+>>>>>+<<<<<<<-]>>>>>>>[<<<<<<<+>
      >>>>>>-]<<<<<[[-]<<<<<+>>>>>]<[>+>>>>>+<<<<<<-]>>>>>>[<<<<<<+>>>>>>-]<<<<<[[-]<<<<<+>>>>>]<<<<<]>
  read end of stream marker
  ,+>,+>,+>,+>,+>,+>,+>,+[<]<[-]+>>[>]<--[[-]<[<]<[-]>>[>]]<-[[-]<[<]<[-]>>[>]]<-[[-]<[<]<[-]>>[>]]<-[[-]<[<]<[-]>>[>]]<
  -[[-]<[<]<[-]>>[>]]<-[[-]<[<]<[-]>>[>]]<-[[-]<[<]<[-]>>[>]]<-[[-]<[<]<[-]>>[>]]<[-]+<[>[-]<[-]++++++++++++++++++++++++
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.+++++++++.----------.[-]++++++++++++++++
  ++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.---------.[-]++++++++
  ++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.+.--.----
  ---------.----.++++++++++++.[-]++++++++++++++++++++++++++++++++.++++++++++++++++++++++++++++++++++++++++++++++++++++++
  +++++++++++++++++++.++++++++++.[-]++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++++
  +++++++++++++++++++++++++++++++++++.---------------------.+++++++++++.---.-----.[-]++++++++++.[-]]>[[-]+++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.+++++++++.----------.[-]+++++++
  +++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.---------.[-
  ]++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
  +.--.-------------.----.++++++++++++.[-]++++++++++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++.++++++++++.[-]++++++++++++++++++++++++++++++++.++++++++++++++++++++++++++++++++++++++++++
  +++++++++++++++++++++++++++++++.+++++.++++++++.---------------------.+++++++++++.---.-----.[-]++++++++++.[-]]<[-]]
