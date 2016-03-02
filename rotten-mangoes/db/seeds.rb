# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(firstname: 'dude', lastname: 'bro', email: 'dude@bro.ca', password: 'canada')
User.create(firstname: 'files', lastname: 'folders', email: 'files@folders.gov', password: 'canada')
User.create(firstname: 'nil', lastname: 'class', email: 'nil@class.ca', password: 'canada')

