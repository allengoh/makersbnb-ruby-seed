require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

def reset_makersbnb_table
  seed_sql = File.read('spec/seeds/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_makersbnb_table
  end

  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /spaces" do
    it "shows the list of spaces" do
      response = get('/spaces')
      expect(response.status).to eq(200)
      expect(response.body).to include("<div>Name: Luxurious Apartment with a Sea View</div>")
    end
  end

  context "GET /spaces/new" do
    it "adds return a form to add a new space" do
      response = get('/spaces/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/spaces">')
      expect(response.body).to include('<input type="text" name="name">')
      expect(response.body).to include('<input type="text" name="description">')
      expect(response.body).to include('<input type="text" name="price_per_night">')
    end
  end

  context "POST /spaces" do
    it "adds a new space" do
      response = post('/spaces',
      name: 'Treehouse',
      description: 'Live for the night... up high',
      price_per_night: '30'
      )
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Your space was added!</h1>")
    end
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


