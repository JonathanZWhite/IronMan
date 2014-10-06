import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import com.getflourish.stt.*; 
import peasy.*; 
import controlP5.*; 
import java.util.Arrays; 
import java.util.regex.Pattern; 
import java.util.regex.PatternSyntaxException; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class IronMan extends PApplet {





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
public void setup() {
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
public void draw() {
  engine.draw();
  cam.beginHUD();
  controlPanel.init();
  cp5.draw();
  cam.endHUD();
}

public void transcribe (String utterance, float confidence) {
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
public class API {

  //Please put in your own api_key here. This page explains how you get one: http://dp.la/info/developers/codex/policies/#get-a-key
  private String apikey = "18f315831ca298197d88df3e858abab6";
  private String locations = "";
  private String searchQuery;
  private String searchFilter;
  private int numPages;
  private JSONArray sourceResource;

  /* Constructor */
  public API(int numPages) {
    this.numPages = numPages;
    searchFilter = "sourceResource.collection=";
    sourceResource = new JSONArray();
  }
  
  /* Search */
  public JSONArray search(String searchQuery) {
    this.searchQuery = searchQuery;
    String queryURL = "";
    JSONObject dplaData;
    JSONArray results;
    
    int[] analyzedData = new int[2];

    //Modify search query here. You will need to string query parameters together to get the JSON file you want.
    queryURL = "http://api.dp.la/v2/items?" + searchFilter + searchQuery + "&api_key=" + apikey + "&page_size=" + numPages;

    println("Search: " + queryURL);
    dplaData = loadJSONObject(queryURL);
    results = dplaData.getJSONArray("docs");  

    for (int i = 0; i < results.size(); i++) {
      JSONObject result = results.getJSONObject(i);
      
      sourceResource.append(result.getJSONObject("sourceResource"));
    }

    return sourceResource;
  }
  
//  public String getTitles() {
//    ArrayList<String> titles = new ArrayList<String>();
//    int size = sourceResource.size();
//    for (int i = 0; i < size; i++) {
//      titles.add(sourceResource.getJSONObject(i).getString("title"));
//    }
//    
//    return titles.toString().replaceAll(",", ",").replaceAll("[\\[.\\].\\s+]", "");
//  }
  public String getLocations() {
    locations = "";
    int size = sourceResource.size();
    for (int i = 0; i < size; i++) {
        try {
          String location = sourceResource.getJSONObject(i).getJSONArray("spatial").getJSONObject(0).getString("name");
          if(!locations.toLowerCase().contains(location.toLowerCase())) {
            locations += location + ", ";
          }
        } catch(Exception e) {
          println("No spatial data");
        }
    }
    
    return locations;
  }
}

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
    int red = color(229, 77, 80);
    int orange = color(234, 211, 186);
    int white = color(255, 255, 255);
    
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
 

public class Engine {
  boolean rotate = true;
  boolean clear = false;
  int jarvisBall;
  float theta = 0;
  int apiSize;
  int metaDataSize;
  int masterRadius;
  int nodeSize = 10;
  int windowHeight;
  int windowWidth;
  JSONArray apiResults;
  Camera camera;
  
  Node[][] nodes;

  /* Constructor */
  public Engine(int windowHeight, int windowWidth, Camera camera, JSONArray apiResults) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.camera = camera;
    this.apiResults = apiResults;
    jarvisBall = color(234, 211, 186);
    
    initNodes();
  }
  
  /* Initializes node based on data */
  public void initNodes() {
    apiSize = apiResults.size();
    nodes = new Node[apiSize][apiSize];  
   
    masterRadius = windowHeight - 50;
    for (int i = 0; i < apiSize; i++) {
      for (int j = 0; j < apiSize; j++) {
        float cx = cos(i) * sin(j) * masterRadius/2;
        float cy = cos(j) * masterRadius /2;
        float cz = sin(i) * sin(j) * masterRadius/2;
        PVector position = new PVector(cx, cy, cz);
        metaDataSize = apiResults.getJSONObject(i).size();
        nodes[i][j] = new ParentNode(position, metaDataSize);
      }
    }
  }
  
  /* Updates data model with api results */
  public void updateModel(JSONArray apiResults) {
    this.apiResults = apiResults;
    initNodes();
  }

  /* Visualization */
  public void draw() {
    background(0);
    smooth();
    lights();

    translate(windowWidth/2, windowHeight/2, 0); // Centers vis
    noFill();
    pushMatrix();
    stroke(jarvisBall);
    rotateY(radians(frameCount));
    sphere(windowHeight/15);
    popMatrix();

    // Allows for resetting
    if (nodes[0][0] != null) {
      for (int i = 0; i < apiSize; i++) {
        for (int j = 0; j < apiSize; j++) {
          if (rotate) {
            nodes[i][j].rotate = true; 
          }
          nodes[i][j].update();
        }
      }
    }
  }
  
  public void updateColor(int jarvisBall) {
    this.jarvisBall = jarvisBall;
  }
  
  /* Starts rotating matrix */
  public void initRotate() {
    rotate = true;
  }
}



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
  public void transcribe(String utterance) {
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
abstract class Node {
  boolean rotate = false;
  int nodeColor;
  int strokeWeight;
  PVector position;
    
  public abstract void update();
    
  public void animate() {
      if (rotate) {
        rotateX(radians(frameCount/2));
        rotateY(radians(frameCount/2));
        rotateZ(radians(frameCount/2));
      }
      
      noFill();
      stroke(nodeColor);
      strokeWeight(strokeWeight);
      point(position.x, position.y, position.z);
  }
}

public class ParentNode extends Node {
  Node[] children;

  /* Constructor */
  public ParentNode(PVector position, int childCount) {
    nodeColor = color(78, 141, 234);
    strokeWeight = 10;
    this.position = position;
    
    children = new Node[childCount];
    for (int i = 0; i < children.length; i++) {
      children[i] = new ChildNode(position);
    }
  }

  /* Draw */
  public void update() {
    sphereDetail(20, 20);
    
    pushMatrix();
    animate();
    popMatrix();
    
    for (int i = 0; i < children.length; i++) {
      if (rotate) {
        children[i].rotate = true;
      }
      children[i].update();
    }
  }
}

public class ChildNode extends Node {
  float theta = random(-1, 1);
  float increment = random(0, 0.05f);
  PVector parentPosition;

  public ChildNode(PVector position) {
    nodeColor = color(78, 209, 78, 100);
    strokeWeight = 5;
    parentPosition = position;
  }

  public void update() {
    float distanceFromParent = width * 0.03f;
    float posX = distanceFromParent * cos(theta) * sin(theta) * 1/2 + parentPosition.x;
    float posY = distanceFromParent * cos(theta) * 1/2  + parentPosition.y;
    float posZ = distanceFromParent * sin(theta) * sin(theta) * 1/2 + parentPosition.z;
    
    position = new PVector(posX, posY, posZ);
    pushMatrix();
    animate();
    strokeWeight(.5f);
    stroke(255, 255, 255);
    line(posX, posY, posZ, parentPosition.x, parentPosition.y, parentPosition.z);    
    popMatrix();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "IronMan" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
