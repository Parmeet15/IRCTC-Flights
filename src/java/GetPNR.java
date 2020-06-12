

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetPNR extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
             System.out.println("request");
           String pnr=request.getParameter("pnr");
               
        try {
            
            String url= "https://api.railwayapi.com/v2/pnr-status/pnr/"+ pnr+"/apikey/" + Vmm.GetResponseFromUrl.apikey + "/";
           System.out.println(url);

       String response1 = Vmm.GetResponseFromUrl.getResponse(url);
          out.println(response1);
         //  out.println(FakeJSON.PNRstatus);

        } catch (Exception ex) {

            ex.printStackTrace();
        }
    }
 @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


}
