public class Camera {
  boolean zoom = false;
  float aspect;
  float cameraZ;
  float cameraY;
  float fov;
  int windowHeight;
  int windowWidth;
  int zoomChange = 10;
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
  
  // TODO: Custom zoom values from Jarvis
  public void zoom() {
    fov = zoomFactor/float(windowWidth) * PI/2;
    cameraZ = cameraY / tan(fov / 2.0);
    perspective(fov, aspect, cameraZ/10.0, cameraZ * 10.0);
    
    if (zoomFactor > windowWidth * 0.2) { 
      zoomFactor -= zoomChange; 
    }
  }
  
  public void zoomOut() {
    fov = zoomFactor/float(windowWidth) * PI/2;
    cameraZ = cameraY / tan(fov / 2.0);    
    perspective(fov, aspect, cameraZ/10.0, cameraZ * 10.0);
    
    if (zoomFactor < windowWidth * 0.9) {
      zoomFactor += zoomChange;
    }
  }
}

