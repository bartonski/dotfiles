#! /bin/bash
enscript -fCourier24 -d cups-pdf << END
===================================
VIM:

Write a read-only buffer:
:w !sudo tee %
===================================
BASH:

trim prefix:
\${variable#*X} # X is the delimiter
trim extension:
\${variable%X*} # X is the delimiter
===================================
preppath: creates \$PREP_AGENCYPATH
prodpath: creates \$PROD_AGENCYPATH
===================================
                  decl.  use
array            | ()   | [ ]     |
array reference  | [ ]  | \$\$foo[] |
hash             | ()   | {}      |
hash reference   |      |         |
sub              |      |         |
sub reference    |      |         |
===================================
for (( expr1; expr2; expr3 ))
do
   list
done

command | while read i
do 
   list # \$i must be quoted
done

===================================
ncpa.cpl:     network connection
sysdm.cpl:    system properties
desk.cpl:     display properties
inetcpl.cpl:  internet properties
odbccp32.cpl: ODBC properties
printers:     printers folder
folders:      folder properties

===================================
Send IT requests to
core-it-request@appriss.com

===================================
Vimdiff commands

:[range]diffg -- pull diff from
                 other buffer
:[range]diffp -- push diff to
                 other buffer
CTRL-W CTRL-W -- put curser in other
                 buffer.


===================================
Emacs Keys:
Directions --
  p
b . f
  n
Control-[pbfn] move one character
Meta-[bf] move one word
C-v down 1 page
M-v up 1 page
C-l center cursor on page

C-{a,e} {start,end} of line
M-{a,e} {start,end} of sentence


===================================
Screen:
	C-a esc
		scrollback mode
	C-a :
		command mode

===================================
Outlook:

Control-q: Mark as read
===================================
PDF printer: cups-pdf

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________
END
