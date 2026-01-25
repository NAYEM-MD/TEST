<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Post" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reddit Clone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/feed.css">
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="main-container">
        <!-- Feed Column -->
        <div class="feed-column">
            <div class="create-post-bar">
                <div class="user-avatar"></div>
                <input type="text" placeholder="Create Post" onclick="location.href='${pageContext.request.contextPath}/posts/create'">
                <div class="action-icon">🖼️</div>
                <div class="action-icon">🔗</div>
            </div>

            <% 
            List<Post> posts = (List<Post>) request.getAttribute("posts");
            if (posts != null && !posts.isEmpty()) {
                for (Post post : posts) {
            %>
            <div class="post-card" onclick="location.href='${pageContext.request.contextPath}/posts/detail?id=<%= post.getId() %>'">
                <div class="vote-column">
                    <div class="vote-arrow up <%= post.getUserVote() == 1 ? "active" : "" %>" onclick="vote(<%= post.getId() %>, 1, this); event.stopPropagation();">⬆</div>
                    <div class="vote-count"><%= post.getVoteCount() %></div>
                    <div class="vote-arrow down <%= post.getUserVote() == -1 ? "active" : "" %>" onclick="vote(<%= post.getId() %>, -1, this); event.stopPropagation();">⬇</div>
                </div>
                <div class="post-content">
                    <div class="post-meta">
                        <span class="community-name">r/<%= post.getCommunity() != null ? post.getCommunity() : "general" %></span>
                        <span class="posted-by">Posted by u/<%= post.getAuthorName() %></span>
                    </div>
                    <h3 class="post-title"><%= post.getTitle() %></h3>
                    <div class="post-preview">
                        <%= post.getContent().length() > 200 ? post.getContent().substring(0, 200) + "..." : post.getContent() %>
                    </div>
                    <div class="post-footer">
                        <div class="footer-btn">💬 Comments</div>
                        <div class="footer-btn">share</div>
                        <div class="footer-btn">save</div>
                    </div>
                </div>
            </div>
            <% 
                }
            } else {
            %>
                <div class="post-card">
                    <div class="post-content" style="padding: 20px; text-align: center;">
                        <p>No posts yet. Be the first to create one!</p>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Sidebar Column -->
        <div class="sidebar-column">
            <div class="sidebar-card">
                <div class="card-header">
                    <h3>Trending Today</h3>
                </div>
                <div class="card-content">
                    <div class="trending-item">
                        <div class="trend-icon"></div>
                        <div class="trend-info">
                            <h4>r/technology</h4>
                            <p>25.4M members</p>
                        </div>
                    </div>
                    <div class="trending-item">
                        <div class="trend-icon"></div>
                        <div class="trend-info">
                            <h4>r/gaming</h4>
                            <p>18.2M members</p>
                        </div>
                    </div>
                    <div class="trending-item">
                        <div class="trend-icon"></div>
                        <div class="trend-info">
                            <h4>r/askreddit</h4>
                            <p>45.1M members</p>
                        </div>
                    </div>
                    <div class="trending-item">
                        <div class="trend-icon"></div>
                        <div class="trend-info">
                            <h4>r/funny</h4>
                            <p>52.3M members</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="sidebar-card">
                <div class="card-header">
                    <h3>About</h3>
                </div>
                <div class="card-content">
                    <p>Welcome to Reddit Clone! Join communities, share content, and connect with people who share your interests.</p>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/vote.js"></script>
</body>
</html>
