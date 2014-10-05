public class Camera {
  boolean zoom = false;
  float aspect;
  float cameraZ;
  float cameraY;
  float fov;
  int windowHeight;
  int windowWidth;
  
  /* Empty default constructor */
  public Camera(int windowHeight, int windowWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    aspect = float(windowWidth)/float(windowHeight);
    cameraY = windowHeight/2;
  }
  
  public void draw() {
    if (zoom) {
      zoom();
    } else {
      zoomOut();
    }
  }
  
  public void zoom() {
    fov = 340/float(windowWidth) * PI/2;
    cameraZ = cameraY / tan(fov / 2.0);
    perspective(fov, aspect, cameraZ/10.0, cameraZ * 10.0);
  }
  
  public void zoomOut() {
    perspective();
  }
}

