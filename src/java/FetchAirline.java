
import Vmm.RDBMS_TO_JSON;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FetchAirline extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String sa = request.getParameter("sa");
        System.out.println(sa);
        String generateJSON = new RDBMS_TO_JSON().generateJSON("select * from airlines where name like '" + sa + "%'");
        out.println(generateJSON);
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            System.out.println("driver loaded successfully");
//            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/irctcdb", "root", "system");
//            System.out.println("connection created successfully");
//            Statement stmt = conn.createStatement();
//            System.out.println("statement created successfully");
//            ResultSet rs = stmt.executeQuery("select * from airlines where name like '%%'");
//            System.out.println("resultset created");
//
//            while (rs.next()) {
//
//                String name = rs.getString("name");
//
//                out.println("<tr>");
//
//                out.println("<td>" + name + "</td>");
//
//                out.println("</tr>");
//            }
//
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
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
