import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

public class Jarvis {
  API api;
  STT stt;
  String results; 
  
  /* Constructor */
  public Jarvis(STT stt, API api) {
    this.stt = stt;
    this.api = api;
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
        api.search(splitResults[2]);
      } else {
        api.search("Dog"); // Fallback
      };
     
    // Rotate
    } else if (results.toLowerCase().contains("rotate")) {
      engine.initRotate();
    
    // Zoom 
    } else if (results.toLowerCase().contains("zoom")) {
      if (results.toLowerCase().contains("in")) {
        engine.zoom(true);
      } else if (results.toLowerCase().contains("out")) {
        engine.zoom(false);
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
