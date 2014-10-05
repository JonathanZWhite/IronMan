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

  Node[] nodes = new Node[20];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    masterRadius = windowHeight - 50;
//    float r = sqrt(windowWidth/2 + windowHeight/2 + 0);
    float r = masterRadius/2;
    float theta = acos(0/(r));
    float azimuth = atan((windowHeight/2)/(windowWidth/2));
    

    // Fills node array
    for (int i = 0; i < nodes.length; i++) {
      // Psuedo: width of sphere/data points

      float x = r*sin(theta)*cos(azimuth);
      float y = r*sin(theta)*sin(azimuth);
      float z = r*cos(theta);

//      float x = random(0, windowWidth);
//      float y = random(windowHeight);
//      float z = random(-1000, 0);
//      float x = masterRadius/2 * cos(theta);
//      float y = masterRadius/2 * sin(theta);
//      float z = masterRadius/2 * cos(theta);
      theta += 1;


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
    scale(zoom);
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
  
  public void keyPressedEvent() {
    println("Key pressed");
    zoom -= .05; 
  }
}

