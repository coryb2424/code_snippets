class AuthorRepository
  HEADER = %w[id
              medium_nickname
              name
              description
              following_count
              follower_count]

  def initialize(filepath)
    @filepath = filepath
    @authors = []
    @next_id = 1
    load_csv
  end

  def find(id)
    @authors.find { |author| author.id == id.to_i }
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

  def load_csv
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @authors << Author.new(build_author(row))
    end
    @next_id = @authors.last.id + 1
  end

  def save_csv
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << HEADER
      @authors.each do |author|
        csv << serialize(author)
      end
    end
  end

  def build_author(info)
    { id:              info[:id],
      medium_nickname: info[:medium_nickname],
      name:            info[:name],
      description:     info[:description],
      following_count: info[:following_count],
      follower_count:  info[:follower_count] }
  end

  def serialize(author)
    [author.id,
     author.medium_nickname,
     author.name,
     author.description,
     author.following_count,
     author.follower_count]
  end
end
