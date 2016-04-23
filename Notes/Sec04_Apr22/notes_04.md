Exceptions
=============

- `exception` keyword is used to create new exceptions
- `exception <NAME> of <PARAM>` > PARAM can be a tuple
- No polymorphism in `PARAM`
- exceptions have type `exn`
- `raise` has signature `exn -> 'a`
  - matches any type, for exception raising functions to be correctly type-checked
  - still doesn't break strong-typing because exceptions halt execution anyway
- Exception catching syntax:

```ocaml
try
    dirty_code
with
    Exception_1 -> Handle_1
  | Exception_2 -> Handle_2
   ...
  | Exception_N -> Handle_N
```

- Higher order library functions exit earlier on raising an exception within the argument function
  - Could be used to terminate `fold_left`, `map` etc earlier
- OCaml has a built-in Exception: `Exit` which you one use. No library functions throw `Exit`
