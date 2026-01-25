<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Post - Reddit Clone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/post.css">
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="create-post-container">
        <div class="create-post-header">
            <h2>Create post</h2>
            <div class="drafts-btn">Drafts</div>
        </div>

        <div class="community-select-wrapper">
            <select name="community_select" class="community-select">
                <option value="" disabled selected>Choose a community</option>
                <option value="learnprogramming">r/learnprogramming</option>
                <option value="technology">r/technology</option>
                <option value="gaming">r/gaming</option>
            </select>
        </div>

        <div class="post-form-card">
            <div class="post-tabs">
                <div class="tab active">
                    <span class="tab-icon">📄</span> Post
                </div>
                <div class="tab">
                    <span class="tab-icon">🖼️</span> Images & Video
                </div>
                <div class="tab">
                    <span class="tab-icon">🔗</span> Link
                </div>
                <div class="tab">
                    <span class="tab-icon">📊</span> Poll
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/posts/create" method="post" class="post-form">
                <input type="hidden" name="community" value="learnprogramming"> <!-- Default for now -->
                
                <div class="title-input-wrapper">
                    <input type="text" name="title" placeholder="Title" required maxlength="300">
                    <span class="char-count">0/300</span>
                </div>

                <div class="body-editor-wrapper">
                    <div class="editor-toolbar">
                        <button type="button" class="toolbar-btn">B</button>
                        <button type="button" class="toolbar-btn">i</button>
                        <button type="button" class="toolbar-btn">🔗</button>
                        <button type="button" class="toolbar-btn">📷</button>
                        <button type="button" class="toolbar-btn">🎥</button>
                    </div>
                    <textarea name="content" placeholder="Text (optional)"></textarea>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn-secondary">Save Draft</button>
                    <button type="submit" class="btn-primary">Post</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
