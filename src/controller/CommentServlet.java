package controller;

import dao.CommentDAO;
import model.Comment;
import model.User;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/comments/*")
public class CommentServlet extends HttpServlet {
    private CommentDAO commentDAO = new CommentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if ("/create".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }
            User user = (User) session.getAttribute("user");
            
            String content = request.getParameter("content");
            int postId = Integer.parseInt(request.getParameter("postId"));
            
            Comment comment = new Comment(content, postId, user.getId());
            commentDAO.save(comment);
            
            response.sendRedirect(request.getContextPath() + "/posts/detail?id=" + postId);
        }
    }
}
