require_relative '../models/post'
require_relative '../views/posts_view'
require_relative '../modules/parse_module'

require 'nokogiri'
require 'open-uri'

class PostsController
  include ParseModule
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
end
