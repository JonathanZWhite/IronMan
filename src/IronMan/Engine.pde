public class Engine {
  boolean rotate = true;
  float theta = 0;
  int masterRadius;
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;
  JSONArray apiResults;
  Camera camera;
  
  Node[][] nodes = new Node[20][20];

  /* Constructor */
  public Engine(int windowHeight, int windowWidth, Camera camera) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.camera = camera;
   
    masterRadius = windowHeight - 50;
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        float cx = cos(i) * sin(j) * masterRadius/2;
        float cy = cos(j) * masterRadius /2;
        float cz = sin(i) * sin(j) * masterRadius/2;
        PVector position = new PVector(cx, cy, cz);
        nodes[i][j] = new ParentNode(position, 5);
      }
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

    translate(windowWidth/2, windowHeight/2, 0); // Centers vis
    noFill(); // Hides container
    noStroke(); // Hides container

    sphere(windowHeight/2);

    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        if (rotate) {
          nodes[i][j].rotate = true; 
        }
        nodes[i][j].update();
      }
    }
  }
  
  /* Starts rotating matrix */
  public void initRotate() {
    rotate = true;
  }
  
  /* Sets zoom */
  public void zoom(boolean zoom) {
    if (zoom) {
      camera.zoom = true;
    } else {
      camera.zoom = false;
    }
  }
}
