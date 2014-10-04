public class Engine {
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;

  PVector O = new PVector();

  Node[] nodes = new Node[100];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;

    // Fills node array
    for (int i = 0; i < nodes.length; i++) {
      color nodeColor = color(78, 141, 234);
      float x = random(0, windowWidth);
      float y = random(windowHeight);
      float z = random(-10000, 10000);
      nodes[i] = new Node(nodeColor, x, y, z); // Adds new node
    }
    System.out.println("A system was instantied");
  }

  /* Visualization */
  public void draw() {
    // Config
    background(0);
    lights();

    for (int i = 0; i < nodes.length; i++) {
      nodes[i].update();
    }
  }

  private class Node {
    //    PVector loc = new PVector(random(0, windowWidth), random(0, windowHeight), random(-300, -700));
    //    PVector speed = new PVector();
    color nodeColor;
    
    float x;
    float y;
    float z;

    /* Constructor */
    public Node(color nodeColor, float x, float y, float z) {
      this.nodeColor = nodeColor;
      this.x = x;
      this.y = y;
      this.z = z;
    }

    /* Draw */
    public void update() {
      pushMatrix();
      translate(x, y, z); // x, y, z
      
      rotateX( radians( frameCount ) );
      rotateY( radians( frameCount ) );
      rotateZ( radians( frameCount ) );
      
      noFill();
      stroke(nodeColor);
      sphere(150);
      popMatrix();

      System.out.println("updating...");
    }
  }
}

