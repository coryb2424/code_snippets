require 'csv'

class PostsRepository
  HEADER = %w[id path title text author_id read]

  def initialize(filepath, auth_repo)
    @filepath = filepath
    @auth_repo = auth_repo
    @posts = []
    @next_id = 1
    load_csv
  end

  def find(id)
    @posts.find { |post| post.id == id.to_i }
  end

  def add(post)
    post.id = @next_id
    @next_id += 1
    @posts << post
    save_csv
  end

  def all
    @posts
  end

  def load_csv
    csv_options = { encoding: 'ISO-8859-1', headers: true, header_converters: :symbol }
    CSV.foreach(@filepath, csv_options) do |row|
      post = Post.new(build_post(row))
      post.author.posts << post
      @posts << post
    end
    @next_id = @posts.last.id + 1
  end

  def save_csv
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << HEADER
      @posts.each do |post|
        csv << serialize(post)
      end
    end
  end

  def build_post(info)
    author = @auth_repo.find(row[:author_id])
    { id:      row[:id],
      path:    row[:path],
      text:    row[:text],
      title:   row[:title],
      author:  author,
      read:    row[:read] == 'true' }
  end

  def serialize(post)
    [post.id, post.path, post.title, post.text, post.author.id, post.read]
  end
end
