lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "top_movies_of_the_year/version"

Gem::Specification.new do |spec|
  spec.name          = "top_movies_of_the_year"
  spec.version       = TopMoviesOfTheYear::VERSION
  spec.authors       = ["'ayesha ansari'"]
  spec.email         = ["'ayesha.x.ansari@gmail.com'"]

  spec.summary       = "Top Movies Of The Year"
  spec.description   = "List Top Movies provide details related to the top movie selected"
  spec.homepage      = "http://rubygems.org/gems/top_movies_of_the_year"
  spec.license       = "MIT"

  spec.files         = ["lib/top_movies_of_the_year.rb", "lib/top_movies_of_the_year/cli.rb", "lib/top_movies_of_the_year/scraper.rb",
                        "lib/top_movies_of_the_year/movies.rb"]
 # spec.bindir        = "exe"
  spec.executables  << "top-movies-of-the-year"
  spec.require_paths = ["lib", "lib/top_movies_of_the_year"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
end
