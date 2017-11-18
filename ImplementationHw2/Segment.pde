/*---------------------------------------------------------------------------------------------
 * Author:  Kyle Block
 *          Carl Johnson
 * 
 * Description: Segment represents a horizontal segment on an x/y axis
 *
 *-------------------------------------------------------------------------------------------*/


public class Segment {
  public int x1, x2, y;
  private boolean highlighted;

  public Segment(int x1, int x2, int y) {
    if (x1 <= x2) {
      this.x1 = x1;
      this.x2 = x2;
    }
    else {
      this.x1 = x2;
      this.x2 = x1;
    }
    this.y = y;
  }

  // Draws a line representing this segment
  public void drawMe() {
    stroke(256, 256, 256);
    if (isHighlighted())
      strokeWeight(3);
    else
      strokeWeight(1);
    line(x1, y, x2, y);
  }

  // Sets highlighted
  public void setHighlighted(boolean enabled) {
    this.highlighted = enabled;
  }

  // Returns true if segment is highlighted,
  // otherwise false
  public boolean isHighlighted() {
    return highlighted;
  }
}