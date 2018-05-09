class TopMoviesOfTheYear::Movies

  attr_accessor :title, :url, :timeurl, :infourl, :reviewurl, :videosurl, :rating, :year, :genre,
  :directedby, :company, :desc, :starring
  @@all = []

  def self.new_from_index_page(movie_row)
    self.new(
    @title =   movie_row.css("div.smallposter.shrink img.lazy").attr("alt").text.strip,
    @url =  "https://www.cinemaclock.com#{movie_row.css("h3.movietitle a").attr("href").text}"
    )
  end

  def initialize(title=nil, url=nil, genre_index=nil )
    @title     =   title
    @url       =   url
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.find(id)
    self.all[id-1]
  end

  def profile_doc
    @movie_profile = Nokogiri::HTML(open(self.url))
  end

  def time_url
    @tim_button ||= "https://www.cinemaclock.com#{profile_doc.css("a.buttontoptab.btntim").attr("href").text}"
  end

  def info_url
    @info_button ||= "https://www.cinemaclock.com#{profile_doc.css("a.buttontoptab.btninf").attr("href").text}"
  end

  def review_url
    @rev_button ||= "https://www.cinemaclock.com#{profile_doc.css("a.buttontoptab.btnrev").attr("href").text}"
  end

  def video_url
      @vid_button ||= "https://www.cinemaclock.com#{profile_doc.css("a.buttontoptab.btnvid").attr("href").text}"
  end

  def  get_rating
    rating  = profile_doc.css("#ratingmpaa > td.desc2 > div > div > span").text
  end

  def  get_year
    scraper_doc = profile_doc.css("table.desc tr")
    scraper_doc.collect  do |row|
      if row.css("td.desc1").text  == "Year"
        return  @year =  row.css("td.desc2").text
      end
    end
  end

  def get_genre
    scraper_doc = profile_doc.css("table.desc tr")
    scraper_doc.collect  do |row|
      if row.css("td.desc1").text  == "Genre"
        return  @genre =  row.css("td.desc2").text
      end
    end
  end

  def get_directedby
    scraper_doc     = profile_doc.css("table.desc tr")
    scraper_doc.collect  do |row|
      if row.css("td.desc1").text  == "Directed by"
        return  @directedby =  row.css("td.desc2").text
      end
    end
  end

  def get_company
    @company = profile_doc.xpath("//*[@id='companycan']").text
  end

  def  get_desc
    @desc = profile_doc.css("div:nth-child(5) > i").text
  end

  def get_starring
    starring_doc   = profile_doc.css("div#actors1 div.aktor div.aktnam")
    starring_array =   starring_doc.collect do |row|
      row.css("span.acname").text.strip
    end
    starring_array.compact.reject(&:empty?).join(', ')
  end

end
