package homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ServiceUtil {
   static Connection con;
   static {
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");//로딩할때는 확장자 필요 없음
         System.out.println("Susccess!");
      } catch (Exception e) {
         // TODO: handle exception
         e.printStackTrace();
      }
   }
   public static Connection getConnection() {
      try {
         con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","C##APPLE","1234");
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return con; 
      
   }
}