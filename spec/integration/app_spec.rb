require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    seed_sql = File.read('spec/seeds/seeds.sql')
    connection.exec(seed_sql)
  end

  context 'GET /' do
    it 'returns 200 OK and HTML view of homepage' do
      response = get('/')

      expect(response.status).to eq 200

      expect(response.body).to include ("<h1>Welcome to MakersBNB!</h1>")
    end
  end

  context 'GET /signup/new' do
    it 'returns 200 OK and form for user to sign up' do
      response = get('/signup/new')

      expect(response.status).to eq 200

      expect(response.body).to include ("<h1>Fill in your details below to sign up</h1>")
    end
  end

  context 'POST /signup' do
    it 'returns 200 OK and posts form with filled in information' do
      response = post('/signup', 
      first_name: 'Jane', 
      last_name: 'Doe', 
      email: 'janedoe@email.com', 
      password: 'password123')

      expect(response.status).to eq 200

      expect(response.body).to include ("<h1>Your sign up was successful!</h1>")
    end
  end


end


