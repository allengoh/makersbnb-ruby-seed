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
  
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
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
    expect(response.body).to include('<form method="POST" action="/spaces/new">')
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

    end
  end
end
