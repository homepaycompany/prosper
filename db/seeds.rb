p "Destroying users..."
User.destroy_all

p "Creating users..."
user_test = User.new(email: "test@gmail.com", password: "123456")
user_test.save!
