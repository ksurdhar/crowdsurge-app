# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({ username: 'guest123', password: 'password'})

tickets = Ticket.create([{ event: 'SXSW', description: "A musical fiesta for your earbuds!", user_id: 1 }, 
                         { event: 'Bonnaroo', description: "Banjo-tastic tunes for the soul!", user_id: 1 }, 
                         { event: 'Coachella', description: "A hippy jammy good time!", user_id: 1 }])

