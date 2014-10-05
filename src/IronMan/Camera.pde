public class Camera {
  boolean zoom = false;
  float aspect;
  float cameraZ;
  float cameraY;
  float fov;
  int windowHeight;
  int windowWidth;
  int zoomFactor = 1000;
  
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
    fov = zoomFactor/float(windowWidth) * PI/2;
    cameraZ = cameraY / tan(fov / 2.0);
    perspective(fov, aspect, cameraZ/10.0, cameraZ * 10.0);
    if (zoomFactor > 340) { 
      zoomFactor -= 10; 
    }
  }
  
  public void zoomOut() {
    perspective();
  }
}

