
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TrainFare extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println("request");
        
        String tn = request.getParameter("tn");
        String st = request.getParameter("st");
        String det = request.getParameter("det");
        String ap = request.getParameter("ap");
        String dt = request.getParameter("dt");
        String cc = request.getParameter("cc");
        String qt = request.getParameter("qt");

        try {
           String url="https://api.railwayapi.com/v2/fare/train/"+tn+"/source/"+st+"/dest/"+det+"/age/"+ap+
                   "/pref/"+cc+"/quota/"+qt+"/date/"+dt+"/apikey/"+Vmm.GetResponseFromUrl.apikey+"/";
            System.out.println(url);
            String response1 = Vmm.GetResponseFromUrl.getResponse(url);
            out.println(response1);
//            out.println(FakeJSON.faretrain);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
