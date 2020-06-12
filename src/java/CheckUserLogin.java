
import Vmm.DBLoader;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.console;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckUserLogin extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     * @throws Exception
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        try {

            ResultSet rs = DBLoader.executeQuery("select * from usertable where email='" + email
                    + "' AND password='" + pass + "'");
            if (rs.next()) {

                out.println("success");
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
            } else {
                out.println("fail");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
}
