Recursive Types
===============

- This works:

`type 'a tree = Node of 'a tree * a * 'a tree`

- But this does not:

`type 'a tree = 'a tree * a * 'a tree`

although, the Node constructor seems useless.

- OCaml allows recursive types, if wrapped in a constructor. Attempts to prevent
  users from _accidentally_ defining infinite structures.
  - In the first case, one *must* use the `Node` constructor. So, OCaml assumes
    that if an infinite structure is constructed, it wasn't accidental.

    `let rec inf_tree = Node(inf_tree, 5, inf_tree)` vs
    `let rec inf_tree = (inf_tree, 5, inf_tree)`

- But you can override this protection using `-rectypes` flag.
  - Crazy functions like `fun x -> x :: x` now type-check!


Polymorphic Functions
========================

- Functions which can accept arguments of different (any) types
- The type signature of the function has one or more type variables (like 'a), for the arguments
- The type of return type is usually dependent on the argument type or is fixed
- Can return type be polymorphic, with the argument type is fixed?
  - No. It would violate strong typing, inevitable run-time error!
  - Only example: `raise: exn -> 'a`, which is a run-time exception anyway.


Identify polymorphic functions:

- `let f x = x + 1`
  - `x`: `int`
  - `f`: `int -> int`
  - Not polymorphic

- `let f x = 1`
  - `x`: `'a` (anything)
  - `f`: `'a -> int`
  - Polymorphic

- `let f x y = x`
  - `x`: `'a` (anything)
  - `y`: `'b` (anything)
  - `f`: `'a -> 'b -> 'a`
  - Polymorphic

- `let f (x, y) = x +. y`
  - `x`: `float`
  - `y`: `float`
  - `f`: `(float * float) -> float`
  - Not Polymorphic

- `let f x = match x with [] -> 0 | _::t -> 1 + (f t)`
  - `x`: `'a list`
  - `f`: `'a list -> int`
  - Polymorphic
