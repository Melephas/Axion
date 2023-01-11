# Axion
Axion is currently a source only lisp variant that should be able to be
interpreted by any other lisp or an already running Axion REPL. Currently
the minimum feature set is that of [sectorlisp](https://github.com/jart/sectorlisp),
and the default function names in the REPL are taken from it.

Compatibility is mostly dependent on basic functions defined in the Lisp 1.5
Programmer's Manual. These functions are listed here for completeness:
- cons
- car
- cdr
- quote
- cond
- lambda
- atom
- eq

Additionally the following functions (or equivalents) are needed for the REPL:
- read
- print

## Issues
At the moment there is no way for a function (a lambda definition) to have a body
with multiple expressions. The current plan for implementation of this depends on
other missing features, namely a persistent environment and a way of interacting
with it.

Here's the shortlist for what will be implemented next, in no particular order:
- The 'label' function, to be able to add to the environment.
- Loops.
- Lambda expressions that can have multiple expressions in the body.
- A stage 2 interpreter that runs in the stage 1 interpreter or more full-fat versions of lisp

After all of these features are implemented there may be more advanced features planned. Or not ¯\\\_(ツ)_/¯
