p "Destroying users..."
User.destroy_all

p "Creating users..."
user_admin = User.create!(email: "admin@gmail.com", password: "123456")
user_test_1 = User.create!(email: "test1@gmail.com", password: "123456")
user_test_2 = User.create!(email: "test2@gmail.com", password: "123456")

p "Destroying wishes..."
Wish.destroy_all

p "Destroying cities..."
City.destroy_all

p "Creating cities..."
toulouse = City.create!(name: "Toulouse", zip_code: "31000")
marseille = City.create!(name: "Marseille", zip_code: "13001, 13002, 13003, 13004, 13005, 13006, 13007, 13008, 13009, 13010, 13011, 13012, 13013, 13014, 13015, 13016")

p "Destroying city accesses..."
CityAccess.destroy_all

p "Creating city accesses..."
access_user_test_1 = CityAccess.create!(city_id: toulouse.id, user_id: user_test_1.id)
access_user_test_1 = CityAccess.create!(city_id: marseille.id, user_id: user_test_2.id)
