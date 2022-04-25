module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'
      if routes[verb].nil?
        puts "Wrong input"
        next
      end

      action = nil

      if verb == 'GET'
        begin
          print 'Choose action (index/show) / q to exit: '
          input = gets.chomp
          break if input == 'q'
          yield if input != "index" && input != "show"
          action = input
        rescue
          puts "Wrong input"
          retry
        end
      end

      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    if @posts.length == 0
      puts "Nothing to show"
      return
    end
    @posts.each_with_index do |post, i|
      puts "#{i}. #{post}"
    end
  end

  def show
    print "Enter post's ID to show: "
    id = gets.chomp.to_i
    if @posts[id].nil?
      puts "Post with ID #{id} was not found"
      return
    end
    puts "#{id}. #{@posts[id]}"
  end

  def create
    print "Write new post: "
    post = gets.chomp
    if post == ""
      puts "Post can't be empty"
      return
    end
    @posts.push(post)
    puts "#{@posts.length - 1}. #{@posts.last}"
  end

  def update
    print "Enter post's ID to edit: "
    id = gets.chomp.to_i
    if @posts[id].nil?
      puts "Post with ID #{id} was not found"
      return
    end
    print "Write post: "
    post = gets.chomp
    if post == ""
      puts "Post can't be empty"
      return
    end
    @posts[id] = post
    puts "#{id}. #{@posts[id]}"
  end

  def destroy
    print "Enter post's ID to delete: "
    id = gets.chomp.to_i
    if @posts[id].nil?
      puts "Post with ID #{id} was not found"
      return
    end
    @posts.delete_at(id)
    puts "Post with ID = #{id} was deleted"
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp
      if !["1", "2", "q"].include?(choise)
        puts "Wrong input"
        next
      end
      break if choise == 'q'
      PostsController.connection(@routes['posts']) if choise == '1'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
