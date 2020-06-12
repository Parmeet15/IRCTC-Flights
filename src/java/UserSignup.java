
import Vmm.DBLoader;
import Vmm2.FileUploader;
import com.mysql.jdbc.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class UserSignup extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            String secq = request.getParameter("sec-ques");
            String seca = request.getParameter("sec-ans");
            String number = request.getParameter("number");
            String uname = request.getParameter("uname");
            Part part = request.getPart("f1");
            ResultSet rs = DBLoader.executeQuery("select * from usertable where email='" + email + "'");
            if (rs.next()) {
                out.println("fail");
            } else {
                String absolutepath = request.getServletContext().getRealPath("/pics");
                String filename = FileUploader.savefileonserver(part, absolutepath);
                rs.moveToInsertRow();
                rs.updateString("email", email);
                rs.updateString("password", pass);

                rs.updateString("sec-ques", secq);
                rs.updateString("sec-ans", seca);
                rs.updateString("contact", number);
                rs.updateString("username", uname);
                rs.updateString("photo", "./pics/" + filename);
                rs.insertRow();
                out.println("success");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UserSignup.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UserSignup.class.getName()).log(Level.SEVERE, null, ex);
        }
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
