10.times do 
  User.create(
    firstname: Faker::Internet.first_name,
    lastname: Faker::Internet.last_name, 
    email: Faker::Internet.safe_email
  )
end

20.times do
  Movie.create(
    title: Faker::Book.title, 
    release_date: Faker::Date.backward(365),
    director: [Faker::Name.first_name, Faker::Name.last_name].join(' '),
    runtime_in_minutes: Faker::Number.number(3),
    image: Faker::Placeholdit.image,
    description: Faker::Lorem.paragraph 
  )
end

10.times do 
  Review.create(
    # make sure combo of user & movie ID is unique!
    user_id: Faker::Number.between(1, User.count),
    movie_id: Faker::Number.between(1, Movie.count),
    text: Faker::Lorem.paragraph,
    rating_out_of_ten: Faker::Number.between(1, 10)
  )
end

10.times do
  Actor.create(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name
  )     
end

10.times do
  Role.create(
    # make sure combo of actor & movie IDs is unique!
    movie_id: Faker::Number.between(1, Movie.count),
    actor_id: Faker::Number.between(2, Actor.count),
    name: Faker::Name.title
  )
end
