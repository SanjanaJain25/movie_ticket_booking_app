# Movie Ticket Booking System

## Overview

The Movie Ticket Booking System is a Ruby on Rails application designed to manage movies, cinemas, screens, show schedules, seat reservations, bookings, and customer reviews.

The project focuses on database design, ActiveRecord associations, validations, and booking logic.

## Features

- Movie Management: Store movie details and search or filter movies by title, genre, and language.
- Cinema and Screen Management: Organize cinemas, screens, and seats.
- Show Management: Manage show timings and ticket prices, with validation to prevent overlapping shows on the same screen.
- Seat Availability: View available seats for a particular show.
- Ticket Booking: Book multiple seats and calculate the total ticket amount.
- Duplicate Booking Prevention: Prevent already-reserved seats from being booked again.
- Booking Cancellation: Cancel a booking and release its seat reservations.
- Booking History: Retrieve a customer's booking history, including cancelled bookings.
- Customer Reviews: Submit movie and cinema reviews with rating and feedback validations.
- Role Support: Distinguish between admin and customer users in the model layer.

## Technologies Used

- Ruby
- Ruby on Rails
- SQLite
- ActiveRecord
- BCrypt password authentication

## Prerequisites

Install the following before running the application:

- Ruby
- Bundler
- SQLite
- Rails dependencies listed in the Gemfile

## Installation and Setup

1. Clone the repository:

   git clone <https://github.com/SanjanaJain25/movie_ticket_booking_app>

2. Navigate to the project directory:

   cd movie_ticket_booking_app

3. Install dependencies:

   bundle install

4. Create and prepare the database:

   bin/rails db:create
   bin/rails db:migrate

5. Start the Rails server:

   bin/rails server

6. Open the application at:

   `http://localhost:3000`

## Testing Through Rails Console

Start the Rails console:

bin/rails console

commands:

```ruby
customer = User.register(name: "Flow Test Customer", email: "flowtest@example.com", password: "SecurePass123!")
customer.authenticate("SecurePass123!")

Movie.all
MovieCatalog.new.search_movies("City")
MovieCatalog.new.filter_movies(genre: "Drama")

Show.all
show = Show.find(2)

MovieCatalog.new.available_seats(show.id)

customer = User.find_by!(email: "flowtest@example.com")
booking = Booking.book_seats!(user: customer, show: show, seat_ids: [2, 3])

booking.details
customer.booking_history
MovieCatalog.new.available_seats(show.id)

booking.cancel!
booking.reload.status
MovieCatalog.new.available_seats(show.id)

movie = Movie.find_by!(title: "City Lights")
MovieReview.create!(user: customer, movie: movie, rating: 5, feedback: "Excellent movie with a great story")
MovieReview.all

cinema = Cinema.find_by!(name: "PVR Central Mall")
CinemaReview.create!(user: customer, cinema: cinema, rating: 4, feedback: "Clean cinema and comfortable seating")
CinemaReview.all
```

The application can also be tested through model methods for booking seats, cancelling bookings, and validating reviews.

## Database Models

The project includes the following models:

- User
- Movie
- Cinema
- Screen
- Seat
- Show
- Booking
- BookingSeat
- SeatReservation
- MovieReview
- CinemaReview

## Notes

This project is being developed as a Ruby on Rails backend assignment. Features should be considered implemented only to the extent supported by the current codebase.
