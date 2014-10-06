import java.util.Arrays; 

public class Engine {
  boolean rotate = true;
  boolean clear = false;
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
    
    initNodes();
  }
  
  public void initNodes() {
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
  
  public void clearNodes() {
    println("All nodes removed!");
  }
  
  /* Updates data model with api results */
  public void updateModel(JSONArray apiResults) {
    this.apiResults = apiResults;
    clearNodes();
    initNodes();
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

    // Allows for resetting
    if (nodes[0][0] != null) {
      for (int i = 0; i < apiSize; i++) {
        for (int j = 0; j < apiSize; j++) {
          if (rotate) {
            nodes[i][j].rotate = true; 
          }
          nodes[i][j].update();
        }
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
