Kyle Block
Carl Johnson
CSc 345
12/01/2017

Implementation Assignment 2: Quadtrees

No external dependencies or libraries are used in the program.
JOptionPane is utilized in a few places, and the full library path name is
used every time (javax.swing.JOptionPane...).

We made one change to the insert algorithm:
When in insert mode, if a the user tries to insert a segment where there is
already an existing segment, the program will print an error message and not
continue with the insert operation.
We put this code in the insert() method so that the tree is traversed only once
before attempting the insert.
