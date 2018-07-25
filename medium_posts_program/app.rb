require_relative 'lib/controllers/posts_controller'
require_relative 'lib/repositories/posts_repository'
require_relative 'router'

csv_file   = File.join(__dir__, 'data/posts.csv')
post_repo  = PostsRepository.new(csv_file)
controller = PostsController.new(post_repo)

router = Router.new(controller)

# Start the app
router.run
