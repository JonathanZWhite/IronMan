public class Camera {
  PeasyCam cam;
  
  /* Empty default constructor */
  public Camera(PeasyCam cam) {
    this.cam = cam;
  }

  public void zoom() {
    cam.setDistance(300);
  }
  
  public void zoomOut() {
    cam.setDistance(1000);
  }
}

