Sub-typing vs Inheritance
==========================

- `S` is a sub-type of `T` (`S <: T`) implies S-values can be used in place of T-values
  - For example, a function expecting T-values would be happy with S-values
- Inheritance is re-use of code -- an entity inherits real code from another entity
  - For example, a class inherits (entire code of) another class
- In Java, you can `implement` multiple interfaces, but `extend` only 1 class
- 3 ways of sub-typing in Java:
  - `class C1 extends class C2`:, Sub-typing and inheritance
  - `class C1 implements interface I1, I2, I3 ...`: Sub-typing, but no inheritance
  - `interface I1 extends interface I2, I3, I4 ...`: Sub-typing, but no inheritance
- `S <: T` does not necessarily imply a collection of S is a sub-type of collection of T
  - The issue: if `C(S) <: C(T)` and let `X <: T`, then it would allow adding X-values to
    C(S) (after treating them as C(T)) -- which is a problem as X and S might not compatible
