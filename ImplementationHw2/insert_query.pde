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
    insert(s, v.children[0]);
    insert(s, v.children[1]);
    insert(s, v.children[2]);
    insert(s, v.children[3]);
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

  v.children[0] = new Node(v.region.p1.x, v.region.p1.y, midX, midY);

  v.children[1] = new Node(v.region.p1.x, midY + 1, midX, v.region.p2.y);

  v.children[2] = new Node(midX + 1, midY + 1, v.region.p2.x, v.region.p2.y);

  v.children[3] = new Node(midX + 1, v.region.p1.y, v.region.p2.x, midY);
  
  totalNodes += 4;

  for (int i = 0; i < v.segmentsList.length; i++) {
    insert(v.segmentsList[i], v.children[0]);
    insert(v.segmentsList[i], v.children[1]);
    insert(v.segmentsList[i], v.children[2]);
    insert(v.segmentsList[i], v.children[3]);
  }
}

//Spliting node for start screen
public void startSplit(Node v) {
  if (!v.isLeaf()) {
    startSplit(v.children[0]);
    startSplit(v.children[1]);
    startSplit(v.children[2]);
    startSplit(v.children[3]);
  }
  else {
    int midX = (v.region.p1.x + v.region.p2.x) / 2;
    int midY = (v.region.p1.y + v.region.p2.y) / 2;
  
    v.children[0] = new Node(v.region.p1.x, v.region.p1.y, midX, midY);
    v.children[1] = new Node(v.region.p1.x, midY + 1, midX, v.region.p2.y);
    v.children[2] = new Node(midX + 1, midY + 1, v.region.p2.x, v.region.p2.y);
    v.children[3] = new Node(midX + 1, v.region.p1.y, v.region.p2.x, midY);
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
    query(Q, v.children[0]);
    query(Q, v.children[1]);
    query(Q, v.children[2]);
    query(Q, v.children[3]);
  }
  else if (v.isLeaf()) {
    for (int i = 0; i < v.size; i++) {
      if (Q.overlaps(v.segmentsList[i]))
        v.segmentsList[i].setHighlighted(true);
    }
  }
  else {
    query(Q, v.children[0]);
    query(Q, v.children[1]);
    query(Q, v.children[2]);
    query(Q, v.children[3]);
  }
}