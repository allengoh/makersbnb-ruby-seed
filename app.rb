require 'sinatra/base'
require 'sinatra/reloader'
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
    also_reload 'lib/user_repository'
  end
  
  get "/" do
    return erb(:index)
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