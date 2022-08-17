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

      bookings << booking
    end
    bookings
  end

  def create(booking)
    sql = 'INSERT INTO bookings (book_from, book_to, confirmed, space_id) VALUES ($1, $2, $3, $4);'
    sql_params = [booking.book_from,booking.book_to, booking.confirmed, booking.space_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def check_dates(id, date_from, date_to)
    
    
  end
  # def
  #   sql = 'SELECT * FROM Product_sales
  #           WHERE From_date >= '2013-01-01' AND To_date <= '2013-01-20''


end