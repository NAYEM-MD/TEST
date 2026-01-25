<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Post" %>
<%@ page import="model.Comment" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post Detail - Reddit Clone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feed.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/post.css">
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="post-detail-container">
        <div class="detail-left">
            <div class="post-header-bar">
                <div class="back-link" onclick="location.href='${pageContext.request.contextPath}/posts/feed'" style="cursor: pointer;">
                    ⬅ Back to feed
                </div>
            </div>

            <%
            Post post = (Post) request.getAttribute("post");
            if (post != null) {
            %>
            <div class="detail-post-card">
                <div class="vote-column">
                    <div class="vote-arrow up <%= post.getUserVote() == 1 ? "active" : "" %>" onclick="vote(<%= post.getId() %>, 1, this)">⬆</div>
                    <div class="vote-count"><%= post.getVoteCount() %></div>
                    <div class="vote-arrow down <%= post.getUserVote() == -1 ? "active" : "" %>" onclick="vote(<%= post.getId() %>, -1, this)">⬇</div>
                </div>
                <div class="detail-content">
                    <div class="post-meta">
                        <span class="community-name">r/<%= post.getCommunity() != null ? post.getCommunity() : "general" %></span>
                        <span class="posted-by">Posted by u/<%= post.getAuthorName() %> • 3h ago</span>
                    </div>
                    <h1 class="post-title"><%= post.getTitle() %></h1>
                    <div class="post-body-text">
                        <%= post.getContent() %>
                    </div>
                    <div class="post-footer">
                        <div class="footer-btn">💬 <%= request.getAttribute("comments") != null ? ((List)request.getAttribute("comments")).size() : 0 %> Comments</div>
                        <div class="footer-btn">share</div>
                        <div class="footer-btn">save</div>
                    </div>
                </div>
            </div>

            <div class="comment-section">
                <% 
                User user = (User) session.getAttribute("user");
                if (user != null) {
                %>
                <div class="comment-input-area">
                    <div class="comment-as">
                        Comment as <a href="#">u/<%= user.getUsername() %></a>
                    </div>
                    <form action="${pageContext.request.contextPath}/comments/create" method="post">
                        <input type="hidden" name="postId" value="<%= post.getId() %>">
                        <textarea name="content" class="comment-textarea" placeholder="What are your thoughts?"></textarea>
                        <div class="comment-actions">
                            <button type="submit" class="btn-primary">Comment</button>
                        </div>
                    </form>
                </div>
                <% } else { %>
                    <p style="margin-bottom: 20px;"><a href="${pageContext.request.contextPath}/auth/login" style="color:#0079d3;">Log in</a> to comment.</p>
                <% } %>

                <div class="comments-list">
                    <%
                    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
                    if (comments != null) {
                        for (Comment comment : comments) {
                    %>
                    <div class="comment">
                        <div class="comment-header">
                            <span class="comment-author">u/<%= comment.getAuthorName() %></span>
                            <span class="comment-time">just now</span>
                        </div>
                        <div class="comment-body">
                            <%= comment.getContent() %>
                        </div>
                    </div>
                    <%
                        }
                    }
                    %>
                </div>
            </div>
            <% } else { %>
                <p>Post not found.</p>
            <% } %>
        </div>

        <div class="detail-right">
             <div class="sidebar-card">
                <div class="card-header">
                    <h3>About Community</h3>
                </div>
                <div class="card-content">
                    <p>Welcome to r/<%= post != null && post.getCommunity() != null ? post.getCommunity() : "general" %></p>
                    <div class="stats" style="margin-top: 10px; font-weight: 700;">
                        25.4m <span style="font-weight: 400; font-size: 12px; color: #7c7c7c;">Members</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/vote.js"></script>
</body>
</html>
