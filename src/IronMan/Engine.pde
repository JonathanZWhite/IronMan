public class Engine {
  int masterRadius;
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;

  PVector O = new PVector();

  Node[] nodes = new Node[20];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    masterRadius = windowHeight - 50;

    // Fills node array
    for (int i = 0; i < nodes.length; i++) {
      // TODO, cos of the larger sphere
//      float distanceFromParent = parentRadius + 0;
//      float posX = distanceFromParent * cos(theta) + parentPosition.x;
//      float posY = distanceFromParent * sin(theta) + parentPosition.y;
//      float posZ = distanceFromParent * cos(theta) + parentPosition.z;
      

      float x = random(0, windowWidth);
      float y = random(windowHeight);
      float z = random(-1000, 0);
//      float x = 150 * cos(0) + 400;
//      float y = 150 * sin(0) + 450;
//      float z = random(150 * cos(0), 2000);
      PVector position = new PVector(x, y, z);
      
      nodes[i] = new ParentNode(position, 1); // Adds new node
    }
    System.out.println("A system was instantiated");
  }

  /* Visualization */
  public void draw() {
    background(0);
    smooth();
    lights();

    for (int i = 0; i < nodes.length; i++) {
      nodes[i].update();
    }
  }
}

