Generics
========


#### Motivation

```
List l = new LinkedList();           // note the lack of <String>
l.add("lolz");
Integer i = (Integer) l.getFirst();  // Compiles fine, but run-time error
```


#### Declaration vs Usage

- Declaration: `class C<G> { ... }` | `G` is just a symbol
- Bounded Declaration: `C<G extends T>` | `G` is a symbol, `T` is an actual type (which is the upper-bound)
- Usage: `C<T> c;` | `T` is an actual type
- Usage: `C<> c;` | Java 7+ allows this when the generic parameter is clear from the context

- Why no lower-bound? Like, `C<T extends G>` ... `Object` is a trivial `G`.

#### Wildcards

- `C<? extends T> cx = ct;`
- No `implements` keyword, regardless of whether `T` is a class or an interface


#### Type Erasure

- Java erases the generic parameters after type-checking
- Thus, lots of things don't work for the generic parameter. For example:
  - No `instanceof` checks, like `G instanceof Integer`
  - No object construction, like `new G()`
