/*---------------------------------------------------------------------------------------------
 * Author:  Kyle Block
 *          Carl Johnson
 * 
 * Description: Contains the following functions for our Quad Tree
 *              insert() 
 *              split() 
 *              query()
 *              
 *
 *-------------------------------------------------------------------------------------------*/

/*******************************************************************************
 * insert()
 *
 * Description: Inserts a segment into the subtree rooted at node v
 *******************************************************************************/
public void insert(Segment s, Node v) {
  if (v == null) {
    System.err.println("Node is null");
    return;
  }

  if (!v.region.overlaps(s))
    return;

  if (!v.isLeaf()) {
    insert(s, v.NW);
    insert(s, v.SW);
    insert(s, v.SE);
    insert(s, v.NE);
  }
  else {
    v.addSegment(s);
    // TODO: Highlight region temporarily
    if (v.size > SEGMENT_LIMIT && 
        v.region.p1.x < v.region.p2.x &&
        v.region.p1.y < v.region.p2.y) 
      split(v);
  } 
}

/*******************************************************************************
 * split()
 *
 * Description: Adds new node as children of node v 
 *              and inserts the overflowed segment of v 
 *              in the appropriate child node
 *******************************************************************************/
public void split(Node v) {
  int midX = (v.region.p1.x + v.region.p2.x) / 2;
  int midY = (v.region.p1.y + v.region.p2.y) / 2;

  v.NW = new Node(v.region.p1.x, v.region.p1.y, midX, midY);

  v.SW = new Node(v.region.p1.x, midY + 1, midX, v.region.p2.y);

  v.SE = new Node(midX + 1, midY + 1, v.region.p2.x, v.region.p2.y);

  v.NE = new Node(midX + 1, v.region.p1.y, v.region.p2.x, midY);
  
  totalNodes += 4;

  for (int i = 0; i < v.segmentsList.length; i++) {
    insert(v.segmentsList[i], v.NW);
    insert(v.segmentsList[i], v.SW);
    insert(v.segmentsList[i], v.SE);
    insert(v.segmentsList[i], v.NE);
  }
}

/*******************************************************************************
 * query()
 *
 * Description: For given region Q, sets all overlapping segments as highlighted
 *******************************************************************************/
void query(Region Q, Node v) {
  if (v == null || !v.region.overlaps(Q))
    return;

  if (Q.contains(v.region)) {
    query(Q, v.NW);
    query(Q, v.SW);
    query(Q, v.SE);
    query(Q, v.NE);
  }
  else if (v.isLeaf()) {
    for (int i = 0; i < v.size; i++) {
      if (Q.overlaps(v.segmentsList[i]))
        v.segmentsList[i].setHighlighted(true);
    }
  }
  else {
    query(Q, v.NW);
    query(Q, v.SW);
    query(Q, v.SE);
    query(Q, v.NE);
  }
}