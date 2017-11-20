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
  public void drawMe() {
    region.drawMe();
    if (isLeaf()) {
      for (int i = 0; i < size; i++) {
        segmentsList[i].drawMe();
      }
    }
  }
}