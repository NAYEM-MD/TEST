package util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class SchemaLoader {
    // Matches DBUtil configuration
    private static final String URL = "jdbc:h2:~/galaxy_bbs;MODE=MySQL;DB_CLOSE_DELAY=-1;AUTO_SERVER=TRUE";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    public static void main(String[] args) {
        try {
            Class.forName("org.h2.Driver");
            
            // Execute Schema
            String schemaPath = "docs/schema.sql";
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 Statement stmt = conn.createStatement();
                 BufferedReader br = new BufferedReader(new FileReader(schemaPath))) {
                
                System.out.println("Connected to H2 database.");
                
                StringBuilder sql = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    // Remove comments lines (starting with --)
                    if (line.trim().startsWith("--")) continue;
                    
                    sql.append(line).append("\n");
                    if (line.trim().endsWith(";")) {
                        String query = sql.toString().trim();
                        // H2 might complain about CREATE DATABASE, so we skip it if present in schema.sql?
                        // Actually schema.sql has CREATE DATABASE, which H2 doesn't support in the same way or ignores.
                        // We should strip it or ignore errors for it.
                        
                        if (query.toUpperCase().startsWith("CREATE DATABASE") || query.toUpperCase().startsWith("USE ")) {
                            System.out.println("Skipping MySQL-specific command: " + query);
                            sql.setLength(0);
                            continue;
                        }

                        // Remove trailing semicolon for JDBC execution
                        if (query.endsWith(";")) {
                            query = query.substring(0, query.length() - 1);
                        }

                        System.out.println("Executing: " + query);
                        try {
                            stmt.executeUpdate(query);
                        } catch (Exception ex) {
                            System.err.println("Error executing query: " + query);
                            ex.printStackTrace();
                        }
                        sql.setLength(0);
                    }
                }
                System.out.println("Schema executed successfully.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to setup database.");
        }
    }
}
