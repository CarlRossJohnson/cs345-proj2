/*---------------------------------------------------------------------------------------------
 * Author:  Kyle Block
 *          Carl Johnson
 * 
 * Description: Region represents a rectangular region an x/y axis
 *
 *-------------------------------------------------------------------------------------------*/


public class Region {

  public Point p1, p2;
  private boolean highlighted;

  // Constructor: Standardizes p1 and p2 
  // positions relative to each other
  public Region(int x1, int y1, int x2, int y2) {
    highlighted = false;
    if (x1 < x2) {
      if (y1 < y2) {
        // Case: (x1, y1) and (x2, y2) are
        // upper-left and lower-right, respectively
        this.p1 = new Point(x1, y1);
        this.p2 = new Point(x2, y2);
      }
      else {
        // Case: (x1, y1) and (x2, y2) are
        // lower-left and upper-right, respectively
        this.p1 = new Point(x1, y2);
        this.p2 = new Point(x2, y1);
      }
    }
    else {
      if (y1 > y2) {
        // Case: (x1, y1) and (x2, y2) are
        // lower-right and upper-left, respectively
        this.p1 = new Point(x2, y2);
        this.p2 = new Point(x1, y1);
      }
      else {
        // Case: (x1, y1) and (x2, y2) are
        // upper-right and lower-left, respectively
        this.p1 = new Point(x2, y1);
        this.p2 = new Point(x1, y2);
      }
    }
  }

  // Returns true if region contains point (x,y),
  // otherwise false
  public boolean contains(int x, int y) {
    return  x >= p1.x && 
            x <= p2.x &&
            y >= p1.y && 
             y <= p2.y;
  }

  // Returns true if region contains segment s,
  // otherwise false
  public boolean contains(Segment s) {
    return  contains(s.x1, s.y) && 
            contains(s.x2, s.y);
  }

  // Returns true if region contains region r,
  // otherwise false
  public boolean contains(Region r) {
    return  contains(r.p1.x, r.p1.y) && 
            contains(r.p2.x, r.p2.y);
  }

  // Returns true if region overlaps segment s,
  // otherwise false
  public boolean overlaps(Segment s) {
    return   contains(s.x1, s.y) || 
             contains(s.x2, s.y) ||
             (s.y >= p1.y && 
              s.y <= p2.y &&
              s.x1 < p1.x && 
              s.x2 > p2.x);
  }

  // Returns true if region overlaps region r,
  // otherwise false
  public boolean overlaps(Region r) {
    return  contains(r.p1.x, r.p1.y) || 
            contains(r.p2.x, r.p2.y) ||
            contains(r.p1.x, r.p2.y) ||
            contains(r.p2.x, r.p1.y) ||
            r.contains(p1.x, p1.y) || 
            r.contains(p2.x, p2.y) ||
            r.contains(p1.x, p2.y) ||
            r.contains(p2.x, p1.y);
  }
  
  // Draws a rectangle representing this region
  public void drawMe() {
    if (isHighlighted())
      strokeWeight(3);
    else
      strokeWeight(1);
    stroke(192, 192, 0);
    noFill();
    rect(p1.x, p1.y, p2.x - p1.x, p2.y - p1.y);
  }
  
  // Sets highlighted
  public void setHighlighted(boolean enabled) {
    this.highlighted = enabled;
  }

  // Returns true if region is highlighted,
  // otherwise false
  public boolean isHighlighted() {
    return highlighted;
  }
}