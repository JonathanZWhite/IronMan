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

