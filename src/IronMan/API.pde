
import java.io.InputStream;
import java.io.IOException;

public class API {

  //Please put in your own api_key here. This page explains how you get one: http://dp.la/info/developers/codex/policies/#get-a-key
  private String apikey = "18f315831ca298197d88df3e858abab6";

  private String searchQuery;
  private String searchFilter;
  private int numPages;
  Engine engine;

  /* Constructor */
  public API(Engine engine, int numPages) {
    this.engine = engine;
    this.numPages = numPages;
    searchFilter = "sourceResource.collection=";
  }
  
  /* Search */
  public void search(String searchQuery) {
    this.searchQuery = searchQuery;
    String queryURL = "";
    JSONObject dplaData;
    JSONArray results;

    //Modify search query here. You will need to string query parameters together to get the JSON file you want.
    queryURL = "http://api.dp.la/v2/items?" + searchFilter + searchQuery + "&api_key=" + apikey + "&page_size=" + numPages;

    println("Search: " + queryURL);

    dplaData = loadJSONObject(queryURL);
    results = dplaData.getJSONArray("docs");  

    engine.updateModel(results);
  }
}
