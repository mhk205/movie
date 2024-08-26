package movie;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class MovieSearchDAO {
	 private DBConnectionMgr pool;

    public Vector<MovieBean> searchMovies(String query) throws Exception {
        Vector<MovieBean> movies = new Vector<>();        
        DBConnectionMgr pool = DBConnectionMgr.getInstance();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = pool.getConnection();
            String sql = "SELECT * FROM movieinfo WHERE mov_name LIKE ?"
            		+ "   OR mov_actors LIKE ?"
            		+ "   OR mov_director LIKE ?";
            		
            pstmt = conn.prepareStatement(sql);
            String searchQuery = '%' + query + '%';
            pstmt.setString(1, searchQuery);
            pstmt.setString(2, searchQuery);
            pstmt.setString(3, searchQuery);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MovieBean movie = new MovieBean();
                movie.setMov_name(rs.getString("mov_name"));
                movie.setMov_actors(rs.getString("mov_actors"));
                movie.setMovieCd(rs.getString("movieCd"));
                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) pool.getConnection();
        }

        return movies;
    }
    
    
    public Vector<MovieBean> genreMovies(String genreQuery) throws Exception {
        Vector<MovieBean> genres = new Vector<>();
        DBConnectionMgr pool = DBConnectionMgr.getInstance();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = pool.getConnection();
            String sql = "SELECT * FROM movieinfo WHERE mov_genre LIKE ?";
            	
            pstmt = conn.prepareStatement(sql);
            String searchGenreQuery = '%' + genreQuery + '%';
            pstmt.setString(1, searchGenreQuery);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MovieBean genre = new MovieBean();
                genre.setMov_genre(rs.getString("mov_genre"));
                genre.setMov_name(rs.getString("mov_name"));
                genre.setMovieCd(rs.getString("movieCd"));
                genres.add(genre);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) pool.getConnection();
        }

        return genres;
    }
    
    
    
    // 평점 가져오는 부분 수정 예정
    public List<MovieBean> getMoviesWithAverageRating() throws Exception {
    	DBConnectionMgr pool = DBConnectionMgr.getInstance();
        List<MovieBean> ratings = new ArrayList<>();
        String sql = "SELECT m.mov_name, m.movieCd, AVG(r.re_score) AS average_rating " +
                     "FROM movieinfo m " +
                     "JOIN review r ON m.mov_no = r.re_mov " +
                     "GROUP BY m.mov_name " +
                     "ORDER BY average_rating DESC";

        try (Connection conn = pool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                MovieBean movie = new MovieBean();
                movie.setMov_name(rs.getString("mov_name"));
                movie.setRe_score(rs.getDouble("average_rating"));
                movie.setMovieCd(rs.getString("movieCd"));
                ratings.add(movie);
            }
        }
        return ratings;
    }
}
