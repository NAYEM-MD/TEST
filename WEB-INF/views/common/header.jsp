<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="app-header">
    <div class="header-left">
        <a href="${pageContext.request.contextPath}/posts/feed" class="logo-link">
            <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Reddit" class="header-logo">
            <span class="logo-text">Reddit Clone</span>
        </a>
    </div>
    
    <div class="header-center">
        <div class="search-bar">
            <input type="text" placeholder="Search posts...">
        </div>
    </div>
    
    <div class="header-right">
        <a href="${pageContext.request.contextPath}/posts/create" class="create-post-btn">
            <span class="plus-icon">+</span> Create Post
        </a>
        
        <div class="user-actions">
            <a href="${pageContext.request.contextPath}/auth/logout" class="icon-btn" title="Logout">
                <svg viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" class="icon">
                    <path d="M10 2a8 8 0 100 16 8 8 0 000-16zm0 14a6 6 0 110-12 6 6 0 010 12z"/>
                </svg>
            </a>
        </div>
    </div>
</header>
