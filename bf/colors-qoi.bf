
This program generates a QOI image containing all possible combinations of two color channels


write qoi header: width=256 height=768 RGB
[-]>--[<->---------]<-.--.------.---.[-]..+.-...+++.---.+++.---.

red/green:
[-]--.++... write the first pixel (black)
-->+
>+<[>-]>[->+>[<-]<[<]>[-<+>]]<-[+<
<.>  write 0xfe (QOI_OP_RGB)
.    write R
>>>. write G
<.   write B
<<
>+<+[>-]>[->>+<]<< increment color
>+<[>-]>[->+>[<-]<[<]>[-<+>]]<-]<

red/blue:
[-]--.++... write the first pixel (black)
-->+
>+<[>-]>[->+>[<-]<[<]>[-<+>]]<-[+<
<.>  write 0xfe (QOI_OP_RGB)
.    write R
>>.  write G
>.   write B
<<<
>+<+[>-]>[->>+<]<< increment color
>+<[>-]>[->+>[<-]<[<]>[-<+>]]<-]<

green/blue:
[-]--.++... write the first pixel (black)
-->+
>+<[>-]>[->+>[<-]<[<]>[-<+>]]<-[+<
<.>  write 0xfe (QOI_OP_RGB)
>.<  write R
.    write G
>>>. write B
<<<
>+<+[>-]>[->>+<]<< increment color
>+<[>-]>[->+>[<-]<[<]>[-<+>]]<-]<

write the end of stream mark
[-].......+.
