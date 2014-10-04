import controlP5.*;

Engine engine;

int windowHeight;
int windowWidth;
JSONArray results;

/* Bootstrap */
void setup() {
  windowHeight = displayHeight;
  windowWidth = displayWidth;
  
  size(windowWidth, windowHeight, P3D);
  
  engine = new Engine(windowHeight, windowWidth);
  
  results = loadData();
}

/* Visualization */
void draw() {
  engine.draw();
}

JSONArray loadData() {
  JSONArray results;
  
  SearchQuery search = new SearchQuery("Georgia", 200);
  results = search.search();
  
  return results;
}
