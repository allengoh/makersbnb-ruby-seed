require 'booking_repository'

RSpec.describe BookingRepository do
  
  it "lists all the bookings" do
    repo = BookingRepository.new
    bookings = repo.all # list all bookings 
    expect(bookings.length).to eq(2)
    expect(bookings[0].date_booked).to eq('2022-08-15')
    expect(bookings[1].space_id).to eq('2')
    
  end

  it "creates a new booking" do 

    repo = BookingRepository.new

    booking = Booking.new
    booking.date_booked = "2022-08-20"
    booking.confirmed = "t"
    booking.space_id = 2

    repo.create(booking)

    bookings = repo.all

    expect(bookings.length).to eq(3)
    expect(bookings.last.date_booked).to eq("2022-08-20")
    expect(bookings.last.confirmed).to eq("t")

  end
  
end