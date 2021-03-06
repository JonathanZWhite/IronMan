import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

public class Jarvis {
  API api;
  ControlPanel controlPanel;
  STT stt;
  Camera camera;
  String results; 
  
  /* Constructor */
  public Jarvis(STT stt, API api, ControlPanel controlPanel, Camera camera) {
    this.stt = stt;
    this.api = api;
    this.controlPanel = controlPanel;
    this.camera = camera;
    results = "Make a request!";
  }
  
  public void keyPressedEvent() {
    // TODO: Create grey box in lower right hand corner with instructions and messages from jarvis
    // TODO: Create cool HUD for jarvis
    stt.begin();
  }
  
  public void keyReleasedEvent() {
    stt.end();
  }
  
  /* Voice to text */
  void transcribe(String utterance) {
    String[] splitResults;
    results = utterance;    
    // Checks if Jarvis is being called
    if (!results.toLowerCase().contains("jarvis")) {
      return;
    } 
    
    splitResults = split(results);
    // Search
    if (results.toLowerCase().contains("search")) {
      if (splitResults[2] != null) {
        controlPanel.updateQuery(splitResults[2]);
        JSONArray apiResults = api.search(splitResults[2]);
        engine.updateModel(apiResults);
      } else {
        api.search("Dog"); // Fallback
      };
     
    // Rotate
    } else if (results.toLowerCase().contains("rotate")) {
      engine.initRotate();
    
    // Zoom 
    } else if (results.toLowerCase().contains("zoom")) {
      if (results.toLowerCase().contains("in")) {
        camera.zoom();
      } else if (results.toLowerCase().contains("out")) {
        camera.zoomOut();
      }
    }
  }
  
  private String[] split(String toSplit) {
    try {
        String[] splitResults = toSplit.split("\\s+");
        return splitResults;
    } catch (PatternSyntaxException ex) {
        println("Could not parse search string");
        return null;
    }
  }
}
