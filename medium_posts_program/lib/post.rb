class Post
  attr_reader :text, :path, :author, :title, :read
  def initialize(attributes)
    @text = attributes[:text]
    @path = attributes[:path]
    @title = attributes[:title]
    @author = attributes[:author]

    @read = attributes[:read] || false
  end

  def read!
    @read = true
  end

  def read?
    @read
  end
end
