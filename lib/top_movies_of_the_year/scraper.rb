class TopMoviesOfTheYear::Scraper

  def get_page
      Nokogiri::HTML(open("https://www.cinemaclock.com/movies/top-10"))
  end

  def scrape_comingsoon_movies
      get_page.css("div#CT div.BD div.movieblock")
  end

  def make_comingsoon_movies
    scrape_comingsoon_movies.css("div.movieblock.efilm").each do |movie_row|
       TopMoviesOfTheYear::Movies.new_from_index_page(movie_row)
    end
  end

end
