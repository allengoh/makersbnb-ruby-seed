require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/space_repository'
require_relative 'lib/user_repository'
require_relative 'lib/booking_repository'

if ENV['ENV'] == 'test'
  database_name = 'makersbnb_test'
else
  database_name = 'makersbnb'
end

DatabaseConnection.connect(database_name)

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/space_repository'
    also_reload 'libe/user_repository'
  end
  
  enable :sessions

  get "/" do
    return erb(:index)
  end

  get '/spaces' do
    repo = SpaceRepository.new

    @spaces = repo.all
    return erb(:spaces)
  end

  get '/spaces/new' do
    return erb(:space_new)
  end

  post '/spaces' do
    booking_repo = BookingRepository.new
    booking = Booking.new
    space_repo = SpaceRepository.new
    @space = Space.new

    @space.name = params[:name]
    @space.description = params[:description]
    @space.price_per_night = params[:price_per_night]
    booking.book_from = params[:date_from]
    booking.book_to = params[:date_to]
    booking.confirmed = 't'

    space_repo.create(@space)
    booking.space_id = space_repo.all.last.id
    booking_repo.create(booking)

    return erb(:space_confirmation)
  end
  

  post '/spaces/filtered' do
    @date_from = params[:date_from]
    @date_to = params[:date_to]

    booking_repo = BookingRepository.new  
    space_repo = SpaceRepository.new
    spaces = space_repo.all    

    @filtered = []
    spaces.each do |space|
      is_not_booked = booking_repo.check_no_booking(space.id, @date_from, @date_to)
      @filtered << space if is_not_booked
    end
    
    return erb(:spaces_filtered)
  end

  get "/signup/new" do 
    return erb(:signup)
  end

  get "/login/new" do 
    return erb(:login) 
  end

  post "/login" do
    email = params[:email]
    password = params[:password]
    
    repo = UserRepository.new
    user = repo.find_by_email(email)

    if repo.login(email, password)
      session[:user_id] = user.id.to_i
      return redirect('/spaces')
    else
      return erb(:login_error)
    end
  end

  get "/logout" do
    session[:user_id] = nil
    return erb(:logout)
  end

  get "/signup/new" do 
    return erb(:signup)
  end

  post '/signup' do
    user = User.new
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
  
    repo = UserRepository.new
 
    repo.create(user)

    return erb(:signup_confirmation)
  end

  get '/profile' do
    space_repo = SpaceRepository.new
    user_repo = UserRepository.new
    id = session[:user_id]
    @spaces = space_repo.find(id)
    @name = user_repo.find_by_id(id)

    return erb(:profile)
  end
end
