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


  it "lists the users" do 

    repo = UserRepository.new

    users = repo.all # list of users
    expect(users.length).to eq(2)
    expect(users[0].email).to eq('bob@gmail.com')
    expect(users[1].password).to eq('password')

  end

  it "creates a user" do
    
    repo = UserRepository.new

    user = User.new
    user.email = "jane@yahoo.com"
    user.password = "makers123"
    user.first_name = "Jane"
    user.last_name = "Doe"

    repo.create(user)

    expect(repo.all.length).to eq(3)
    expect(repo.all.last.first_name).to eq("Jane")
    expect(repo.all.last.last_name).to eq("Doe")
  end

end
