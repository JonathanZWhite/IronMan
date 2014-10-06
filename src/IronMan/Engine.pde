public class Engine {
  boolean rotate = true;
  float theta = 0;
  int apiSize;
  int metaDataSize;
  int masterRadius;
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;
  JSONArray apiResults;
  Camera camera;
  
  Node[][] nodes;

  /* Constructor */
  public Engine(int windowHeight, int windowWidth, Camera camera, JSONArray apiResults) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.camera = camera;
    this.apiResults = apiResults;
    apiSize = apiResults.size();
    nodes = new Node[apiSize][apiSize];  
   
    masterRadius = windowHeight - 50;
    for (int i = 0; i < apiSize; i++) {
      for (int j = 0; j < apiSize; j++) {
        float cx = cos(i) * sin(j) * masterRadius/2;
        float cy = cos(j) * masterRadius /2;
        float cz = sin(i) * sin(j) * masterRadius/2;
        PVector position = new PVector(cx, cy, cz);
        metaDataSize = apiResults.getJSONObject(i).size();
        nodes[i][j] = new ParentNode(position, metaDataSize);
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

    for (int i = 0; i < apiSize; i++) {
      for (int j = 0; j < apiSize; j++) {
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
