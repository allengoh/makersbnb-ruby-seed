require 'booking_repository'

def reset_makersbnb
  seed_sql = File.read('spec/seeds/ql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnbt' })
  connection.exec(seed_sql)
end

RSpec.describe BookingRepository do
  before(:each) do 
    reset_table
  end
  
  it "lists all the bookings" do
    repo = BookingRepository.new
    bookings = repo.all # list all bookings 
    expect(bookings.length).to eq(2)
    expect(bookings[0].book_from).to eq('2022-08-15')
    expect(bookings[0].book_to).to eq('2022-08-16')

    expect(bookings[1].space_id).to eq('2')

  end

  it "creates a new booking" do 

    repo = BookingRepository.new

    booking = Booking.new
    booking.book_from = "2022-08-20"
    booking.confirmed = "t"
    booking.space_id = 2

    repo.create(booking)

    bookings = repo.all

    expect(bookings.length).to eq(3)
    expect(bookings.last.book_from).to eq("2022-08-20")
    expect(bookings.last.confirmed).to eq("t")

  end
  
end