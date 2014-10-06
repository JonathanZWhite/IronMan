import com.getflourish.stt.*;

int windowHeight;
int windowWidth;
JSONArray apiResults;
String GOOGLE_API_KEY="AIzaSyBrDtQSiaUsrdJJTktixKc364AL-DKAf4k";



API api;
Camera camera;
Engine engine;
Jarvis jarvis;
STT stt;

/* Bootstrap */
void setup() {
  windowHeight = displayHeight;
  windowWidth = displayWidth;
  size(windowWidth, windowHeight, P3D);
  
  camera = new Camera(windowHeight, windowWidth);
 
  stt = new STT(this, GOOGLE_API_KEY);
  stt.enableDebug();
  stt.setLanguage("en");
  
  engine = new Engine(windowHeight, windowWidth, camera);
  api = new API(engine, 10);
  api.search("Georgia"); // Default search
  jarvis = new Jarvis(stt, api);
  
}

/* Visualization */
void draw() {
  engine.draw();
  camera.draw();
}

void transcribe (String utterance, float confidence) {
  jarvis.transcribe(utterance);
}

public void keyPressed () {
//  jarvis.keyPressedEvent();
  engine.zoom(true);
}
public void keyReleased () {
//  jarvis.keyReleasedEvent();
  engine.zoom(false);
}
