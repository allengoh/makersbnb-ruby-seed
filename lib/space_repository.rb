require_relative 'space'
require_relative 'database_connection'

class SpaceRepository
  def all
    sql = 'SELECT * FROM spaces;'
    result = DatabaseConnection.exec_params(sql, [])

    spaces = []

    result.each do |record|
      space = Space.new
      space.id = record['id'].to_i
      space.name = record['name']
      space.description = record['description']
      space.price_per_night = record['price_per_night']
      space.user_id = record['user_id'].to_i
      spaces << space
    end

    return spaces
  end

  def create(space)
    sql = 'INSERT INTO spaces (name, description, price_per_night, user_id) VALUES ($1, $2, $3, $4);'
    params = [space.name, space.description, space.price_per_night, space.user_id]
    result = DatabaseConnection.exec_params(sql, params)
    
  end
end





