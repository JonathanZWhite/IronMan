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
      // float z = random(-10000, 10000);
      float z = 100;
      // PVector position = new PVector(x, y, z);
      PVector position = new PVector(width/2, height/2, z);
      
      nodes[i] = new ParentNode(position, 4); // Adds new node
    }
    System.out.println("A system was instantiated");
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
}

