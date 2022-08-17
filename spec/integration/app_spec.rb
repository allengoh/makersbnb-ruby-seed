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

  before(:each) do 
    reset_makersbnb_table
  end

  context "GET /spaces" do
    it "shows the list of spaces" do
      response = get('/spaces')
      expect(response.status).to eq(200)
      expect(response.body).to include("<div>Name: Luxurious Apartment with a Sea View</div>")
    end
  end

  context "GET /spaces/new" do
    xit "adds return a form to add a new space" do
      response = get('/spaces/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/spaces">')
      expect(response.body).to include('<input type="text" name="name">')
      expect(response.body).to include('<input type="text" name="description">')
      expect(response.body).to include('<input type="text" name="price_per_night">')
    end
  end

  context "POST /spaces" do
    xit "adds a new space" do
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
      expect(response.body).to include('<form method="POST" action="/login">')
      expect(response.body).to include('<input type="text" name="email">')
      expect(response.body).to include('<input type="password" name="password">')
    end
  end

  context 'POST /login' do
    it 'returns spaces.erb if password matches' do
      response = post('/login', 
      email: 'bob@gmail.com',
      password: '12345'
      )

      expect(response.status).to eq(302)
      expect(response.location).to include('/spaces')
    end

    it 'redirects to error page if incorrect password entered' do
      repo = UserRepository.new
      incorrect_password_entered = repo.login('bob@gmail.com', '123456')
      
      response = post('/login', 
      email: 'bob@gmail.com',
      password: '123456'
      )
      expect(incorrect_password_entered).to eq false
      expect(response.status).to eq 200
      expect(response.body).to include ('<h1>Your login was unsuccessful!</h1>' )
    end
  end

  context 'POST /logout' do
    it 'logs out the user (ends current session)' do
      response = get('/logout')

      expect(response.status).to eq 200
      expect(response.body).to include ('<h1>You just log out!</h1>')
    end
  end

  context 'GET /signup/new' do
    xit 'returns 200 OK and form for user to sign up' do
      response = get('/signup/new')

     expect(response.status).to eq 200
      expect(response.body).to include ("<h1>Fill in your details below to sign up</h1>")
   end
  end

 context 'POST /signup' do
    xit 'returns 200 OK and posts form with filled in information' do
    response = post('/signup', 
      first_name: 'Jane', 
      last_name: 'Doe', 
     email: 'janedoe@email.com', 
     password: 'password123')

   expect(response.status).to eq 200

      expect(response.body).to include ("<h1>Your sign up was successful!</h1>")
    end
   end

      expect(response.body).to include ("<h1>Your sign up was successful!</h1>")
    end
  end

  context "GET /login/new" do
    
    it "returns a form for logging in" do 

      response = get("/login/new")

      expect(response.status).to eq 200
      expect(response.body).to include ("<input type=\"submit\" value=\"Log in now.\" />")

    end
  end


end

