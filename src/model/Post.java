package model;

import java.io.Serializable;
import java.util.Date;

public class Post implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String content;
    private String community; // Added based on screenshot
    private int userId;
    private String authorName; // Transient field for display
    private int voteCount; // Transient field
    private int userVote; // Transient field: 1 (up), -1 (down), 0 (none)
    private Date createdAt;

    public Post() {}

    public Post(String title, String content, String community, int userId) {
        this.title = title;
        this.content = content;
        this.community = community;
        this.userId = userId;
        this.createdAt = new Date();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getCommunity() { return community; }
    public void setCommunity(String community) { this.community = community; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public int getVoteCount() { return voteCount; }
    public void setVoteCount(int voteCount) { this.voteCount = voteCount; }

    public int getUserVote() { return userVote; }
    public void setUserVote(int userVote) { this.userVote = userVote; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
