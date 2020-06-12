/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class APICheckLiveStatus extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println("request");

        String trainno = request.getParameter("trainno");
        String date = request.getParameter("date");
        try {
            String url;
            url = "https://api.railwayapi.com/v2/live/train/" + trainno + "/date/"
                    + date + "/apikey/" + Vmm.GetResponseFromUrl.apikey + "/";
            System.out.println(url);

           String response1 = Vmm.GetResponseFromUrl.getResponse(url);
          out.println(response1);
           // out.println(FakeJSON.livetrain);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

}
