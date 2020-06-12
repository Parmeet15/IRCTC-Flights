
package Vmm;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class GetResponseFromUrl {

    public static String apikey="om6gf28b6p";
     public static String AppId="30783d67";
      public static String AppKey="b6978f1a3295e7250bc43e1d9ae9d767";
       public static String getResponse(String url) {
               
        try {
            HttpURLConnection urlconn = (HttpURLConnection)new URL (url).openConnection();
            BufferedReader br= new BufferedReader(new InputStreamReader(urlconn.getInputStream()));
            
            StringBuffer sb = new StringBuffer();
            
            while(true){
                String line=br.readLine();
                if(line== null){
                    break;
                }
                sb.append(line);
                        
            }
            return sb.toString();
            
        }
        catch(Exception ex)
        {
            return "Error"+ex.getMessage();
        }
       }
  public static void main (String[]args){
           String response= getResponse("https://api.railwayapi.com/v2/live/train/12555/date/09-05-2018/apikey/om6gf28b6p/");
                   System.out.println(response);
       }

}
