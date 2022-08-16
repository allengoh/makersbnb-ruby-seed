require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/space_repository'
require_relative 'lib/user_repository'


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
  end

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
    repo = SpaceRepository.new
    @space = Space.new

    @space.name = params[:name]
    @space.description = params[:description]
    @space.price_per_night = params[:price_per_night]

    repo.create(@space)
    return erb(:space_confirmation)
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

end