class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    puts "------------------------------------\n"\
         "Welcome to your Medium pocket reader\n"\
         "------------------------------------\n"

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list_all
    when 2 then @controller.save_post
    when 3 then @controller.read_post
    when 4 then @controller.mark_post_as_read
    when 5 then stop
    else
      puts "Please press 1, 2, 3, 4 or 5"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts "----------------------------\n"\
         "What do you want to do next?\n"\
         "----------------------------\n"\
         "1. List Posts\n"\
         "2. Save post for later\n"\
         "3. Read Post\n"\
         "4. Mark post as read\n"\
         "5. Exit"
    print "> "
  end
end
