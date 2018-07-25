require_relative '../models/post'
require_relative '../views/posts_view'

require 'nokogiri'
require 'open-uri'

class PostsController
  MEDIUM_BASE_URL = 'http://medium.com/'
  def initialize(repo)
    @repo = repo
  end

  def list_all
    posts = @repo.all
    View.show_all_posts(posts)
  end

  def save_post
    post_path = View.ask_for_post_path
    attributes = parse_post(post_path)
    post = Post.new(attributes)
    @repo.add(post)
  end

  def read_post
    index = View.ask_for_post_index('read')
    post = @repo.find(index)
    View.show_post(post)
  end

  def mark_post_as_read
    index = View.ask_for_post_index('mark as read')
    post = @repo.find(index)
    post.read!
    @repo.save_csv
  end

  def parse_post(post_path)
    html_file = open(MEDIUM_BASE_URL + post_path)
    html_doc = Nokogiri::HTML(html_file)

    attributes = {}
    attributes[:path] = post_path
    attributes[:title] = html_doc.at('.graf--title').text.strip
    attributes[:author] = html_doc.at('.ds-link', '.ds-link--styleSubtle').text.strip
    attributes[:text] = html_doc.at('.section-content').children.last.search('p').to_a.map do |sentence|
      sentence.text + "\n"
    end.join
    return attributes
  end
end
