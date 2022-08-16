require "user_repository"

def reset_seeds_table 
  seed_sql = File.read('spec/seeds/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test'})
  connection.exec(seed_sql)
end


RSpec.describe UserRepository do 

  before(:each) do 
    reset_seeds_table
  end

  it "finds the user" do
    repo = UserRepository.new
    email = "bob@gmail.com"
    user = repo.find_by_email(email)

    expect(user.email).to eq("bob@gmail.com")
    expect(user.first_name).to eq("Bob")
    expect(user.last_name).to eq("Billy")
  end

  it "creates an encrypted user account" do
    repo = UserRepository.new

    user = User.new
    user.email = "jane@yahoo.com"
    user.first_name = "Jane"
    user.last_name = "Doe"

    allow(BCrypt::Password).to receive(:create).and_return("makers123")
    repo.create(user)
    new_user = repo.find_by_email("jane@yahoo.com")

    expect(new_user.first_name).to eq("Jane")
    expect(new_user.last_name).to eq("Doe")
    expect(new_user.password).to eq("makers123")
  end

  xit 'logs in a user' do
    repo = UserRepository.new

    repo
  end
end