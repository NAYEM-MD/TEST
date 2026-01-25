package util;

import dao.UserDAO;
import model.User;

public class Diag {
    public static void main(String[] args) {
        System.out.println("Starting Diagnostics...");
        UserDAO dao = new UserDAO();
        
        // 1. Try to create a user
        String testEmail = "test_" + System.currentTimeMillis() + "@example.com";
        String testUser = "user_" + System.currentTimeMillis();
        String testPass = "password123";
        
        System.out.println("Creating user: " + testUser + " / " + testEmail);
        User u = new User(testUser, testPass, testEmail);
        dao.save(u);
        
        // 2. Try to retrieve
        System.out.println("Retrieving by email: " + testEmail);
        User retrieved = dao.findByEmail(testEmail);
        
        if (retrieved == null) {
            System.out.println("ERROR: User not found after save!");
        } else {
            System.out.println("User found: ID=" + retrieved.getId());
            System.out.println("Stored Password: " + retrieved.getPassword());
            System.out.println("Input Password:  " + testPass);
            System.out.println("Match? " + retrieved.getPassword().equals(testPass));
        }
    }
}