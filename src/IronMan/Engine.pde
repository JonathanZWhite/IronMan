public class Engine {
  int masterRadius;
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;
  JSONArray apiResults;
  PMatrix3D camera;

  PVector O = new PVector();

  Node[] nodes = new Node[20];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    masterRadius = windowHeight - 50;
    

    // Fills node array
    for (int i = 0; i < nodes.length; i++) {
      // Psuedo: width of sphere/data points

      float x = random(0, windowWidth);
      float y = random(windowHeight);
      float z = random(-1000, 0);
//      float x = 150 * cos(random(-1, 1)) + 720;
//      float y = 150 * sin(random(-1, 1)) + 450;
//      float z = random(150 * cos(random(-1, 1)), 2000);
      PVector position = new PVector(x, y, z);
      
      nodes[i] = new ParentNode(position, 0); // Adds new node
    }
  }
  
  /* Updates data model with api results */
  public void updateModel(JSONArray apiResults) {
    this.apiResults = apiResults;
  }

  /* Visualization */
  public void draw() {
    background(0);
    smooth();
    lights();

    translate(windowWidth/2, windowHeight/2, 0);
    noFill();
    stroke(155, 89, 182);

    rotateY(radians( frameCount ));
    sphere(windowHeight/2);

    for (int i = 0; i < nodes.length; i++) {
      nodes[i].update();
    }
  }
}

