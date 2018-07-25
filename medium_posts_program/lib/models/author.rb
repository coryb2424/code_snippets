class Author
  attr_reader :medium_nickname, :following_count, :name, :follower_count
  attr_accessor :id, :description, :posts

  def initialize(attr = {})
    @id = attr[:id]
    @medium_nickname = attr[:medium_nickname]
    @name = attr[:name]
    @description = attr[:description]
    @following_count = attr[:following_count]
    @follower_count = attr[:follower_count]
    @posts = attr[:posts] || []
  end

  def add_post(post)
    @posts << post
    post.author = self
  end
end
