package database;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbconfig {

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");

            // 1. Try to get Railway MySQL details from Environment Variables
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String db = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            String url;

            if (host != null && !host.isEmpty()) {
                // ✅ ON RAILWAY - Use Railway DB
                url = "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                System.out.println("Connecting to Railway DB: " + url);
                return (Connection) DriverManager.getConnection(url, user, pass);
            } else {
                // ✅ ON LOCALHOST (XAMPP / NetBeans) - Use your local DB
                url = "jdbc:mysql://localhost:3306/project";
                System.out.println("Connecting to Local DB: " + url);
                return (Connection) DriverManager.getConnection(url, "root", "");
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
            throw new SQLException(e);
        }
    }
}
