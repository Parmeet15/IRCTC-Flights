
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CodeToStationName extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
         String sn=request.getParameter("sn");
            try
        {
           
           String url= "https://api.railwayapi.com/v2/code-to-name/code/"+sn+"/apikey/"+Vmm.GetResponseFromUrl.apikey+"/";
            System.out.println(url);
           String response1 = Vmm.GetResponseFromUrl.getResponse(url);
          out.println(response1);
         // out.println(FakeJSON.nametocode);
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    }

    
   
