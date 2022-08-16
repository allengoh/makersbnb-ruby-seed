require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/space_repository'

DatabaseConnection.connect('makersbnb')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/spaces' do
    repo = SpaceRepository.new

    @spaces = repo.all
    return erb(:spaces)
  end
end