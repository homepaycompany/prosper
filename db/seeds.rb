p "Destroying users..."
User.destroy_all

p "Creating users..."
user_admin = User.create!(email: "admin@gmail.com", password: "123456", city: "Marseille", zip_code: "13002")
user_test_1 = User.create!(email: "test1@gmail.com", password: "123456", city: "Marseille", zip_code: "13002")
user_test_2 = User.create!(email: "test2@gmail.com", password: "123456", city: "Toulouse", zip_code: "31001")

p "Destroying flats..."
Flat.destroy_all

p "Destroying wishes..."
Wish.destroy_all
