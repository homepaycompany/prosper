p "Destroying users..."
User.destroy_all

p "Creating users..."
user_admin = User.create!(email: "admin@gmail.com", password: "123456")
user_test_1 = User.create!(email: "test1@gmail.com", password: "123456")
user_test_2 = User.create!(email: "test2@gmail.com", password: "123456")

p "Destroying flats..."
Flat.destroy_all

p "Creating flats..."
flat_1 = Flat.create!(title: "Studio 30m2 Oberkampf", description: "Superbe
         studio de 30m² situé à Oberkampf. Travaux à prévoir", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 2, average_rooms: 3, bedrooms: 1, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 9750, average_price: 10500, size: 30,
         average_size: 45, image_url: "https://img6.leboncoin.fr/ad-large/103dcbddfc365bf07ddece080abea8d154b76bd1.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1302866170.htm")
flat_2 = Flat.create!(title: "T3 de 60m2", description: "T3 très lumineux dans le 11ème arrondissement. Travaux à prévoir", address: "20 rue Parmentier, Paris",
         floor: 3, rooms: 3, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), price: 10050, average_price: 10500, size: 30,
         average_size: 45)
flat_3 = Flat.create!(title: "Maison à Vincennes", description: "Superbe
         studio de 30m² situé à Oberkampf. Travaux à prévoir", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 4, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 9750, average_price: 10500, size: 30,
         average_size: 45)
flat_4 = Flat.create!(title: "Studio 30m2 Oberkampf", description: "Superbe
         studio de 30m² situé à Oberkampf. Travaux à prévoir", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 4, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 9750, average_price: 10500, size: 30,
         average_size: 45)
flat_5 = Flat.create!(title: "Studio 30m2 Oberkampf", description: "Superbe
         studio de 30m² situé à Oberkampf. Travaux à prévoir", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 4, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 9750, average_price: 10500, size: 30,
         average_size: 45)
flat_6 = Flat.create!(title: "Studio 30m2 Oberkampf", description: "Superbe
         studio de 30m² situé à Oberkampf. Travaux à prévoir", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 4, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 9750, average_price: 10500, size: 30,
         average_size: 45)

p "Destroying wishes..."
Wish.destroy_all

p "Creating wishes..."
wish_1 = Wish.create(flat: flat_1, user: user_test_1)
wish_2 = Wish.create(flat: flat_2, user: user_test_1)
wish_3 = Wish.create(flat: flat_6, user: user_test_1)
wish_4 = Wish.create(flat: flat_3, user: user_test_2)
wish_5 = Wish.create(flat: flat_4, user: user_test_2)
