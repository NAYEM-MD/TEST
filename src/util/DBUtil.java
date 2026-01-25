package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // H2 Database Connection URL
    // Storing database in the user's home directory to avoid permission issues
    // MODE=MySQL for compatibility
    private static final String DEFAULT_URL = "jdbc:h2:~/galaxy_bbs;MODE=MySQL;DB_CLOSE_DELAY=-1;AUTO_SERVER=TRUE";
    private static final String DEFAULT_USER = "sa";
    private static final String DEFAULT_PASSWORD = "";

    static {
        try {
            // Load H2 Driver
            Class.forName("org.h2.Driver");
            // Load MySQL Driver (if present in classpath)
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                // Ignore if MySQL driver is missing, we might not need it
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.isEmpty()) url = DEFAULT_URL;
        if (user == null || user.isEmpty()) user = DEFAULT_USER;
        if (password == null) password = DEFAULT_PASSWORD;

        return DriverManager.getConnection(url, user, password);
    }
}
