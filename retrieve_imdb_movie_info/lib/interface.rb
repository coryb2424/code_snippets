# Scrapes imdb.com for the top X movies and their info
# Storing it in a yml file

require 'yaml'
require_relative 'scraper'

data_storage_path = 'data/movies.yml'
number_of_movies = 5

puts 'Fetching URLs'
urls = fetch_movie_urls(number_of_movies)

movies = urls.map do |url|
  puts "Scraping #{url}"
  scrape_movie(url)
end

puts 'Writing movies.yml'
File.open(data_storage_path, 'w') do |f|
  f.write(movies.to_yaml)
end

puts 'Done.'
