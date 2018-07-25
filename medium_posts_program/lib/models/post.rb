class Post
  attr_reader :text, :path, :title, :read
  attr_accessor :author, :id

  def initialize(attr = {})
    @id = attr[:id]
    @text = attr[:text]
    @path = attr[:path]
    @title = attr[:title]
    @author = attr[:author] || []
    @read = attr[:read] || false
  end

  def read!
    @read = true
  end

  def read?
    @read
  end
end
