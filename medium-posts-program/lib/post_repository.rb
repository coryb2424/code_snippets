require 'csv'

class PostRepository
  def initialize(filepath)
    @filepath = filepath
    @posts = []
    load_csv
  end

  def load_csv
    CSV.foreach(@filepath, encoding: 'ISO-8859-1', headers: true) do |row|
      read = row['read'] == 'true'? true : false
      @posts << Post.new(path: row['path'], text: row['text'],
                         title: row['title'], author: row['author'],
                         read: read)
    end
  end

  def save_csv
    csv_options = { col_sep: ',', quote_char: '"' }

    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << ['path', 'title', 'text', 'author', 'read']
      @posts.each do |post|
        csv << [post.path, post.title, post.text, post.author, post.read]
      end
    end
  end

  def find(index)
    @posts[index]
  end

  def add(post)
    @posts << post
    save_csv
  end

  def all
    @posts
  end
end
