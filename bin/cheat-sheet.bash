#! /bin/bash
enscript -B -fCourier24 -d PDF << END
===================================
showfunc -- defined where?
planner  -- weekly planner
rttime
===================================
Koha terminology:
    Holds are "trapped"
===================================
Pandoc:
    [link text](URL)
===================================
Git:
    git fetch --all
===================================
Mysql:
    information_schema.columns
        table_name
        column_name
===================================
Chrome:
Hide/Show bookmarks bar:
    <Control><Shift><B>
===================================
Xubuntu:

Send window to workspace N:
    <Alt><Control><Keypad N>
Use <Super><Arrow Key> to tile
    Up, Down, Left, Right 
Unicode: <Shift><Control> HEX STRING
Safe Reboot:
  <Control><Alt><PRT-SCN>
    R E I S U B
===================================
IRC:

Open PM without saying anything
    /q NICK
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
awk '/start/,/stop/' file.txt
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
PDF printer: PDF

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________

___________________________________
END
