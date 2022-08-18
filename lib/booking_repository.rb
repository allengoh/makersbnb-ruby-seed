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
      booking.book_from = record['book_from']
      booking.book_to = record['book_to']
      booking.confirmed = record['confirmed']
      booking.space_id = record['space_id']
      booking.guest_id = record['guest_id']

      bookings << booking
    end
    bookings
  end

  def create(booking)
    sql = 'INSERT INTO bookings (book_from, book_to, confirmed, space_id, guest_id) VALUES ($1, $2, $3, $4, $5);'
    sql_params = [booking.book_from,booking.book_to, booking.confirmed, booking.space_id, booking.guest_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def check_no_booking(id, date_from, date_to)
    sql = 'SELECT * FROM bookings
            WHERE id = $1 AND book_from >= $2 AND book_to <= $3;'
    params = [id, date_from, date_to]
    result = DatabaseConnection.exec_params(sql, params)
    
    return result.ntuples == 0 || result[0]['confirmed'] == 'f'
  end
end