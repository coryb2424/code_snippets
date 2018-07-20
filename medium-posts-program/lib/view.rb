class View
  def self.show_all_posts(posts)
    posts.each_with_index do |post, index|
      box = post.read? ? '[X]' : '[ ]'
      puts "#{index + 1}. #{box} - #{post.title} (#{post.author})"
    end
  end

  def self.show_post(post)
    puts post.text
  end

  def self.ask_for_post_index(message)
    puts "Which post would you like to #{message}?"
    index = gets.chomp.to_i - 1
  end

  def self.ask_for_post_path
    puts "Please enter post path (le-wagon/.......)"
    path = gets.chomp
  end
end
