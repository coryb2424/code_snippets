require_relative 'post_controller'
require_relative 'post_repository'
require_relative 'router'

csv_file   = File.join(__dir__, 'posts.csv')
post_repo  = PostRepository.new(csv_file)
controller = PostController.new(post_repo)

router = Router.new(controller)

# Start the app
router.run
