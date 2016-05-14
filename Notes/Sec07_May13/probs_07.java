import java.*;
import java.util.*;

/*
 * TODO: Discuss --
 * 1. Parameter passing: reference vs value
 * 2. Garbage collection? finalize()
 * 3. Lambdas
 */


/*
 * A simple example on Generics
 *
 * Discuss:
 * --------
 *  - Are push pop enough? How to detect emptiness? How to compute size?
 */

interface Stack<E> {
  void push(E e);
  E pop();
}

class ListStack<E> implements Stack<E> {
  protected LinkedList<E> l;

  public ListStack() {
    l = new LinkedList<E>();
  }

  public void push(E e) {
    l.push(e);
  }

  public E pop() {
    return l.pop();
  }
}




/*
 * A cooler example. Uses C++-style CRTP (Curiously Recurring Template Patterns)
 *
 * Motivation: Method chaining
 */

interface CoolStack<E, S extends CoolStack<E, S>> {
  S push(E e);
  E pop();
}

class CoolListStack<E> implements CoolStack<E, CoolListStack<E>> {
  protected LinkedList<E> l;

  public CoolListStack() {
    l = new LinkedList<E>();
  }

  public CoolListStack<E> push(E e) {
    l.push(e);
    return this;
  }

  public E pop() {
    return l.pop();
  }
}



class Test {
  public static void main(String[] args) {
    ListStack<Integer> s = new ListStack<Integer>();
    s.push(1);
    s.push(2);
    s.push(3);
    s.push(4);

    try {
      while(true) System.out.println(s.pop());
    } catch (Exception e) {
      System.out.println("END");
    }

    CoolListStack<Integer> cs = new CoolListStack<Integer>();
    cs.push(1).push(2).push(3).push(4);

    try {
      while(true) System.out.println(cs.pop());
    } catch (Exception e) {
      System.out.println("END");
    }
  }
}
