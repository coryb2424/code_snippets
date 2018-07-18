require 'open-uri'
require 'nokogiri'

def fetch_movie_urls(movie_amount)
  html_file = open('https://www.imdb.com/chart/top').read
  html_doc = Nokogiri::HTML(html_file)

  extra_url_info = /\?.+$/
  html_doc.search('.lister-list tr').first(movie_amount).map do |element|
    'https://www.imdb.com' + element.at('a')['href'].gsub(extra_url_info, '')
  end
end

def scrape_movie(url)
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  movie_info = {}
  movie_info[:title] = if html_doc.at('.originalTitle')
                         html_doc.at('.originalTitle').children[0].text
                       else
                         html_doc.at('.title_wrapper h1').children[0].text.strip
                       end
  movie_info[:storyline] = html_doc.at('.summary_text').children.text.strip
  movie_info[:director] = html_doc.at('//span[@itemprop = \'director\']').children.text.strip
  movie_info[:cast] = html_doc.search('//span[@itemprop = \'actors\']').map do |element|
    element.children.text.strip.delete(',')
  end
  movie_info[:year] = html_doc.at('#titleYear').text.strip.delete('(').delete(')')
  movie_info
end
