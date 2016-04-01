System Set-up
=============

#### Learn about [OCaml][OCaml]
+ [Installation][OCaml-Install]

#### System setup
  + Package manager [OPAM][OPAM]
  + OCaml toplevel
    + The default toplevel sucks!
    + Try [utop][utop] (universal toplevel)

#### Primitives

##### Lists

Cons (::) examples:

- `1::2::[]`
- `[1]::[[2]]`
- `[1;2]::[[]]`
- `‘a :: ‘a list`
- Adds in front of list

Demystifying `List` syntax ... `::`, `;` and `[]`:

- `::` has an element on left and list on right
- `::` is right associative
- `1::2::3::[]` = `[1; 2; 3]` = `1::(2::(3::[]))`
- `1::2` is not a valid expression! (neither an `int list`, nor an `int`)
- `1::2::[3; 4]` is valid and has type `int list`.
- `[1::2]::[[3; 4]]` is not a valid expression.
- `[1;2]::[[3; 4]]` is valid and has type `int list list`. (= `[[1; 2]; [3; 4]]`)

Append (@) examples:

- Appends two lists
- `[1; 2] @ [3; 4]` = `[1; 2; 3; 4]`
- `[1; 2]::[3; 4]` is invalid


Pattern Matching
=================

- `h;t` is invalid syntax
- `[h;t]` matches a 2 element list only
- `[h::t]`  matches a list of lists, with at least 1 element in outer list
- `h::t` matches a list with at least one element
- `h@t` is invalid syntax
- `_` matches anything
- `_::t`    matches the top-most (i.e. the first) ::
- `h::m::t` h and m are first 2 elements, t is the rest
- `(x,y)::t` first element matched to tuple directly


[neovim]:         https://neovim.io/
[OCaml]:          https://ocaml.org/
[OCaml-Install]:  https://ocaml.org/docs/install.html
[OPAM]:           https://opam.ocaml.org/
[utop]:           https://github.com/diml/utop
