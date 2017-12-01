Kyle Block
Carl Johnson
CSc 345
12/01/2017

Implementation Assignment 2: Quadtrees

To the best of our knowledge, our program is complete and conforms to the
specification. It uses the latest version of Processing, and no additional
libraries are required for functionality.

There are two things to note:

1) We made one change to the insert algorithm.
When in insert mode, if a the user tries to insert a segment where there is
already an existing segment, the program will print an error message and not
continue with the insert operation.
We put this code in the insert() method so that the tree is traversed only once
before attempting the insert.

2) Our program only allows the user to read one input
file per run of the program. If the user would like to load a new file, they
will have to close the program and start a new session.
