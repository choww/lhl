# USERS 
10.times do 
  User.create(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name, 
    email: Faker::Internet.safe_email,
    password: 'canada'
  )
end

# MOVIES
20.times do
  Movie.create(
    title: Faker::Book.title, 
    release_date: Faker::Date.backward(365),
    director: [Faker::Name.first_name, Faker::Name.last_name].join(' '),
    runtime_in_minutes: Faker::Number.number(3),
    image: File.open("#{Rails.root}/app/assets/images/placeholder.png"),
    description: Faker::Lorem.paragraph 
  )
end

# REVIEWS
50.times do
  begin
    user_id = Faker::Number.between(1, User.count)
    movie_id = Faker::Number.between(1, Movie.count)
  end while Review.find_by(user_id: user_id, movie_id: movie_id)
    
  Review.create(
    user_id: user_id,
    movie_id: movie_id,
    text: Faker::Lorem.paragraph,
    rating_out_of_ten: Faker::Number.between(1, 10)
  )
end

# ACTORS
10.times do
  Actor.create(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name
  )     
end

# ROLES
begin
  movie_id = Faker::Number.between(1, Movie.count)
  actor_id = Faker::Number.between(1, Actor.count)
end while Role.find_by(movie_id: movie_id, actor_id: actor_id) 

10.times do
  Role.create(
    movie_id: movie_id,
    actor_id: actor_id,
    name: Faker::Name.title
  )
end
