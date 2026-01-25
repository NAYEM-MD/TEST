package controller;

import dao.CommentDAO;
import dao.PostDAO;
import model.Comment;
import model.Post;
import model.User;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/posts/*")
public class PostServlet extends HttpServlet {
    private PostDAO postDAO = new PostDAO();
    private CommentDAO commentDAO = new CommentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) path = "/feed";
        
        HttpSession session = request.getSession(false);
        int currentUserId = 0;
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            currentUserId = user.getId();
        }
        
        switch (path) {
            case "/feed":
                List<Post> posts = postDAO.findAll(currentUserId);
                request.setAttribute("posts", posts);
                request.getRequestDispatcher("/WEB-INF/views/posts/feed.jsp").forward(request, response);
                break;
            case "/create":
                if (currentUserId == 0) {
                    response.sendRedirect(request.getContextPath() + "/auth/login");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/posts/create.jsp").forward(request, response);
                break;
            case "/detail":
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    Post post = postDAO.findById(id, currentUserId);
                    List<Comment> comments = commentDAO.findByPostId(id);
                    request.setAttribute("post", post);
                    request.setAttribute("comments", comments);
                    request.getRequestDispatcher("/WEB-INF/views/posts/detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/posts/feed");
                }
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if ("/create".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }
            User user = (User) session.getAttribute("user");
            
            String title = request.getParameter("title");
            String content = request.getParameter("content"); // This is the rich text body
            String community = request.getParameter("community");
            
            Post post = new Post(title, content, community, user.getId());
            postDAO.save(post);
            
            response.sendRedirect(request.getContextPath() + "/posts/feed");
        }
    }
}
