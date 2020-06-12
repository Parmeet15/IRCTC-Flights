

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class SeatAvailable extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        System.out.println("request");
        String dt = request.getParameter("dt");
        String trainname = request.getParameter("trainname");
        String sstation = request.getParameter("sstation");
        String dstation = request.getParameter("dstation");
        String classcode = request.getParameter("classcode");
        String quotacode = request.getParameter("quotacode");
        PrintWriter out = response.getWriter();
        try {
            String url="https://api.railwayapi.com/v2/check-seat/train/"+trainname+"/source/"+sstation+"/dest/"+dstation+"/date/"+
                    dt+"/pref/"+classcode+"/quota/"+quotacode+"/apikey/"+Vmm.GetResponseFromUrl.apikey+"/";
                  System.out.println(url);
             String response1 = Vmm.GetResponseFromUrl.getResponse(url);
            out.println(response1);  

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
