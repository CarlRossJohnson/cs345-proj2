/*---------------------------------------------------------------------------------------------
 * Author:  Kyle Block
 *          Carl Johnson
 * 
 * Description: A graphical program to display the 
 *
 *--------------------------------------------------------------------------------------------*/


final int SEGMENT_LIMIT = 3;

Node root = new Node(0, 0, 512, 512);
int numberOfSegments = 0;
int totalNodes = 1;
Region Q = null;

Button readFileButton;

String fileName = "Fresh Start";
String animationStatus = "";

boolean gettingInput;
boolean insertMode = false;
boolean reportMode = false;
boolean animation = false;



void setup() {
  size(512, 576);
  smooth();
  textSize(16);
  
  readFileButton = new Button("Read File", 8, 545, 100, 24);
  
} //END setup

void draw() {
  
  // Draw panels
  noStroke();
  smooth();
  fill(64, 64, 64);
  rect(0, 0, 511, 511);
  fill(0);
  rect(0, 512, 512, 64);
  
  textSize(14);
  
  updateStatusBar();
  
  text(fileName, 12, 520, width, height);
  
  readFileButton.drawButton(218, 218, 218);
  
  drawTree(root);
  
  if (Q != null) {
    Q.setHighlighted(true);
    stroke(0, 0, 256);
  }
  
} //END draw

// Draws Status Bar elements
void updateStatusBar() {
  fill(256, 256, 256);
  textAlign(LEFT, TOP);
  text("Number of Segments: " + numberOfSegments, 150, 540, width, height);
  text("Number of nodes: " + totalNodes, 150, 555, width, height);
  text("       Mode :  " + currMode(), 360, 540, width, height);
  text("Animation :  " + animationStatus(), 360, 555, width, height);
}

// Returns a string indicating animation status
String animationStatus() {
  if (animation)
    return"ON";
  else 
    return "OFF";
}

// Returns a string indicating current mode
String currMode() {
  if (insertMode) 
    return "Insert";
  if (reportMode)
    return "Report";
  return "-";
}

// Draws all regions and segments of our Quad Tree
void drawTree(Node v) {
  if (v == null)
      return;
      
  v.drawMe();
    
  drawTree(v.children[0]);
  drawTree(v.children[1]);
  drawTree(v.children[2]);
  drawTree(v.children[3]);
}

///////////////////////////////////////////////////////////
//         Model Methods
///////////////////////////////////////////////////////////


/*******************************************************************************
 * readFile()
 *
 * Description: Reads segment coordinates from the file and adds new segment
 *              objects to our segments list
 *******************************************************************************/
void readFile() {
  BufferedReader reader = null;
  try {
    reader = createReader(fileName);
  } 
  catch (Exception e) {
    e.printStackTrace();
    return;
  }
  String line;
  try {
    String[] coordinates;

    while ((line = reader.readLine()) != null) {
      coordinates = line.trim().split(",");
      if (coordinates.length < 3)
        continue;
      int x1 = Integer.parseInt(coordinates[0]); 
      int x2 = Integer.parseInt(coordinates[1]);
      int y = Integer.parseInt(coordinates[2]);
      insert(new Segment(x1, x2, y), root);
      numberOfSegments++;
    }
  }
  catch (Exception e) {
    javax.swing.JOptionPane.showMessageDialog(null, "File not found");
    fileName = "Fresh Start";
    return;
  }
}

/*******************************************************************************
 * clearHighlights()
 *
 * Description: Resets all nodes and segemnts to un-highlighted state
 *******************************************************************************/
void clearHighlights(Node v) {
  if (v == null)
    return;

  v.clearHighlighted();
  if (!v.isLeaf()) {
    clearHighlights(v.children[0]);
    clearHighlights(v.children[1]);
    clearHighlights(v.children[2]);
    clearHighlights(v.children[3]);
  }
}

///////////////////////////////////////////////////////////
//         Event Handling
///////////////////////////////////////////////////////////

/*******************************************************************************
 * keyPressed()
 *
 * Description: Listens for key presses 
 *******************************************************************************/
void keyPressed() {
  
  if (key == 'a') {
    animation = !animation;
  } else if (key == 'i') {
    if (!reportMode)
      insertMode = !insertMode;
    else 
      javax.swing.JOptionPane.showMessageDialog(null, "You must exit Report Mode first");
    
  } else if (key == 'r') {
    if (!insertMode)
      reportMode = !reportMode;
    else 
      javax.swing.JOptionPane.showMessageDialog(null, "You must exit Insert Mode first");
  }
}

/*******************************************************************************
 * mousePressed()
 *
 * Description: Listens for mouse presses 
 *******************************************************************************/
void mousePressed() {
    // user presses "Read File"
    if (readFileButton.mouseOver()) {
      fileName = javax.swing.JOptionPane.showInputDialog(null, "Enter input filename:");
      if (fileName != null) {
        readFile();
      } else 
          fileName = "Fresh Start";
    } else if (insertMode && root.region.contains(mouseX, mouseY)) {
      Segment segment = new Segment(mouseX, mouseX, mouseY);
      insert(segment, root);
      numberOfSegments++;
    }
}