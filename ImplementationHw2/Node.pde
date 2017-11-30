/*---------------------------------------------------------------------------------------------
 * Author:  Kyle Block
 *          Carl Johnson
 * 
 * Description: The Node class represents a single node in a Quad Tree,
 *              with a corresponding rectangular region.
 *              Each node has four references to children nodes 
 *              and can contain a limited number of horizontal segments.
 *
 *-------------------------------------------------------------------------------------------*/


public class Node {

  public Region region;
  public Segment[] segmentsList;
  private int size;
  private Node[] children;

  Node (int x1, int y1, int x2, int y2) {
    this.region = new Region(x1, y1, x2, y2);
    
    segmentsList = new Segment [SEGMENT_LIMIT + 1];
    size = 0;
    
    children = new Node[4];
    for (int i = 0; i < children.length; i++) {
      children[i] = null;
    }
  }
  
  // Adds a segment to the list of segments
  public void addSegment(Segment s) {
    if (size == segmentsList.length)
      return;
      
    segmentsList[size] = s;
    size++;
  }

  // Returns true if node is a leaf, otherwise false
  public boolean isLeaf() {
    return   children[0] == null &&
             children[1] == null && 
             children[2] == null && 
             children[3]== null;
  }
  
  // Clears the highlight from region and segments
  public void clearHighlighted() {
    region.setHighlighted(false);
    if (isLeaf()) {
      for (int i = 0; i < size; i++) {
        segmentsList[i].setHighlighted(false);
      }
    }
  }
  
  // Draws the region. 
  // If node if a leaf, also draws segments
  public void drawMe(boolean animate) {
    if (onStart)
      region.startScreenDrawMe();
    else
      region.drawMe(animate);
    if (isLeaf()) {
      for (int i = 0; i < size; i++) {
        segmentsList[i].drawMe();
      }
    }
  }
  
  
  //Checks itself for contained region, and its children
  //If the this node contains region, set highlight to true
  public void checkForHighlight(Segment s) {
    if (region.contains(s))
      region.setHighlighted(true);
    else
      return;
      
    if (!isLeaf()) {
      children[0].checkForHighlight(s);
      children[1].checkForHighlight(s);
      children[2].checkForHighlight(s);
      children[3].checkForHighlight(s);
    }
  }
  
  //Checks itself for contained region, and its children
  //If the this node contains region, set highlight to true
  //Also if any of the any segments are in the region, it sets their highlight to true
  public void checkForHighlight(Region r) {
    if (region.overlaps(r)) {
      if (animation)
        region.setHighlighted(true);
    }
    else
      return;
    
    if (!isLeaf()) {
      children[0].checkForHighlight(r);
      children[1].checkForHighlight(r);
      children[2].checkForHighlight(r);
      children[3].checkForHighlight(r);
    }
    else {
      for (int i = 0; i < size; i++) {
        if (r.overlaps(segmentsList[i])) {
          segmentsList[i].setHighlighted(true);
        }
      }
    }
  }
}