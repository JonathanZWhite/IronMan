import com.getflourish.stt.*;
import peasy.*;
import controlP5.*;

int windowHeight;
int windowWidth;
JSONArray apiResults;
String GOOGLE_API_KEY="AIzaSyBrDtQSiaUsrdJJTktixKc364AL-DKAf4k";
String defaultQuery = "dog";

API api;
Camera camera;
ControlP5 cp5;
ControlPanel controlPanel;
Engine engine;
Jarvis jarvis;
PeasyCam cam;
STT stt;

/* Bootstrap */
void setup() {
  windowHeight = displayHeight;
  windowWidth = displayWidth;
  size(windowWidth, windowHeight, P3D);
  
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  
  cam = new PeasyCam(this, 100);
  cam.lookAt(windowWidth/2, windowHeight/2, 100, 1000, 0);
  camera = new Camera(cam);
  
  stt = new STT(this, GOOGLE_API_KEY);
  stt.enableDebug();
  stt.setLanguage("en");
  
  api = new API(12); // Amount computer can handle processing graphically
  apiResults = api.search(defaultQuery); // Default search
  engine = new Engine(windowHeight, windowWidth, camera, apiResults);
  controlPanel = new ControlPanel(cp5, defaultQuery, api, apiResults);
  jarvis = new Jarvis(stt, api, controlPanel, camera);
  
}

/* Visualization */
void draw() {
  engine.draw();
  cam.beginHUD();
  controlPanel.init();
  cp5.draw();
  cam.endHUD();
}

void transcribe (String utterance, float confidence) {
  jarvis.transcribe(utterance);
}

public void keyPressed () {
  if (key == 'j' || key == 'J') {
    jarvis.keyPressedEvent();
    engine.updateColor(color(229, 77, 80));
  }
}
public void keyReleased () {
  if (key == 'j' || key == 'J') {    
    jarvis.keyReleasedEvent();
    engine.updateColor(color(234, 211, 186));
  }
}
