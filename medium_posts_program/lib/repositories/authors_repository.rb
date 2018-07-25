class AuthorRepository
  def initialize(filepath, post_repo)
    @filepath = filepath
    @authors = []
    @post_repo = post_repo
    @next_id = 1
    load_csv
  end

  def load_csv
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      posts = row[:posts].split(',').map { |post_id| @post_repo.find(post_id) }
      @authors << Author.new(id: row[:id],
                             medium_nickname: row[:medium_nickname],
                             name: row[:name],
                             description: row[:description],
                             following_count: row[:following_count],
                             follower_count: row[:follower_count],
                             posts: posts)
    end
    @next_id = @authors.last.id + 1
  end

  def save_csv
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << %w[id
                medium_nickname
                name
                description
                following_count
                follower_count
                posts]
      @authors.each do |author|
        posts = author.posts.map { |post| post.id}.join(',')
        csv << [author.id,
                author.medium_nickname,
                author.name,
                author.description,
                author.following_count,
                author.follower_count,
                posts]
      end
    end
  end

  def find(id)
    @authors.find { |id| author.id == id.to_i }
  end

  def add(author)
    author.id = @next_id
    @next_id += 1
    @authors << author
    save_csv
  end

  def all
    @authors
  end
end
