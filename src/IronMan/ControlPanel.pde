public class ControlPanel {
  String query;
  ControlP5 cp5;
  
  public ControlPanel(ControlP5 cp5, String query) {
    this.cp5 = cp5;
    this.query = query;
    init();
  }
  
  public void init() {
    int leftElementX = 30; // margin-left: 60
    int leftElementXWidth = 250;
    color red = color(234, 211, 186);
    color orange = color(229, 77, 80);
    color white = color(255, 255, 255);
    
    textSize(32);
    fill(red);
    text("Jarvis", leftElementX, 60);
    
    textSize(16);
    fill(white);
    String jarvisCaption = "Hello sir. Press \"j\" and say \"Jarvis\" followed by your command";
    text(jarvisCaption, leftElementX, 80, leftElementX + leftElementXWidth, 120);
    
    textSize(18);
    fill(orange);
    text("Available commands", leftElementX, 180);
    
    textSize(16);
    fill(white);
    text("- Jarvis search _______", leftElementX, 210);
    text("- Jarvis zoom in", leftElementX, 235);
    text("- Jarvis zoom out", leftElementX, 260);
    
    textSize(18);
    fill(229, 77, 80);
    text("Sir, incoming transmission", leftElementX, 300);
    
    textSize(16);
    fill(white);
    text("Current search: " + query, leftElementX, 330);
  }
  
  public void updateQuery(String query) {
    this.query = query;
  }
}
