require 'booking_repository'

def reset_makersbnb
  seed_sql = File.read('spec/seeds/ql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test'})
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
  
  context 'check no booking between a date range' do
    it "returns true when date range outside of booking" do
      repo = BookingRepository.new
      expect(repo.check_no_booking(1,'2022-02-01','2022-04-01')).to eq(true)
    end

    it "returns true when there is an unconfirmed booking in the range" do
      repo = BookingRepository.new
      expect(repo.check_no_booking(1,'2022-08-15','2022-08-16')).to eq(true)
    end

    it "returns false when there is a confirmed booking in the date range" do
      repo = BookingRepository.new
      expect(repo.check_no_booking(2,'2022-08-16','2022-08-17')).to eq(false)
    end

    # Test cases:
    #1 booking[0] (2022-02-01, 2022-04-01) => true
    #2 booking[0] (2022-08-15, 2022-08-17) => false

    # if confirmed = 'f'  return true

    #3 booking[0] (2022-02-01, 2022-04-01) => true
    #4 booking[0] (2022-08-15, 2022-08-17) => false

    # Database:
    # '2022-08-15','2022-08-16', 'f', 1
    # '2022-08-16','2022-08-17', 't', 2

    # Results:
    # true => there is no bookings
    # false => there is a booking
  end
end