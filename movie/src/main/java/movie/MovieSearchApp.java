package movie;

import java.util.Vector;
import java.util.Scanner;

public class MovieSearchApp {
    public static void main(String[] args) throws Exception {
        MovieSearchDAO movieSearchDAO = new MovieSearchDAO();
        Scanner scanner = new Scanner(System.in);

       // System.out.println("Enter the movie title, actor name, or director name to search:");
        String query = scanner.nextLine();

        Vector<MovieBean> results = movieSearchDAO.searchMovies(query);

        if (results.isEmpty()) {
          //  System.out.println("No movies found for the search query: " + query);
        } else {
         //   System.out.println("Search results:");
            for (MovieBean movie : results) {
             //   System.out.println(movie);
            }
        }
    }
}
