p "Destroying users..."
User.destroy_all

p "Creating users..."
user_test = User.create!(email: "test@gmail.com", password: "123456")

p "Destroying flats..."
Flat.destroy_all

p "Creating flats..."
flat_1 = Flat.create!(title: "Studio 30m2 Oberkampf", description: "Superbe
         studio de 30m² situé à Oberkampf. Travaux à prévoir", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 2, average_rooms: 3, bedrooms: 1, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 9750, average_price: 10500, size: 30,
         average_size: 45)
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
