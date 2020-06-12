package Vmm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBLoader 
{
    public static ResultSet executeQuery(String SQLString) throws Exception
    {
        
            //////  ##CODE  ///////    
            Class.forName("com.mysql.jdbc.Driver");
            
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/irctcdb", "root", "system");
            
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            ResultSet rs = stmt.executeQuery(SQLString);
                        
            return rs;
            
            
      
    }

    public static void main(String[] args) 
    {
        try 
        {
            ResultSet rs=DBLoader.executeQuery("select * from deviceinfo where mobileno="+null);
            
            while(rs.next())
            {
                System.out.println(rs.getInt("id")+"  "+rs.getString("devicetoken"));
            }
            
        }
        catch (Exception ex) 
        {
          ex.printStackTrace();
        }
    }

}
