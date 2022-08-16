require_relative 'database_connection'
require_relative 'user'
require 'bcrypt'

class UserRepository

  def all
    sql = 'SELECT * FROM users;'

    results = DatabaseConnection.exec_params(sql,[])

    users = []

    results.each do |record|
      user = User.new
      user.id = record['id']
      user.email = record['email']
      user.password = record['password']
      user.first_name = record['first_name']
      user.last_name = record['last_name']
      users << user
    end
    users
  end

  def create(user)
    encrypt_password = BCrypt::Password.create(user.password)

    sql = 'INSERT INTO users (email, password, first_name, last_name) VALUES ($1, $2, $3, $4);'
    params = [user.email, encrypt_password, user.first_name, user.last_name]
  
    DatabaseConnection.exec_params(sql, params)
  end
  
end