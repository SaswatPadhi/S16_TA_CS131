/*
 * Problems Set 5
 * ================
 * - Sub-typing
 * - Inheritance
 * - Static Overloading
 * - Dynamic Dispatch (Overriding)
 */

import java.io.IOException;

class Point {
  public int x, y;

  public boolean isEqual(Point p) {
    System.out.print("Point.isEqual(Point) -- ");
    return p.x == x && p.y == y;
  }

  public double dist(Point p) {
    System.out.print("Point.dist(Point) -- ");
    return Math.sqrt(Math.pow(x - p.x, 2) + Math.pow(y - p.y, 2));
  }
}


class ColoredPoint extends Point {
  public int color;

  // Overloading within ColoredPoint
  public boolean isEqual(ColoredPoint p) {
    System.out.print("ColoredPoint.isEqual(ColoredPoint) -- ");
    return p.x == x && p.y == y && p.color == color;
  }

  // Overriding over Point
  public double dist(Point p) {
    System.out.print("ColoredPoint.dist(Point) -- ");
    return Math.sqrt(Math.pow(x - p.x, 2) + Math.pow(y - p.y, 2) + Math.pow(color, 2));
  }

  // Overloading within ColoredPoint
  public double dist(ColoredPoint p) {
    System.out.print("ColoredPoint.dist(ColoredPoint) -- ");
    return Math.sqrt(Math.pow(x - p.x, 2) + Math.pow(y - p.y, 2) + Math.pow(color - p.color, 2));
  }
}


class Test {
  public static void main (String[] args) throws IOException{
    /* Discuss:
     * --------
     * 1. Why only the following combinations are interesting?
     *    Why not try a.isEqual(q), for example?
     *    Do we test for `similar` behaviour already?
     *
     * 2. In the output, why does "eq(a,b) => " appear after "Point.isEqual(Point)"?
     *
     * 3. Overloading vs Overriding
     */

    Point a = new Point();
    a.x = 1; a.y = 2;

    Point b = new Point();
    b.x = 1; b.y = 2;

    ColoredPoint p = new ColoredPoint();
    p.x = 1; p.y = 2; p.color = 3;

    ColoredPoint q = new ColoredPoint();
    q.x = 1; q.y = 2; q.color = 4;

    Point r = p;
    Point s = q;

    System.out.println("\n\n\nEQUALITY");
    System.in.read(); System.out.println("eq(a,b) => " + a.isEqual(b));
    System.in.read(); System.out.println("eq(a,p) => " + a.isEqual(p));
    System.in.read(); System.out.println("eq(a,r) => " + a.isEqual(r));

    System.in.read(); System.out.println("eq(p,a) => " + p.isEqual(a));
    System.in.read(); System.out.println("eq(p,q) => " + p.isEqual(q));
    System.in.read(); System.out.println("eq(p,r) => " + p.isEqual(r));

    System.in.read(); System.out.println("eq(r,a) => " + r.isEqual(a));
    System.in.read(); System.out.println("eq(r,p) => " + r.isEqual(p));
    System.in.read(); System.out.println("eq(r,s) => " + r.isEqual(s));

    System.out.println("\n\n\nDISTANCE");
    System.in.read(); System.out.println("dist(a,b) => " + a.dist(b));
    System.in.read(); System.out.println("dist(a,p) => " + a.dist(p));
    System.in.read(); System.out.println("dist(a,r) => " + a.dist(r));

    System.in.read(); System.out.println("dist(p,a) => " + p.dist(a));
    System.in.read(); System.out.println("dist(p,q) => " + p.dist(q));
    System.in.read(); System.out.println("dist(p,r) => " + p.dist(r));

    System.in.read(); System.out.println("dist(r,a) => " + r.dist(a));
    System.in.read(); System.out.println("dist(r,p) => " + r.dist(p));
    System.in.read(); System.out.println("dist(r,s) => " + r.dist(s));

  }
}
