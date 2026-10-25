# ==========================================
# Movie Ticket Booking System - Seed Data
# ==========================================

puts "Seeding Movie Ticket Booking System..."

# 1. Admin user
admin = User.find_or_initialize_by(email: "admin@movieticket.test")
admin.name = "Cinema Administrator"
admin.role = "admin"
admin.password = "AdminPass123!" if admin.new_record?
admin.save!

# 2. Customer user
customer = User.find_or_initialize_by(email: "customer@movieticket.test")
customer.name = "Test Customer"
customer.role = "customer"
customer.password = "CustomerPass123!" if customer.new_record?
customer.save!

# 3. Movies
movies_data = [
  {
    title: "Jawan",
    genre: "Action",
    language: "Hindi",
    duration: 169,
    release_date: Date.new(2023, 9, 7)
  },
  {
    title: "Dangal",
    genre: "Drama",
    language: "Hindi",
    duration: 161,
    release_date: Date.new(2016, 12, 23)
  },
  {
    title: "3 Idiots",
    genre: "Comedy",
    language: "Hindi",
    duration: 170,
    release_date: Date.new(2009, 12, 25)
  },
  {
    title: "Interstellar",
    genre: "Science Fiction",
    language: "English",
    duration: 169,
    release_date: Date.new(2014, 11, 7)
  }
]

movies_data.each do |data|
  movie = Movie.find_or_initialize_by(title: data[:title])
  movie.assign_attributes(data.merge(created_by: admin))
  movie.save!
end

# 4. Cinema
cinema = Cinema.find_or_initialize_by(
  name: "PVR Treasure Island Mall"
)
cinema.location =
  "4th Floor, Treasure Island Mall, 11 M.G. Road, South Tukoganj, Indore, Madhya Pradesh 452001"
cinema.created_by = admin
cinema.save!

# 5. Screen
screen = Screen.find_or_initialize_by(
  cinema: cinema,
  name: "Screen 1"
)
screen.created_by = admin
screen.save!

# 6. Seats
%w[A B C D].each do |row|
  (1..10).each do |number|
    seat = Seat.find_or_initialize_by(
      screen: screen,
      row_label: row,
      seat_number: number
    )
    seat.created_by = admin
    seat.save!
  end
end

# 7. Future shows
# These are demonstration schedules and prices,
# not verified live PVR show listings.
base_time = Time.current.beginning_of_day + 1.day + 10.hours

show_times = [
  { offset: 0.hours, price: 250 },
  { offset: 4.hours, price: 220 },
  { offset: 8.hours, price: 200 },
  { offset: 12.hours, price: 300 }
]

movies_data.each_with_index do |data, index|
  movie = Movie.find_by!(title: data[:title])
  schedule = show_times[index]

  show = Show.find_or_initialize_by(
    movie: movie,
    screen: screen,
    starts_at: base_time + schedule[:offset]
  )

  show.assign_attributes(
    ends_at: base_time + schedule[:offset] + movie.duration.minutes,
    ticket_price: schedule[:price],
    created_by: admin
  )
  show.save!
end

puts "Seed data created successfully!"
puts "Admin: admin@movieticket.test"
puts "Customer: customer@movieticket.test"
puts "Movies: #{Movie.count}"
puts "Cinemas: #{Cinema.count}"
puts "Screens: #{Screen.count}"
puts "Seats: #{Seat.count}"
puts "Shows: #{Show.count}"