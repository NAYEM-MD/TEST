package dao;

import model.Post;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    
    public List<Post> findAll() {
        return findAll(0);
    }

    public List<Post> findAll(int currentUserId) {
        List<Post> posts = new ArrayList<>();
        // Join with users to get author name, subquery for vote count and user vote
        String sql = "SELECT p.*, u.username as author_name, " +
                     "(SELECT COALESCE(SUM(v.vote_value), 0) FROM votes v WHERE v.post_id = p.id) as vote_count, " +
                     "(SELECT v2.vote_value FROM votes v2 WHERE v2.post_id = p.id AND v2.user_id = ?) as user_vote " +
                     "FROM posts p JOIN users u ON p.user_id = u.id ORDER BY p.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, currentUserId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    public Post findById(int id) {
        return findById(id, 0);
    }

    public Post findById(int id, int currentUserId) {
        Post post = null;
        String sql = "SELECT p.*, u.username as author_name, " +
                     "(SELECT COALESCE(SUM(v.vote_value), 0) FROM votes v WHERE v.post_id = p.id) as vote_count, " +
                     "(SELECT v2.vote_value FROM votes v2 WHERE v2.post_id = p.id AND v2.user_id = ?) as user_vote " +
                     "FROM posts p JOIN users u ON p.user_id = u.id WHERE p.id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, currentUserId);
            pstmt.setInt(2, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    post = mapResultSetToPost(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;
    }

    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setId(rs.getInt("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setCommunity(rs.getString("community"));
        post.setUserId(rs.getInt("user_id"));
        post.setAuthorName(rs.getString("author_name"));
        post.setCreatedAt(rs.getTimestamp("created_at"));
        post.setVoteCount(rs.getInt("vote_count"));
        post.setUserVote(rs.getInt("user_vote"));
        return post;
    }

    public void save(Post post) {
        String sql = "INSERT INTO posts (title, content, community, user_id, created_at) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getCommunity());
            pstmt.setInt(4, post.getUserId());
            pstmt.setTimestamp(5, new Timestamp(post.getCreatedAt().getTime()));
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
