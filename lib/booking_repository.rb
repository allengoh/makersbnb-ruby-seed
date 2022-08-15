require_relative 'booking'
require_relative 'database_connection'

class BookingRepository
  def all
    sql = 'SELECT * FROM bookings'
    results = DatabaseConnection.exec_params(sql,[])

    bookings = []
    results.each do |record|
      booking = Booking.new
      booking.id = record['id']
      booking.date_booked = record['date_booked']
      booking.confirmed = record['confirmed']
      booking.space_id = record['space_id']

      bookings << booking
    end
    bookings
  end

  def create(booking)
    sql = 'INSERT INTO bookings (date_booked, confirmed, space_id) VALUES ($1, $2, $3);'
    sql_params = [booking.date_booked, booking.confirmed, booking.space_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

end