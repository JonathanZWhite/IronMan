public class Engine {
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;

  PVector O = new PVector();

  Node[] nodes = new Node[1];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;

    // Fills node array
    for (int i = 0; i < nodes.length; i++) {
      float x = random(0, windowWidth);
      float y = random(windowHeight);
//      float z = random(-10000, 10000);
      float z = 100;
//      PVector position = new PVector(x, y, z);
      PVector position = new PVector(width/2, height/2, z);
      
      nodes[i] = new Node(position, 2, false); // Adds new node
    }
    System.out.println("A system was instantied");
  }

  /* Visualization */
  public void draw() {
    // Config
    background(0);
    smooth();
    lights();

    for (int i = 0; i < nodes.length; i++) {
      nodes[i].update();
    }
  }

  private class Node {
    boolean isChild;
    
    int parentRadius = 150;
    int childRadius = 150/10;
    
    color parentColor = color(78, 141, 234);
    color childColor = color(78, 141, 234);
    
    float theta = 0;
    Node[] children;
    PVector position;

    /* Constructor */
    public Node(PVector position, int childCount, boolean isChild) {
      this.position = position;
      this.isChild = isChild;
      
      if (!this.isChild) {
        float distanceFromParent = parentRadius + 70;
        float childX = distanceFromParent * cos(theta) + position.x;
        float childY = distanceFromParent * sin(theta) + position.y;
        float childZ = position.z;
        PVector childPosition = new PVector(childX, childY, childZ);
        
        children = new Node[childCount];
        for (int i = 0; i < children.length; i++) {
          children[i] = new Node(childPosition, 0, true);
        }        
      }
    }

    /* Draw */
    public void update() {
      // Children updates
      if (isChild) {
        for (int i = 0; i < children.length; i++) {
          children[i].update();
        }
      } else {
      
        // Parent update
        pushMatrix();
        translate(position.x, position.y, position.z); // x, y, z
  
        rotateX( radians( frameCount ) );
        rotateY( radians( frameCount ) );
        rotateZ( radians( frameCount ) );
        
        noFill();
        stroke(parentColor);
        sphere(parentRadius);
        popMatrix();
      }
      System.out.println("updating...");
    }
    
//    /* Creates child nodes */
//    public void updateChildren() {
//      // TODO: Export into recursive function which instantiates nodes
//      // TODO: Use some sin function to create orbit
//      // TODO: Orbit only children
//      float distanceFromParent = parentRadius + 70;
//      theta += .05;
//      float childX = distanceFromParent * cos(theta) + position.x;
//      float childY = distanceFromParent * sin(theta) + position.y;
//      float childZ = position.z;
//      
//      pushMatrix();
//      translate(childX, childY, childZ); // x, y, z
//  
//      noFill();
//      stroke(childColor);
//      sphere(childRadius);
//      popMatrix();
//    }
  }
}

