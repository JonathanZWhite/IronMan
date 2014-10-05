public class Engine {
  float theta = 0;
  int masterRadius;
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;
  JSONArray apiResults;
  PMatrix3D camera;
  
  float zoom = 1;

  PVector O = new PVector();

//  Node[] nodes = new Node[20];
  Node[][] nodes = new Node[20][20];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    masterRadius = windowHeight - 50;

//    float r = masterRadius/2;
//    float theta = acos(0/(r));
//    float phi = atan((windowHeight/2)/(windowWidth/2));
//    
//
//    for (int i = 0; i < nodes.length; i++) {
//      
//      float x = r*sin(theta)*cos(phi);
//      float y = r*sin(theta)*sin(phi);
//      float z = r*cos(theta);
//
//      theta += 1;
//
//
//      PVector position = new PVector(x, y, z);
//      
//      nodes[i] = new ParentNode(position, 0); // Adds new node
//    }
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        float cx = cos(i) * sin(j)*masterRadius;
        float cy = cos(j)*masterRadius;
        float cz = sin(i) * sin(j)*masterRadius;
        PVector position = new PVector(cx, cy, cz);
        nodes[i][j] = new ParentNode(position, 0);
      }
    }
  }
  
  /* Updates data model with api results */
  public void updateModel(JSONArray apiResults) {
    this.apiResults = apiResults;
  }

  /* Visualization */
  public void draw() {
    scale(zoom);
    background(0);
    smooth();
    lights();

    translate(windowWidth/2, windowHeight/2, 0);
    noFill();
    // stroke(155, 89, 182);
    noStroke();

    rotateY(radians( frameCount ));
    rotateZ(radians( frameCount ));
    sphere(windowHeight/2);
//
//    for (int i = 0; i < nodes.length; i++) {
//      nodes[i].update();
//    }
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        nodes[i][j].update();
      }
    }
  }
  
  public void keyPressedEvent() {
    println("Key pressed");
    zoom -= .05; 
  }
}

