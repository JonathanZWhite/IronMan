public class ControlPanel {
  String query;
  API api;
  ControlP5 cp5;
  JSONArray apiResults;
  String locations;
  int numberOfCollections = 1;
  
  public ControlPanel(ControlP5 cp5, String query, API api, JSONArray apiResults) {
    this.cp5 = cp5;
    this.query = query;
    this.api = api;
    this.apiResults = apiResults;
    locations = api.getLocations();
    init();
  }
  
  public void init() {
    int leftElementX = 30; // margin-left: 30
    int leftElementXWidth = 250;
    int rightElementXWidth = 250;
    int rightElementX = width - 30;
    color red = color(229, 77, 80);
    color orange = color(234, 211, 186);
    color white = color(255, 255, 255);
    
    /* Left HUD */ 
    textAlign(LEFT);
    
    textSize(32);
    fill(orange);
    text("Jarvis", leftElementX, 60);
    
    textSize(16);
    fill(white);
    String jarvisCaption = "Hello sir. Press \"j\" and say \"Jarvis\" followed by your command";
    text(jarvisCaption, leftElementX, 80, leftElementX + leftElementXWidth, 120);
    
    textSize(18);
    fill(red);
    text("Available commands", leftElementX, 180);
    
    textSize(16);
    fill(white);
    text("- Jarvis search _______", leftElementX, 210);
    text("- Jarvis zoom in", leftElementX, 235);
    text("- Jarvis zoom out", leftElementX, 260);
    
    textSize(18);
    fill(red);
    text("API information", leftElementX, 300);
    
    textSize(16);
    fill(white);
    text("Current search: " + query, leftElementX, 330);
    text("Number of API results: " +  apiResults.size(), leftElementX, 355);
    text("Number of collections added: " +  numberOfCollections, leftElementX, 380);
    text("Number of parent nodes: " +  apiResults.size() * 5, leftElementX, 405);
    text("Number of child nodes: " +  apiResults.size() * 5 * 10, leftElementX, 430);
    String locationText = "Unique location of results: " + locations;
    text(locationText, leftElementX, 440, leftElementXWidth, 150);
        
    /* Right HUD */
    textAlign(RIGHT);
        
    textSize(18);
    fill(red);
    text("Sir, incoming transmission", rightElementX, 60);
    
    textSize(16);
    fill(white);
    String transmissionText = "This is a visual representation of the JSON response from the Digital Public Library in a spherical coordinate system. Each parent node represents a single resource from the one of the added collections and each parent node has as many child nodes as the amount of metadata that resource holds.";
    text(transmissionText, rightElementX, 90, -rightElementXWidth, 300);
  }
  
  public void updateQuery(String query) {
    this.query = query;
    locations = api.getLocations();
    numberOfCollections++;
  }
}
